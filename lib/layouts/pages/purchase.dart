import 'package:flutter/material.dart';

import '../../services/global.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembelian'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Pembelian'),
        ),
      ),
    );
  }
}
