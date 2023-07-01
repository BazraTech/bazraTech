import 'package:flutter/material.dart';


import 'Commicationfordriver/getmessage.dart';
import 'Driverprofile/driverprofile.dart';
import 'driverHomepage.dart';

class BottomTabBarPage extends StatefulWidget {
  @override
  _BottomTabBarPageState createState() => _BottomTabBarPageState();
}

class _BottomTabBarPageState extends State<BottomTabBarPage> {
  int _currentIndex = 0;

  List<Widget> _contentWidgets = [
    Driver_Hompage(),
    getMessage(),
    driverProfile(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.messenger,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 30,
      ),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _contentWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false, // hide selected labels
        showUnselectedLabels: false,
        items: _bottomNavBarItems,
      ),
    );
  }
}
