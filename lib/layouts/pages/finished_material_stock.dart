import 'package:flutter/material.dart';

import '../../services/global.dart';

class FinishedMaterialStock extends StatefulWidget {
  const FinishedMaterialStock({super.key});

  @override
  State<FinishedMaterialStock> createState() => _FinishedMaterialStockState();
}

class _FinishedMaterialStockState extends State<FinishedMaterialStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Jadi'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Produk jadi'),
        ),
      ),
    );
  }
}
