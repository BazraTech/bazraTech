import 'package:bazralogin/Page/Screen/Communication.dart';
import 'package:bazralogin/Page/Screen/Profile.dart';
import 'package:bazralogin/Page/Screen/Tracking.dart';
import 'package:bazralogin/Page/Screen/itemsscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Category(),
      },
      {
        'page': Tracking(),
      },
      {
        'page': const Communication(),
      },
      {
        'page': const Profile(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 60,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Colors.white,
              unselectedItemColor: const Color.fromRGBO(66, 74, 109, 1),
              selectedItemColor: const Color.fromRGBO(25, 205, 54, 1),
              showUnselectedLabels: true,
              currentIndex: _selectedPageIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Tracking',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.messenger), label: "communication"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
