import 'package:flutter/material.dart';

class TableCUstomQty extends StatelessWidget {
  final List details;

  const TableCUstomQty({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        horizontalInside: BorderSide(color: Colors.grey),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const {
        0: FlexColumnWidth(6),
        1: FlexColumnWidth(1),
      },
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'Nama Barang',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'Qty',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        for (var detail in details)
          TableRow(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail['kode_produk'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      detail['nama_produk'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(
                  detail['qty'],
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
