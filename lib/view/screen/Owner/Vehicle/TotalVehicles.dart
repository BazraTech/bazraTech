import 'dart:async';
import 'dart:convert';

import 'package:bazralogin/config/APIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import '../../../../const/constant.dart';
import 'modifyVehicleStatus.dart';
import 'vehicleDetial.dart';

class OwnersVehicle extends StatefulWidget {
  OwnersVehicle({super.key});

  @override
  State<OwnersVehicle> createState() => _OwnersVehicleState();
}

class _OwnersVehicleState extends State<OwnersVehicle> {
  TextEditingController _searchController = TextEditingController();
  List findVehicle = [];
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  List vehicleStatusList = [];
  bool _isLoading = true;
  vehicleFetchbystatus() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(Uri.parse(ApIConfig.allvehicle),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      vehicleStatusList = mapResponse['vehiclesINF'];
      print(vehicleStatusList);
      setState(() {
        _isLoading = false;
        vehicleStatusList = vehicleStatusList;
        findVehicle = vehicleStatusList;
      });

      return vehicleStatusList;
    } else {
      throw Exception('not loaded ');
    }
  }

  void initState() {
    super.initState();
    vehicleFetchbystatus();
  }

  @override
  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = vehicleStatusList.where((driver) {
        final name = driver['vehicleName'].toLowerCase();

        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || plateNumber.contains(inputName);
      }).toList();
    });
    setState(() {
      findVehicle = findVehicle;
    });
  }

  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  String? phoneNumber;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.white), // Set the color of the icon
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: kPrimaryColor,
            title: Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: screenWidth * 0.12),
              height: 40,
              color: Colors.white,
              child: Center(
                child: TextField(
                  onChanged: driversSearch,
                  decoration: const InputDecoration(
                    hintText: 'Driver  or Plate No.',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: _isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 130),
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Container(
                            width: screenWidth - 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0,
                                        4), // Adjust the offset to control the shadow's position
                                  ),
                                ]),
                            height: screenHeight * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.25,
                                    child: const Text(
                                      "Vehicles",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.23,
                                    child: const Text(
                                      "Driver",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.37,
                                    child: const Text(
                                      " Plate Number",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                            children: findVehicle.map((vehicle) {
                          Color borderLeftColor =
                              Colors.red; // Define the default border color

                          if (vehicle['status'] == "ONROUTE") {
                            borderLeftColor = Colors
                                .green; // Update border color based on condition
                          } else if (vehicle['status'] == "INSTOCK") {
                            borderLeftColor = Colors
                                .blue; // Update border color for the else case
                          }
                          return Container(
                              height: screenHeight * 0.25,
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            vehicleDetial(
                                              id: vehicle['id'],
                                            )),
                                  );
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      bottomLeft: Radius.circular(6.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: borderLeftColor, width: 6),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(3.3),
                                            bottomLeft: Radius.circular(3.3),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  4), // Adjust the offset to control the shadow's position
                                            ),
                                          ],
                                        ),
                                        height: screenHeight * 0.03,
                                        width: screenHeight,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 30, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: screenWidth * 0.2,
                                                    child: Text(
                                                      vehicle['vehicleName'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.2,
                                                    child:
                                                        vehicle["driverName"] ==
                                                                "null"
                                                            ? Text("__")
                                                            : Text(
                                                                vehicle[
                                                                    'driverName'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontSize: 14,
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.37,
                                                    child: Text(
                                                      vehicle['plateNumber'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  height: screenHeight * 0.03,
                                                  width: screenWidth * 0.03,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          236, 240, 243, 1),
                                                      shape: BoxShape.circle),
                                                  margin: EdgeInsets.only(
                                                      top: 5, left: 110),
                                                  child: Icon(
                                                    Icons.local_shipping,
                                                    color: borderLeftColor,
                                                  ),
                                                )),
                                            vehicle['status'] == "ONROUTE"
                                                ? Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 110, top: 10),
                                                      child: Text(
                                                        vehicle['status'],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                : vehicle['status'] == "PARKED"
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            left: 110, top: 10),
                                                        child: Text(
                                                          vehicle['status'],
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : vehicle['status'] ==
                                                            "INSTOCK"
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 94,
                                                                    top: 10),
                                                            child: Text(
                                                              vehicle['status'],
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 64,
                                                                    top: 10),
                                                            child: Text(
                                                              vehicle['status'],
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ModifyVehileStatus(
                                                      plateNumber: vehicle[
                                                          'plateNumber'],
                                                      sttatus:
                                                          vehicle['status'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: screenWidth,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .shade300, // Border color
                                                      width:
                                                          2.0, // Border width
                                                    ),
                                                  ),
                                                  height: 40,
                                                  child: const Center(
                                                    child: Text(
                                                      "Update Status",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }).toList()),
                      ],
                    ))),
    );
    ;
  }
}