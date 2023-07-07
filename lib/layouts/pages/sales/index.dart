import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:impact_driver/services/global.dart';

import '../../../components/row-data.dart';
import '../../../services/action.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List listData = [];
  final ScrollController _scrollController = ScrollController();
  Map loadMore = {'current_page': 1, 'last_page': 1, 'limit': 12};
  final search = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toString() ==
          _scrollController.position.maxScrollExtent.toString()) {
        if (loadMore['current_page'] < loadMore['last_page']) {
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
      Map data = await ActionMethod.getNoAuth(
        'Sales_order/all',
        {
          "num_page": loadMore["limit"].toString(),
          "page": loadMore["current_page"].toString()
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
            'last_page': data['max_page'],
            'limit': 7
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
      loadMore = {'current_page': 1, 'last_page': 0, 'limit': 7};
    });

    await getData();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengiriman'),
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
                          return RowData(
                              title: data['sales_order']['kode'],
                              subtitle: data['customer']['nama'] +
                                  ' - ' +
                                  data['customer']['alamat'],
                              value: data['sales_order']['tanggal'].toString());
                        },
                      ),
                    )
                  else
                    const Expanded(
                      child: NotFound(
                        label: 'Belum ada transaksi',
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
