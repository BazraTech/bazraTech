import 'package:flutter/material.dart';
import '../shared/constant.dart';

import 'Alert/Alert.dart';

import 'Notification/Notification.dart';
import 'Post/Posts.dart';
import 'Post/histrory.dart';

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
                CargoListView(),
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
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.add),
                        child: Text(
                          "Post Cargo",
                          style: TextStyle(
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
                          "Cargo Post History",
                          style: TextStyle(
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
