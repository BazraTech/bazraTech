import 'package:bazralogin/const/constant.dart';
import 'package:bazralogin/view/screen/Driver/driverReport.dart';
import 'package:bazralogin/view/screen/Owner/report/toggelReport.dart';
import 'package:flutter/material.dart';

import '../../../../Model/ApiConfig.dart';
import '../Vehicle/vehicleStatus.dart';
import 'ownerReport.dart';

class ownerReportstatus extends StatefulWidget {
  ownerReportstatus({super.key});
  static bool isPressed = true;

  @override
  State<ownerReportstatus> createState() => _ownerReportstatusState();
}

class _ownerReportstatusState extends State<ownerReportstatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Report",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.black), // Set the color of the icon
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [MyScreen(), MyScreen(), MyScreen()],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,
                  indicatorPadding: EdgeInsets.all(4),
                  indicatorColor: Colors.white,
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
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
                    Container(
                      width: screenWidth * 0.23,
                      child: Tab(
                        text: "Daily Report",
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.23,
                      child: Tab(
                        text: "Weekly Report ",
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.26,
                      child: Tab(
                        text: "Monthly Report",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
