import 'dart:async';

import 'package:bazralogin/Model/communication.dart';
import 'package:bazralogin/Page/Owner/TripManagement/setTrip.dart';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../Model/communicationList.dart';
import '../../../config/ApiConfig.dart';
import '../../../config/vehicleWithdriver.dart';
import '../../../const/constant.dart';

import '../Vehicle/vehicleDetial.dart';
import '../Vehicle/vehicleStatus.dart';

class AvailableVehicle extends StatefulWidget {
  const AvailableVehicle({super.key});
  @override
  State<AvailableVehicle> createState() => _AvailableVehicleState();
}

class _AvailableVehicleState extends State<AvailableVehicle> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  late var timer;

  Future vehicleFetch() async {
    final Result = await Vehicles_withDrivers.assignedDrivers();
    if (mounted) {
      timer = Timer.periodic(
          Duration(seconds: 5),
          (Timer t) => setState(() {
                this.Result = Result;
              }));
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    setState(() {});
    if (enterKeyboard.isEmpty) {
    } else {
      final findVehicle = Result.where((driver) {
        final name = driver['vehicleName'].toLowerCase();
        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputPlateNumber = enterKeyboard.toLowerCase();
        return name.contains(inputName) ||
            plateNumber.contains(inputPlateNumber);
      }).toList();
      setState(() {
        this.Result = findVehicle;
      });
    }
  }

  void initState() {
    super.initState();
    timer = Duration(seconds: 5);

    vehicleFetch();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final double categoryHeight = screenHeight * 0.30;

    print(Result);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                onChanged: vehiclesSearch,
                decoration: InputDecoration(
                  hintText: 'Driver Name or Plate No.',
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        body: Result.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    children: Result.map((vehicle) {
                  return Container(
                    height: screenHeight * 0.08,
                    child: InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Settrips(
                                  drivername: vehicle['driverName'],
                                  platenumber: vehicle['plateNumber'],
                                  startLocation: "4444",
                                  destination: "4443",
                                  startDate: "2-11-14",
                                  tripType: "LONG")),
                        );
                      }),
                      child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: Text(
                                  " " + vehicle['vehicleName'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              vehicle['driverName'] != null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: screenWidth * 0.28,
                                      child: Text(
                                        vehicle['driverName'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ))
                                  : Container(
                                      width: screenWidth * 0.25,
                                      child: const Text(
                                        "Unassigned",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                              Container(
                                width: screenWidth * 0.1,
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  vehicle['vehicleCatagory'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              Container(
                                  height: screenHeight * 0.038,
                                  width: screenWidth * 0.25,
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kPrimaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      " " + vehicle['status'],
                                      style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ))
                            ]),
                      ),
                    ),
                  );
                }).toList()),
              ));
  }
}
