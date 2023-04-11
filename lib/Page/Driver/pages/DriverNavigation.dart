import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import 'Trips.dart';
import 'driverHm.dart';

class DriverNavigations extends StatelessWidget {
  DriverNavigations({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Driver_Hompage(),
            TotalTrips(),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Container(
            child: TabBar(
              isScrollable: false,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.all(4),
              indicatorColor: Colors.white,
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }

                return Colors.transparent;
              }),
              tabs: [
                Tab(
                  text: "Home",
                ),
                Tab(
                  text: "Total Trips",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
