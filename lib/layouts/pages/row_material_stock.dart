import 'package:flutter/material.dart';

import '../../services/global.dart';

class RowMaterialStock extends StatefulWidget {
  const RowMaterialStock({super.key});

  @override
  State<RowMaterialStock> createState() => _RowMaterialStockState();
}

class _RowMaterialStockState extends State<RowMaterialStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahan Baku'),
        backgroundColor: GlobalConfig.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Bahan Baku'),
        ),
      ),
    );
  }
}
