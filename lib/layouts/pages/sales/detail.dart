import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../components/row_detail.dart';
import '../../../components/table_detail.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class SalesDetail extends StatefulWidget {
  final Map content;

  const SalesDetail({
    super.key,
    required this.content,
  });

  @override
  State<SalesDetail> createState() => _SalesDetailState();
}

class _SalesDetailState extends State<SalesDetail> {
  Map selectData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.postNoAuth(
          'Sales_order/detail', {"id": widget.content['id']});
      if (data['statusCode'] == 200) {
        setState(() {
          selectData = data['values'];
        });
      } else {
        setState(() {
          selectData = {};
        });
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Penjualan'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: selectData.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectData['sales_order']['kode'],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: GlobalConfig.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          RowDetail(
                            label: 'Tanggal',
                            value: selectData['sales_order']['tanggal'],
                            type: 'list',
                          ),
                          RowDetail(
                            label: 'Pelanggan',
                            value: selectData['customer']['nama'],
                            type: 'list',
                          ),
                          RowDetail(
                            label: 'Alamat',
                            value: selectData['customer']['alamat'],
                            type: 'list',
                          ),
                          RowDetail(
                            label: 'DETAIL BARANG',
                            color: Colors.amber.shade100,
                            type: 'header',
                          ),
                          const SizedBox(height: 5),
                          TableCustom(
                            type: 'sales',
                            details: selectData['detail_sales_order'],
                            subtotal: selectData['sales_order']['subtotal'],
                            discount: selectData['sales_order']['nilai_diskon'],
                            ppn: selectData['sales_order']['total_ppn'],
                            total: selectData['sales_order']['total'],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            : const NotFound(
                label: 'Belum ada transaksi',
                size: 'normal',
                isButton: false,
              ),
      ),
    );
  }
}
