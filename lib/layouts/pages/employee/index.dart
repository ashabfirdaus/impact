import 'package:flutter/material.dart';
import 'package:impact_driver/layouts/pages/employee/presence.dart';
import '../../../services/global.dart';
import 'all_data.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Karyawan');
  bool showBackButton = true;
  final searchText = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

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
        searchFocusNode.requestFocus();
        showBackButton = false;
        customIcon = const Icon(Icons.cancel);
        customSearchBar = ListTile(
          leading: const Icon(
            Icons.search,
            color: Colors.white,
            // size: 28,
          ),
          title: TextField(
            focusNode: searchFocusNode,
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
        searchFocusNode.unfocus();
        customSearchBar = const Text('Karyawan');
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
                  'Semua Karyawan',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  'Presensi Hari ini',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: GlobalConfig.primaryColor,
        ),
        body: TabBarView(
          children: [
            AllEmployee(searchText: searchText),
            Presence(searchText: searchText),
          ],
        ),
      ),
    );
  }
}
