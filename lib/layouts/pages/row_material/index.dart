import 'package:flutter/material.dart';
import 'package:impact_driver/layouts/pages/row_material/all_data.dart';
import 'package:impact_driver/layouts/pages/row_material/limit_stock.dart';

import '../../../services/global.dart';

class RowMaterial extends StatefulWidget {
  const RowMaterial({super.key});

  @override
  State<RowMaterial> createState() => _RowMaterialState();
}

class _RowMaterialState extends State<RowMaterial> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bahan Baku'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Semua Bahan Baku',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Limit Stok',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: GlobalConfig.primaryColor,
        ),
        body: const TabBarView(
          children: [
            AllRowMaterial(),
            RowMaterialStockLimit(),
          ],
        ),
      ),
    );
  }
}
