import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import '../../../../config/ApiConfig.dart';

import '../../../../config/driverCount.dart';
import 'OwnersDriver.dart';
import 'getDriverByStatus.dart';

class DriverStatus extends StatelessWidget {
  DriverStatus({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: TabBarView(
          children: [
            OwnersDriver(),
            getDriversBystatus(driverStatus: 'ASSIGNED', driverList: 'drivers'),
            getDriversBystatus(
                driverStatus: 'UNASSIGNED', driverList: 'drivers'),
            getDriversBystatus(driverStatus: 'PERMIT', driverList: 'drivers'),
            getDriversBystatus(driverStatus: 'ONROUTE', driverList: 'drivers'),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Container(
            child: TabBar(
              isScrollable: true,
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
                  text: TranslationUtil.text("Total Drivers"),
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      CountDrivers.totalDrivers.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: TranslationUtil.text("Assigned Drivers"),
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      CountDrivers.totalAssigned.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: TranslationUtil.text("UnAssigned Drivers"),
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      CountDrivers.totalUnassigned.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: TranslationUtil.text("Permit"),
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      CountDrivers.totalPermit.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: TranslationUtil.text("OnRoute Drivers"),
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      CountDrivers.totalOnroute.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
