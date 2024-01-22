import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:impact_driver/components/table_custom_qty.dart';
import '../../../components/row_detail.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/not_found.dart';
import '../../../utils/notification_bar.dart';

class DetailTransaction extends StatefulWidget {
  final Map content;

  const DetailTransaction({
    super.key,
    required this.content,
  });

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  Map selectData = {};
  bool isReceiver = false;
  Map statusDelivery = {
    '0': {'label': 'Dikirim', 'color': Colors.blue},
    '1': {'label': "Selesai", 'color': Colors.green}
  };

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.postNoAuth(
          'Surat_jalan/detail', {'id': widget.content['id']});
      if (data['statusCode'] == 200) {
        setState(() {
          selectData = data['values'];
        });
      } else {
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  void acceptDelivery() {
    Navigator.pushNamed(context, '/accept-delivery', arguments: {
      'id': selectData['surat_jalan']['id'].toString(),
      'title': selectData['surat_jalan']['kode'],
    }).then((value) async {
      if (value == null) {
        // print('kosong');
      } else {
        if (value is Map) {
          getData();
        }
      }
    });
  }

  void previewBuktiFoto() {
    Navigator.pushNamed(context, '/preview-image',
        arguments: {'image_url': selectData['surat_jalan']['foto_bukti']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PENGIRIMAN'),
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
                        selectData['surat_jalan']['kode'],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: GlobalConfig.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: statusDelivery[selectData['surat_jalan']
                            ['status_kirim']]['color'],
                      ),
                      child: Text(
                        statusDelivery[selectData['surat_jalan']
                            ['status_kirim']]['label'],
                        style: const TextStyle(
                          color: Colors.white,
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
                            value: selectData['surat_jalan']['tanggal'],
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
                          TableCUstomQty(details: selectData['detail_produk'])
                          // TableCustom(
                          //   type: 'sales',
                          //   details: selectData['detail_sales_order'],
                          //   subtotal: selectData['sales_order']['subtotal'],
                          //   discount: selectData['sales_order']['nilai_diskon'],
                          //   ppn: selectData['sales_order']['total_ppn'],
                          //   total: selectData['sales_order']['total'],
                          // )
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
