import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:impact_driver/components/table-detail.dart';
import 'package:impact_driver/layouts/pages/home/chart_data.dart';
import 'package:impact_driver/services/global.dart';
import '../../../components/button_home.dart';
import '../../../services/action.dart';
import '../../../utils/notification_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List listData = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // getData();
    super.initState();
  }

  // Future<void> getData() async {
  //   EasyLoading.show(status: 'Loading...');
  //   try {

  //     if (data['statusCode'] == 200) {
  //       setState(() {

  //       });
  //     } else {
  //       setState(() {
  //         listData = [];
  //       });
  //       NotificationBar.toastr(data['message'], 'error');
  //     }
  //   } catch (e) {
  //     NotificationBar.toastr('Internal Server Error', 'error');
  //   }

  //   EasyLoading.dismiss();
  // }

  Future<void> refreshGetData() async {
    // await getData();
    return;
  }

  void detailTransaction(object, index) {
    Navigator.pushNamed(context, '/detail-transaction', arguments: {
      'id': object['surat_jalan']['id'].toString(),
      'title': object['surat_jalan']['kode'],
    }).then((value) async {
      if (value == null) {
        // print('kosong');
      }
      // else {
      //   if (value is Map) {
      //     Map res = value;
      //     setState(() {
      //       listData[index]['approval'] = res['data']['approval'];
      //       listData[index]['payment_status'] = res['data']['payment_status'];
      //       listData[index]['total_payment'] = res['data']['total_payment'];
      //     });
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshGetData,
          child: Column(children: [
            Image.asset(
              'images/logo.png',
              width: 150,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const LineChartSample1(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Bahan Baku',
                  action: () =>
                      Navigator.pushNamed(context, '/row-material-stock'),
                  width: 100,
                ),
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Produk Jadi',
                  action: () =>
                      Navigator.pushNamed(context, '/finished-material-stock'),
                  width: 100,
                ),
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Pembelian',
                  action: () => Navigator.pushNamed(context, '/purchase'),
                  width: 100,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Penjualan',
                  action: () => Navigator.pushNamed(context, '/sales'),
                  width: 100,
                ),
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Presensi',
                  action: () => Navigator.pushNamed(context, '/presence'),
                  width: 100,
                ),
                ButtonHome(
                  icon: Image.asset('images/logo.png', width: 70.0),
                  label: 'Pengiriman',
                  action: () => Navigator.pushNamed(context, '/delivery'),
                  width: 100,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
