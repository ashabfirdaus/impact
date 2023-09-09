import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartView extends StatelessWidget {
  final List dataChart;
  const LineChartView({
    super.key,
    required this.dataChart,
  });

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [];

    for (var i = 0; i < dataChart.length; i++) {
      data.add(_SalesData(
          dataChart[i].asMap()[0], dataChart[i].asMap()[1].toDouble()));
    }

    // print(data);

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      // Chart title
      title: ChartTitle(text: 'Grafik Penjualan'),
      // Enable legend
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_SalesData, String>>[
        LineSeries<_SalesData, String>(
          dataSource: data,
          xValueMapper: (_SalesData sales, _) => sales.year,
          yValueMapper: (_SalesData sales, _) => sales.sales,
          name: 'Sales',
          width: 3,
          // Enable data label
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
