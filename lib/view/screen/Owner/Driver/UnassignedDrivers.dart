import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/Model/communication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../../Model/communicationList.dart';
import '../../../../Model/ApiConfig.dart';
import '../../../../const/constant.dart';
import '../../../../widget/SearchPage.dart';
import 'vehicleOnStock.dart';

class UnassignedDrivers extends StatefulWidget {
  const UnassignedDrivers({super.key});
  @override
  State<UnassignedDrivers> createState() => _UnassignedDriversState();
}

class _UnassignedDriversState extends State<UnassignedDrivers> {
  TextEditingController _searchController = TextEditingController();

  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  List findVehicle = [];
  late var timer;
  List totalVehicles = [];
  bool _isLoading = true;
// fetch unassigndriver
  unassigned() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            'http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/UNASSIGNED'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      List results = mapResponse['drivers'];

      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    }
  }

//  search unassign driver
  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['driverName'].toLowerCase();
        final plateNumber = driver['phoneNumber'].toLowerCase();
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
    unassigned();
    timer = Duration(seconds: 5);
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
    final double categoryHeight = screenHeight * 0.30;
    print('yee');
    print(Result);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 80,
            leadingWidth: 24,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
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
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true, // Center align the title
              title: Container(
                margin: EdgeInsets.only(top: 5, left: screenWidth * 0.08),
                width: screenWidth - 46,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: driversSearch,
                    decoration: InputDecoration(
                        hintText: 'Driver Name or Plate No.',
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.01),
                            child: Icon(Icons.search)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15), // Adjust vertical padding as needed
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.08,
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: screenWidth * 0.03,
                                  ),
                                  width: screenWidth * 0.28,
                                  child: const Text(
                                    "Drivers",
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
                                    "Drivers Phone",
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
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.01),
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
                          children: findVehicle.map((driver) {
                        return Container(
                          height: screenHeight * 0.1,
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VehicleOnstock(
                                            licenseNumber:
                                                driver['licenseNumber'])),
                              );
                            }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Container(
                                      width: screenWidth * 0.28,
                                      margin: EdgeInsets.only(),
                                      child: Text(
                                        " " + driver['driverName'].toString(),
                                        style: const TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    driver['phoneNumber'] != null
                                        ? Container(
                                            width: screenWidth * 0.28,
                                            child: Text(
                                              driver['phoneNumber'],
                                              style: const TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 12,
                                                  color: Colors.black87),
                                            ))
                                        : Container(
                                            width: screenWidth * 0.28,
                                            child: const Text(
                                              "Unknown",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                    driver['status'] != null
                                        ? Container(
                                            height: screenHeight * 0.038,
                                            width: screenWidth * 0.28,

                                            // decoration: BoxDecoration(
                                            //   borderRadius:
                                            //       BorderRadius.circular(6),
                                            //   color: kPrimaryColor,
                                            // ),
                                            child: Center(
                                              child: Text(
                                                " " + driver['status'],
                                                style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ))
                                        : Container(
                                            height: screenHeight * 0.038,
                                            width: screenWidth * 0.28,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: kPrimaryColor,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "UnAssigned",
                                                style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 12,
                                                    color: Colors.white),
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