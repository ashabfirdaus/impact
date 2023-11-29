import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:impact_driver/layouts/pages/home/line_chart_view.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../components/button_home.dart';
import '../../../services/action.dart';
import '../../../utils/notification_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List listData1 = [];
  Map<String, double> listData2 = {'Tidak ada': 0};
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.utc(DateTime.now().year, DateTime.now().month + 1)
        .subtract(const Duration(days: 1)),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getData1();
    getData2();
    super.initState();
  }

  Future<void> getData1() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.getNoAuth(
        'stats/sales_order_graph',
        {
          'dateStart':
              '${selectedDates.start.day}-${selectedDates.start.month}-${selectedDates.start.year}',
          'dateEnd':
              '${selectedDates.end.day}-${selectedDates.end.month}-${selectedDates.end.year}',
        },
      );
      if (data['statusCode'] == 200) {
        setState(() {
          listData1 = data['values'];
        });
      } else {
        setState(() {
          listData1 = [];
        });
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  Future<void> getData2() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.getNoAuth(
        'stats/get_stats_produk',
        {
          'dateStart':
              '${selectedDates.start.day}-${selectedDates.start.month}-${selectedDates.start.year}',
          'dateEnd':
              '${selectedDates.end.day}-${selectedDates.end.month}-${selectedDates.end.year}',
        },
      );

      if (data['statusCode'] == 200) {
        setState(() {
          var temp = {};
          if (data['values']['data'].length > 0) {
            for (String key in data['values']['data'].keys) {
              temp[key] = data['values']['data'][key] + 0.0;
            }

            listData2 = {...temp};
          } else {
            listData2 = {'Tidak ada': 0};
          }
        });
      } else {
        setState(() {
          listData2 = {'Tidak ada': 0};
        });
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  Future<void> refreshGetData() async {
    await getData1();
    await getData2();
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

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
    const Color.fromRGBO(92, 231, 226, 1),
    const Color.fromARGB(255, 92, 231, 168),
    const Color.fromARGB(255, 231, 92, 92),
    const Color.fromARGB(255, 108, 92, 231),
    const Color.fromARGB(255, 231, 92, 92)
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: refreshGetData,
            child: Column(children: [
              Image.asset(
                'images/logo.png',
                width: 150,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(238, 236, 229, 229)),
                onPressed: () async {
                  final DateTimeRange? dateTimeRange =
                      await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  if (dateTimeRange != null) {
                    setState(() {
                      selectedDates = dateTimeRange;
                    });
                    getData1();
                    getData2();
                  }
                },
                child: Text(
                  "Tanggal : ${DateFormat('dd MMM yyyy').format(selectedDates.start)} - ${DateFormat('dd MMM yyyy').format(selectedDates.end)}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 106, 105, 105),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: LineChartView(
                  dataChart: listData1,
                ),
              ),
              const Text(
                'Grafik Penjualan Produk',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              PieChart(
                dataMap: listData2,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 2.5,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 42,
                centerText: null,
                legendOptions: const LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: true,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonHome(
                    icon: Image.asset('images/material.png', width: 70.0),
                    label: 'Bahan Baku',
                    action: () =>
                        Navigator.pushNamed(context, '/row-material-stock'),
                    width: 100,
                  ),
                  ButtonHome(
                    icon: Image.asset('images/product.png', width: 70.0),
                    label: 'Produk Jadi',
                    action: () => Navigator.pushNamed(
                        context, '/finished-material-stock'),
                    width: 100,
                  ),
                  ButtonHome(
                    icon: Image.asset('images/purchase.png', width: 70.0),
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
                    icon: Image.asset('images/sales.png', width: 70.0),
                    label: 'Penjualan',
                    action: () => Navigator.pushNamed(context, '/sales'),
                    width: 100,
                  ),
                  ButtonHome(
                    icon: Image.asset('images/employee.png', width: 70.0),
                    label: 'Karyawan',
                    action: () => Navigator.pushNamed(context, '/employee'),
                    width: 100,
                  ),
                  ButtonHome(
                    icon: Image.asset('images/delivery.png', width: 70.0),
                    label: 'Pengiriman',
                    action: () => Navigator.pushNamed(context, '/delivery'),
                    width: 100,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
