import 'package:flutter/material.dart';
import '../shared/constant.dart';

import 'Alert/Alert.dart';
import 'Bill/Bill.dart';
import 'Notification/Notification.dart';
import 'Work/Active_Work_detail.dart';

class BottomNav_Active extends StatelessWidget {
  BottomNav_Active({super.key});
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
            body: const TabBarView(
              children: [
                ActiveWorkDetail(),
                BillStatus(),
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
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.dashboard),
                        child: Text(
                          "Vehicle List",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.attach_money_rounded),
                        child: Text(
                          "Bill",
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
