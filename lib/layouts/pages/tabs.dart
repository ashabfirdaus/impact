import 'package:flutter/material.dart';
import '../../services/global.dart';
import 'home/index.dart';
import 'home/profile.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const Home(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2),
              label: 'Akun',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          selectedItemColor: GlobalConfig.primaryColor),
    );
  }
}
