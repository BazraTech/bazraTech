import 'package:bazralogin/Page/Screen/Tracking/CarlocationTacking.dart';
import 'package:bazralogin/Page/Screen/communication/Communication.dart';
import 'package:bazralogin/Page/Screen/tripManagement.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../Model/report.dart';
import '../Page/Screen/Report/CarReport.dart';
import '../Page/Screen/itemsscreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List Screens = [
    const Category(),
    const displaycarlaction(),
    const Communication(),
    const Trip(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //backgroundColor: kPrimaryColor,
      bottomNavigationBar: AnimatedContainer(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(40),
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Color(0xFFA7A9AF),
        //       offset: Offset(28, 28),
        //       blurRadius: 30,
        //       spreadRadius: 0.0,
        //       // inset:isPressed,
        //     ),
        //     BoxShadow(
        //         color: Colors.white, offset: Offset(-5, -5), blurRadius: 80),
        //   ],
        // ),
        duration: const Duration(microseconds: 10),
        child: CurvedNavigationBar(
          index: _selectedIndex,
          animationDuration: const Duration(microseconds: 1),
          backgroundColor: Colors.white,
          items: const [
            Icon(
              Icons.home,
              semanticLabel: "Dashboard",
              size: 40,
            ),
            Icon(Icons.location_on, semanticLabel: "Dashboard", size: 40),
            Icon(
              Icons.messenger_outline_rounded,
              size: 40,
            ),
            Icon(
              Icons.person,
              size: 40,
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: Screens[_selectedIndex],
    );
  }
}
