import 'dart:async';
import 'dart:convert';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../../Model/communicationList.dart';
import '../../../../Model/ApiConfig.dart';
import '../../../../const/constant.dart';
import '../../../../widget/SearchPage.dart';
import 'UnassignedDrivers.dart';
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
  List findVehicle = [];
  // late var timer;
  List totalVehicles = [];
  var client = http.Client();
  final storage = new FlutterSecureStorage();
  bool _isLoading = true;
// fetch car on maintaining
  unassignedDrivers() async {
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/All/Driver'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      List results = mapResponse['unassigned'];
      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    } else {
      throw Exception('not loaded ');
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['vehicleName'].toLowerCase();
        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputPlateNumber = enterKeyboard.toLowerCase();
        return name.contains(inputName) ||
            plateNumber.contains(inputPlateNumber);
      }).toList();
    });

    setState(() {
      findVehicle = findVehicle;
    });
  }

  void initState() {
    super.initState();
    unassignedDrivers();

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
    _searchController.dispose();
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
            leadingWidth: 24,
            toolbarHeight: 80,
            centerTitle: true,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //           UnassignedDrivers()),
                    // );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backgroundColor: kPrimaryColor,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenWidth,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: vehiclesSearch,
                    decoration: InputDecoration(
                      hintText: 'Driver Name or Plate No.',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15), // Adjust vertical padding as needed
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
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
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: screenHeight * 0.08,
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.25,
                                  child: const Text(
                                    "Vehicles",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.25,
                                  child: const Text(
                                    "Plate No",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.28,
                                  child: const Text(
                                    " Status",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                          children: findVehicle.map((vehicle) {
                        return Container(
                          height: screenHeight * 0.1,
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(children: [
                                    Container(
                                      width: screenWidth * 0.25,
                                      child: Text(
                                        " " + vehicle['vehicleName'],
                                        style: const TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.25,
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        vehicle['plateNumber'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito",
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                        height: screenHeight * 0.03,
                                        width: screenWidth * 0.25,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(6),
                                        //   color: kPrimaryColor,
                                        // ),
                                        child: Center(
                                          child: Text(
                                            " " + vehicle['status'],
                                            style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: "Nunito",
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ))
                                  ]),
                                ),
                              ),
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
