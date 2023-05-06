import 'dart:async';

import 'package:bazralogin/Model/communication.dart';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../../Model/communicationList.dart';
import '../../../../config/ApiConfig.dart';

import '../../../../config/vehiclesWithoutDrivers.dart';
import '../../../../const/constant.dart';
import '../../../../widget/SearchPage.dart';
import 'assignDriver.dart';

class VehicleOnstock extends StatefulWidget {
  String? licenseNumber;
  VehicleOnstock({
    super.key,
    this.licenseNumber,
  });
  @override
  State<VehicleOnstock> createState() => _VehicleOnstockState();
}

class _VehicleOnstockState extends State<VehicleOnstock> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  late var timer;
  List totalVehicles = [];
  Future vehicles_withUnassigned_Driver() async {
    final Result = await Vehicles_withoutDrivers.unassignedDrivers();
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
    vehicles_withUnassigned_Driver();
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
    print(widget.licenseNumber);
    final double categoryHeight = screenHeight * 0.30;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: kPrimaryColor,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(top: 5, right: 15),
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
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
          ),
          backgroundColor: kBackgroundColor,
          body: Result.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.08,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: screenWidth * 0.2,
                                child: const Text(
                                  "Vehicles",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: const Text(
                                  "Drivers",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: const Text(
                                  "Plate No",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.2,
                                child: const Text(
                                  " Status",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                          children: Result.map((vehicle) {
                        return Container(
                          height: screenHeight * 0.08,
                          child: InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        assignDriver(
                                          licenseNumber:
                                              '${widget.licenseNumber}',
                                          plateNumber: vehicle['plateNumber'],
                                        )),
                              );
                            }),
                            child: Card(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 10),
                                      child: Text(
                                        " " + vehicle['vehicleName'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.25,
                                      child: const Text(
                                        "Unassigned",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.09,
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        vehicle['plateNumber'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Container(
                                        height: screenHeight * 0.03,
                                        width: screenWidth * 0.22,
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: kPrimaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            " " + vehicle['status'],
                                            style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ))
                                  ]),
                            ),
                          ),
                        );
                      }).toList()),
                    ],
                  ),
                )),
    );
  }
}
