import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:impact_driver/components/row-detail.dart';
import 'package:impact_driver/components/table-detail.dart';

import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class PurchaseDetail extends StatefulWidget {
  final Map content;

  const PurchaseDetail({
    super.key,
    required this.content,
  });

  @override
  State<PurchaseDetail> createState() => _PurchaseDetailState();
}

class _PurchaseDetailState extends State<PurchaseDetail> {
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
          'Purchase_order/detail', {"id": widget.content['id']});
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
        title: const Text('Transaksi'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: selectData.isNotEmpty
            ? Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectData['purchase_order']['kode'],
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
                            value: selectData['purchase_order']['tanggal'],
                            type: 'list',
                          ),
                          RowDetail(
                            label: 'Supplier',
                            value: selectData['suplier']['nama'],
                            type: 'list',
                          ),
                          RowDetail(
                            label: 'Alamat',
                            value: selectData['suplier']['alamat'],
                            type: 'list',
                          ),
                          const Divider(color: Colors.grey),
                          RowDetail(
                            label: 'Detail',
                            color: Colors.amber.shade100,
                            type: 'header',
                          ),
                          const SizedBox(height: 10),
                          TableCustom(
                            details: selectData['detail_purchase_order'],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Expanded(
                child: NotFound(
                  label: 'Belum ada transaksi',
                  size: 'normal',
                  isButton: false,
                ),
              ),
      ),
    );
  }
}
