import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/config/APIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

import '../../../Theme/clippbox.dart';
import '../../../const/constant.dart';

class availabelMarket extends StatefulWidget {
  availabelMarket({super.key});

  @override
  State<availabelMarket> createState() => _availabelMarketState();
}

class _availabelMarketState extends State<availabelMarket> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  List findVehicle = [];
  List drivers = [];
  bool _isLoading = true;

  List Result = [];
  List totalVehicles = [];
  marketFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await client.get(
          Uri.parse('http://64.226.104.50:9090/Api/Vehicle/All/Market'),
          headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(
            key: "totalDrivers", value: data["totalDrivers"].toString());
        setState(() {
          _isLoading = false;
          Result = data['availableMarket'];
          findVehicle = Result;
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
  }
  // search  driver

  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['cargoType'].toLowerCase();
        final continer = driver['weight'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || continer.contains(inputLicense);
      }).toList();
    });
    setState(() {
      findVehicle = findVehicle;
    });
  }

  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;

  String? phoneNumber;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  void initState() {
    super.initState();
    marketFetch();
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: kPrimaryColor,
            title: Container(
              margin: EdgeInsets.only(right: screenWidth * 0.12),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: TextField(
                  onChanged: driversSearch,
                  decoration: const InputDecoration(
                    hintText: 'Cargo type or Weight',
                    helperStyle: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: AppFonts.smallFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
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
          body: SingleChildScrollView(
              child: _isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 130),
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        if (findVehicle == null || findVehicle.isEmpty)
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: screenHeight * 0.2,
                              ),
                              width: 300,
                              height: 300,
                              child: Align(
                                alignment: Alignment.center,
                                child: Lottie.asset(
                                  'assets/images/noapidatas.json', // Replace with your animation file path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        else
                          Column(
                              children: findVehicle.map((driver) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: screenHeight * 0.315 - 20,
                                        margin: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    4), // Adjust the offset to control the shadow's position
                                              ),
                                            ]),
                                        width: screenWidth - 44,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.zero,
                                              child: ClipPath(
                                                clipper: QuarterCircleClipper(),
                                                child: Container(
                                                  width: screenWidth - 44,
                                                  height: 30,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: screenWidth * 0.02),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: screenWidth * 0.16,
                                                    child: Row(
                                                      children: [
                                                        Text("From",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 2),
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                          child: Icon(
                                                            Icons.trip_origin,
                                                            color: Colors.red,
                                                            size: 10,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  CustomPaint(
                                                    size: Size(
                                                        screenWidth * 0.06, 2),
                                                    painter: DashLinePainter(),
                                                  ),
                                                  Container(
                                                    width: screenWidth * 0.07,
                                                    child: Icon(
                                                      Icons.local_shipping,
                                                      color: Colors.red,
                                                      size: 23,
                                                    ),
                                                  ),
                                                  CustomPaint(
                                                    size: Size(
                                                        screenWidth * 0.06, 2),
                                                    painter: DashLinePainter(),
                                                  ),
                                                  SizedBox(
                                                      width: screenWidth * 0.08,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2),
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Icon(
                                                              Icons.trip_origin,
                                                              color:
                                                                  Colors.blue,
                                                              size: 10,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Container(
                                                    child: Text(
                                                      "To".toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                        width:
                                                            screenWidth * 0.27,
                                                        child: Text(
                                                          "Time",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: AppFonts
                                                                  .smallFontSize,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.02),
                                                    width: screenWidth * 0.35,
                                                    child: Text(
                                                      driver["pickUp"]
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                SizedBox(
                                                    width: screenWidth * 0.25,
                                                    child: Text(
                                                      driver["dropOff"]
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Container(
                                                  width: screenWidth * 0.2,
                                                  child: Text(
                                                    driver["date"].toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: AppFonts
                                                            .smallFontSize,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                )
                                              ],
                                            ),
                                            CustomPaint(
                                              size: Size(screenWidth * 0.9, 2),
                                              painter: DashLinePainter(),
                                            ),
                                            Container(
                                              width: screenWidth,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              "CargoType",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.06,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                              driver["cargoType"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              "Packaging",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.06,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                              driver["packaging"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              "Weight",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.06,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                              driver["weight"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              "Status",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.06,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              driver["status"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.28,
                                                            child: Text(
                                                              "Remaining",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.06,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.38,
                                                            child: Text(
                                                              driver["remaining"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                      ],
                    ))),
    );
    ;
  }
}
