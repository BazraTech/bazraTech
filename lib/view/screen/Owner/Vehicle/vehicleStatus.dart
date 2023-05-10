import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';


import '../../../../Model/ApiConfig.dart';
import '../Communication/communicationPage.dart';

import '../Vehicle/TotalVehicles.dart';
import '../Vehicle/getvehicleBystautus.dart';
import '../communication/Communication.dart';

class VehicleStatus extends StatefulWidget {
  VehicleStatus({super.key});
  static bool isPressed = true;

  @override
  State<VehicleStatus> createState() => _VehicleStatusState();
}

class _VehicleStatusState extends State<VehicleStatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            OwnersVehicle(),
            getvehicleBystatus(route: 'ONROUTE', onroute: 'inRoutelist'),
            getvehicleBystatus(route: 'PARKED', onroute: 'parkedList'),
            getvehicleBystatus(route: 'INSTOCK', onroute: 'stockedList'),
            getvehicleBystatus(
                route: 'MAINTAINING', onroute: 'maintainingList'),
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
                  text: "Total Vehicle",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      APIService.totalVehicle.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: "OnRoute  ",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      APIService.totalinRouteVehiclesVehicles.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: " Parked",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      APIService.totalparkedVehicle.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: "Instock ",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      APIService.totalStockedVehicles.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: "MAINTAINING",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red[400],
                    child: Text(
                      APIService.totalMaintainingVehicles.toString(),
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
