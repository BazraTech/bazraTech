import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../Owner/Communication/communicationPage.dart';
import '../Owner/Home/HomePage.dart';
import '../Owner/Profile/Profile.dart';
import '../Owner/Tracking/caronMap.dart';
import 'Driverprofile/driverprofile.dart';
import 'driverHomepage.dart';

class driverBottomn extends StatelessWidget {
  driverBottomn({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 243, 1),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                Driver_Hompage(),
                Communication(),
                driverProfile(),
              ],
            ),
            bottomNavigationBar: Container(
              height: screenHeight * 0.1,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    child: TabBar(
                        indicatorColor: Colors.transparent,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.055),
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.messenger,
                              color: Colors.black,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Ionicons.person,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
