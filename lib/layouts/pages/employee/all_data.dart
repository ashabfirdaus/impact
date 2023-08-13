import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../components/row_data.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class AllEmployee extends StatefulWidget {
  final TextEditingController searchText;
  const AllEmployee({
    super.key,
    required this.searchText,
  });

  @override
  State<AllEmployee> createState() => _AllEmployeeState();
}

class _AllEmployeeState extends State<AllEmployee> {
  List listData = [];
  final ScrollController _scrollController = ScrollController();
  Map loadMore = {'current_page': 1, 'next_page': 1, 'limit': 12};

  @override
  void initState() {
    getData();
    super.initState();

    widget.searchText.addListener(detectKeyword);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toString() ==
          _scrollController.position.maxScrollExtent.toString()) {
        if (loadMore['current_page'] == loadMore['next_page']) {
          getData();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void detectKeyword() {
    setStateIfMounted(() {
      loadMore['current_page'] = 1;
    });
    getData();
  }

  Future<void> getData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.getNoAuth(
        'Karyawan/all',
        {
          "num_page": loadMore["limit"].toString(),
          "page": loadMore["current_page"].toString(),
          "keyword": widget.searchText.text.toString()
        },
      );

      if (data['statusCode'] == 200) {
        setState(() {
          if (loadMore['current_page'] == 1) {
            listData = data['values'];
          } else {
            listData.addAll(data['values']);
          }

          loadMore = {
            'current_page': loadMore['current_page'] + 1,
            'next_page': data['next_page'],
            'limit': 12
          };
        });
      } else {
        setState(() {
          listData = [];
        });
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  Future<void> refreshGetData() async {
    setState(() {
      loadMore = {'current_page': 1, 'next_page': 0, 'limit': 12};
    });

    await getData();
    return;
  }

  void historyPresence(id) {
    Navigator.pushNamed(context, '/history-presence', arguments: {'id': id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => GlobalConfig.unfocus(context),
        child: Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: refreshGetData,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (listData.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: listData.isEmpty ? 0 : listData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = listData[index];
                          return RowData(
                            title: data['nama'],
                            subtitle: data['jabatan'],
                            action: () => historyPresence(data['id']),
                          );
                        },
                      ),
                    )
                  else
                    const Expanded(
                      child: NotFound(
                        label: 'Belum ada data',
                        size: 'normal',
                        isButton: false,
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
