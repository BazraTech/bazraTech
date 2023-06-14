import 'package:flutter/material.dart';
import '../../cargo.dart';
import '../../localization/app_localizations.dart';
import '../../shared/constant.dart';

import '../../smart.dart';
import '../Alert/Alert.dart';

import '../Notification/Notification.dart';
import 'Posts.dart';
import 'histrory.dart';

class Post_BottomNav extends StatelessWidget {
  Post_BottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                Posts(),
                HistoryCargo(),
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
                    isScrollable: false,
                    indicatorWeight: 3,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.add),
                        child: Text(
                          AppLocalizations.of(context)
                                  ?.translate("Post Cargo") ??
                              "Post Cargo",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.history_edu),
                        child: Text(
                          AppLocalizations.of(context)
                                  ?.translate("Cargo History") ??
                              "Cargo History",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
