import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'pages/driverHomePage.dart';

class BottomNavDriver extends StatelessWidget {
  BottomNavDriver({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: const TabBarView(
              children: [
                DriverHomePage(),
                DriverHomePage(),
                DriverHomePage(),
              ],
            ),
            bottomNavigationBar: Container(
              height: screenHeight * 0.1,
              decoration: const BoxDecoration(color: kPrimaryColor),
              child: Container(
                width: screenWidth,
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(12),
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    indicatorWeight: 3,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.home),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.location_on),
                        child: Text(
                          "All Trips",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.report),
                        child: Text(
                          "Report",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
