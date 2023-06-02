import 'package:bazralogin/const/constant.dart';
import 'package:bazralogin/view/screen/Driver/driverReport.dart';
import 'package:flutter/material.dart';

import '../../../../Model/ApiConfig.dart';
import '../Owner/Vehicle/vehicleStatus.dart';

class driverReportstatus extends StatefulWidget {
  driverReportstatus({super.key});
  static bool isPressed = true;

  @override
  State<driverReportstatus> createState() => _driverReportstatusState();
}

class _driverReportstatusState extends State<driverReportstatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 243, 1),
        body: TabBarView(
          children: [driverReport(), driverReport(), driverReport()],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  indicatorColor: Colors.transparent,
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
                      width: screenWidth * 0.2,
                      child: Tab(
                        text: "Daily",
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.2,
                      child: Tab(
                        text: "Weekly ",
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.2,
                      child: Tab(
                        text: " Monthly",
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
