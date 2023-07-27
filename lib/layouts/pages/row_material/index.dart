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
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Bahan Baku');
  bool showBackButton = true;
  final searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  void searchActive() {
    setState(() {
      if (customIcon.icon == Icons.search) {
        showBackButton = false;
        customIcon = const Icon(Icons.cancel);
        customSearchBar = ListTile(
          leading: const Icon(
            Icons.search,
            color: Colors.white,
            // size: 28,
          ),
          title: TextField(
            controller: searchText,
            decoration: const InputDecoration(
              hintText: 'Masukkan kata kunci ...',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = const Text('Bahan Baku');
        showBackButton = true;
        setState(() {
          searchText.text = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: searchActive,
              icon: customIcon,
            )
          ],
          automaticallyImplyLeading: showBackButton,
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Semua Bahan Baku',
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
        body: TabBarView(
          children: [
            AllRowMaterial(searchText: searchText),
            RowMaterialStockLimit(searchText: searchText),
          ],
        ),
      ),
    );
  }
}
