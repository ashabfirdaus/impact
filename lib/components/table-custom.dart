import 'package:flutter/material.dart';

class TableCustom extends StatelessWidget {
  const TableCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      // columnWidths: const <int, TableColumnWidth>{
      // 0: IntrinsicColumnWidth(),
      // 1: FlexColumnWidth(),
      // 2: FixedColumnWidth(64),
      // },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
            Container(
                padding: const EdgeInsets.all(5), child: const Text('coba1')),
          ],
        ),
      ],
    );
  }
}
