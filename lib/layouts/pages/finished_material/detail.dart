import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../components/row_detail.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class FinishedMaterialDetail extends StatefulWidget {
  final Map content;

  const FinishedMaterialDetail({
    super.key,
    required this.content,
  });

  @override
  State<FinishedMaterialDetail> createState() => _FinishedMaterialDetailState();
}

class _FinishedMaterialDetailState extends State<FinishedMaterialDetail> {
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
          'Bahan/detail', {"id": widget.content['id']});
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
        title: const Text('Produk Jadi'),
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
                          selectData['kode'],
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
                              label: 'Nama Barang',
                              value: selectData['nama'],
                              type: 'list',
                            ),
                            RowDetail(
                              label: 'Harga',
                              value: CurrencyFormat.convertToIdr(
                                  double.parse(selectData['harga']), 2),
                              type: 'list',
                            ),
                            RowDetail(
                              label: 'Stok',
                              value: selectData['qty'],
                              type: 'list',
                            ),
                            RowDetail(
                              label: 'Minimal Stok',
                              value: selectData['min_qty'],
                              type: 'list',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const NotFound(
                label: 'Belum ada data',
                size: 'normal',
                isButton: false,
              ),
      ),
    );
  }
}
