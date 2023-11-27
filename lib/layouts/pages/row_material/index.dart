import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../components/row_data.dart';
import '../../../services/action.dart';
import '../../../services/global.dart';
import '../../../utils/notification_bar.dart';

class RowMaterial extends StatefulWidget {
  const RowMaterial({super.key});

  @override
  State<RowMaterial> createState() => _RowMaterialState();
}

class _RowMaterialState extends State<RowMaterial> {
  final searchText = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  late int activeMenu = 0;
  final ScrollController _scrollController = ScrollController();
  String baseUrl = 'Bahan/all';
  bool showBackButton = true;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('BAHAN BAKU');
  List listData = [];
  Map loadMore = {'current_page': 1, 'next_page': '', 'limit': 12};
  Timer? timer;

  @override
  void initState() {
    getData();
    searchText.addListener(detectKeyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toString() ==
          _scrollController.position.maxScrollExtent.toString()) {
        if (loadMore['next_page'] != '') {
          getData();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    searchText.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void detectKeyword() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }

    timer = Timer(const Duration(milliseconds: 350), () async {
      setState(() {
        loadMore['current_page'] = 1;
      });

      await getData();
    });
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
        customSearchBar = const Text('BAHAN BAKU');
        showBackButton = true;
        setState(() {
          searchText.text = '';
        });
      }
    });
  }

  void changeData(index) {
    setState(() {
      activeMenu = index;
      loadMore = {'current_page': 1, 'next_page': '', 'limit': 12};
      baseUrl = index == 0 ? 'Bahan/all' : 'Bahan/stok_kurang';
      searchText.text = '';
      listData = [];
    });

    getData();
  }

  Future<void> getData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      Map data = await ActionMethod.getNoAuth(
        baseUrl,
        {
          "num_page": loadMore["limit"].toString(),
          "page": loadMore["current_page"].toString(),
          "keyword": searchText.text.toString()
        },
      );

      if (data['statusCode'] == 200) {
        setState(() {
          if (loadMore['current_page'] == 1) {
            listData = data['values'];
          } else {
            listData.addAll(data['values']);
          }

          loadMore = {
            'current_page': loadMore['current_page'] + 1,
            'next_page': data['next_page'],
            'limit': 12
          };
        });
      } else {
        setState(() {
          listData = [];
        });
        NotificationBar.toastr(data['message'], 'error');
      }
    } catch (e) {
      NotificationBar.toastr('Internal Server Error', 'error');
    }

    EasyLoading.dismiss();
  }

  Future<void> refreshGetData() async {
    setState(() {
      loadMore = {'current_page': 1, 'next_page': '', 'limit': 12};
    });

    await getData();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: GlobalConfig.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: searchActive,
            icon: customIcon,
          )
        ],
        automaticallyImplyLeading: showBackButton,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshGetData,
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => changeData(0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GlobalConfig.primaryColor,
                            border: Border(
                              bottom: BorderSide(
                                color: activeMenu == 0
                                    ? const Color.fromARGB(255, 222, 217, 217)
                                    : GlobalConfig.primaryColor,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'SEMUA BAHAN BAKU',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => changeData(1),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GlobalConfig.primaryColor,
                            border: Border(
                              bottom: BorderSide(
                                color: activeMenu == 1
                                    ? const Color.fromARGB(255, 222, 217, 217)
                                    : GlobalConfig.primaryColor,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'MENYENTUH MINIMAL STOK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: listData.isEmpty ? 0 : listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = listData[index];
                    return RowData(
                      title: data['nama'],
                      subtitle: data['kode'],
                      value: data['qty'],
                      action: () {
                        Navigator.pushNamed(context, '/row-material-detail',
                            arguments: {
                              'id': data['id'],
                              'nama': data['nama']
                            });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
