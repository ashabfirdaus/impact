import 'package:flutter/material.dart';
import 'package:impact_driver/services/global.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Penjualan'),
        ),
      ),
    );
  }
}
