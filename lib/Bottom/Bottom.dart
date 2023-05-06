import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../view/screen/Owner/Communication/communicationPage.dart';
import '../view/screen/Owner/Home/HomePage.dart';
import '../view/screen/Owner/Profile/Profile.dart';
import '../view/screen/Owner/Tracking/caronMap.dart';

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
                displaycarlaction(),
                Communication(),
                Profile(),
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
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.home),
                        child: Text(
                          TranslationUtil.text("Home"),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.location_on),
                        child: Text(
                          TranslationUtil.text("GPS Tracking"),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.messenger),
                        child: Text(
                          TranslationUtil.text("Communication"),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.person),
                        child: Text(
                          TranslationUtil.text("Profile"),
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
