import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../Driver/Driverprofile/driverprofile.dart';
import '../Owner/Communication/communicationPage.dart';
import '../Owner/Home/HomePage.dart';
import '../Owner/Profile/Profile.dart';
import '../Owner/Tracking/caronMap.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                OwenerHomepage(),
                Communication(),
                Communication(),
                driverProfile()
              ],
            ),
            bottomNavigationBar: Container(
              height: screenHeight * 0.1,
              decoration: const BoxDecoration(color: Colors.white),
              child: Container(
                width: screenWidth,
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(12),
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    indicatorWeight: 3,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        child: Text(
                          TranslationUtil.text("Home"),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        child: Text(
                          TranslationUtil.text("GPS Tracking"),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.messenger,
                          color: Colors.black,
                        ),
                        child: Text(
                          TranslationUtil.text("Communication"),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        child: Text(
                          TranslationUtil.text("Profile"),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
