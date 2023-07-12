import 'package:flutter/material.dart';

import '../utils/currency_format.dart';

class TableCustom extends StatelessWidget {
  final List details;
  final String discount;
  final String ppn;
  final String subtotal;
  final String total;
  final String type;

  const TableCustom(
      {super.key,
      required this.details,
      required this.discount,
      required this.ppn,
      required this.subtotal,
      required this.total,
      required this.type});

  Map countTotal() {
    var qty = 0;
    double price = 0;
    for (var i = 0; i < details.length; i++) {
      qty += int.parse(details[i]['qty']);
      price += double.parse(details[i]['subtotal']) -
          double.parse(details[i]['diskon']);
    }

    return {'qty': qty.toString(), 'price': price.toString()};
  }

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
        2: FlexColumnWidth(3),
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
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              alignment: Alignment.topRight,
              child: const Text(
                'Total',
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
                      type == 'purch'
                          ? detail['nama_bahan']
                          : detail['nama_produk'],
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                        "       @ ${CurrencyFormat.convertToIdr(double.parse(detail['harga']), 2)}")
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
              Container(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                alignment: Alignment.topRight,
                child: Text(
                  CurrencyFormat.convertToIdr(
                      double.parse(detail['subtotal']), 2),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'SUBTOTAL',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Text(
                countTotal()['qty'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              alignment: Alignment.topRight,
              child: Text(
                CurrencyFormat.convertToIdr(double.parse(subtotal), 2),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'Diskon',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              alignment: Alignment.topRight,
              child: Text(
                '(${CurrencyFormat.convertToIdr(double.parse(discount), 2)})',
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'ppn',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              alignment: Alignment.topRight,
              child: Text(
                CurrencyFormat.convertToIdr(double.parse(ppn), 2),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: const Text(
                'TOTAL',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              alignment: Alignment.topRight,
              child: Text(
                CurrencyFormat.convertToIdr(double.parse(total), 2),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
