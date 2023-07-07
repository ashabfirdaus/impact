import 'package:flutter/material.dart';
import 'package:impact_driver/layouts/pages/finished_material/all_data.dart';
import 'package:impact_driver/layouts/pages/finished_material/limit_stock.dart';
import '../../../services/global.dart';

class FinishedMaterial extends StatefulWidget {
  const FinishedMaterial({super.key});

  @override
  State<FinishedMaterial> createState() => _FinishedMaterialState();
}

class _FinishedMaterialState extends State<FinishedMaterial> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Produk Jadi'),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Semua Produk Jadi',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  'Limit Stok',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: GlobalConfig.primaryColor,
        ),
        body: const TabBarView(
          children: [
            AllFinishedMaterial(),
            FinishedMaterialStockLimit(),
          ],
        ),
      ),
    );
  }
}
