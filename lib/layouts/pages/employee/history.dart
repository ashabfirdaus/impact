import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../components/row_data_presence.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class HistoryPresence extends StatefulWidget {
  final Map content;
  const HistoryPresence({
    super.key,
    required this.content,
  });

  @override
  State<HistoryPresence> createState() => _HistoryPresenceState();
}

class _HistoryPresenceState extends State<HistoryPresence> {
  List listData = [];
  final ScrollController _scrollController = ScrollController();
  Map loadMore = {'current_page': 1, 'next_page': '', 'limit': 12};

  @override
  void initState() {
    getData();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toString() ==
          _scrollController.position.maxScrollExtent.toString()) {
        if (loadMore['next_page'] != '') {
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

  Future<void> getData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.postNoAuth(
        'Presensi/history',
        {
          "num_page": loadMore["limit"].toString(),
          "page": loadMore["current_page"].toString(),
          "karyawan_id": widget.content['id']
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
      loadMore = {'current_page': 1, 'next_page': '', 'limit': 12};
    });

    await getData();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Presensi'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
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
                          return RowDataPresence(
                            name: data['karyawan']['nama'],
                            actualIn: data['actual_in'] != null
                                ? data['actual_in']['jam']
                                : 'null',
                            actualOut: data['actual_out'] != null
                                ? data['actual_out']['jam']
                                : 'null',
                            date: data['jadwal']['tanggal'],
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
