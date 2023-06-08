import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/config/APIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';
import '../../../../const/constant.dart';

class availabelMarketfordriver extends StatefulWidget {
  availabelMarketfordriver({super.key});

  @override
  State<availabelMarketfordriver> createState() =>
      _availabelMarketfordriverState();
}

class _availabelMarketfordriverState extends State<availabelMarketfordriver> {
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
  // accept aviablemarket

  acceptMarket(String id) async {
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');

    final url =
        Uri.parse("http://64.226.104.50:9090/Api/Vehicle/AcceptCargo/$id");
    final response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    });
    final Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      String alertContent = jsonResponse["message"];
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('API Response'),
          content: Text(alertContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      String alertContent = jsonResponse["message"];
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(''),
          content: Text(alertContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
        final name = driver['driverName'].toLowerCase();

        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName);
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
                    hintText: 'Driver Name or Plate No',
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
                        Column(
                            children: Result.map((driver) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  acceptMarket(driver["id"].toString());
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: Container(
                                      height: screenHeight * 0.3,
                                      margin: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  4), // Adjust the offset to control the shadow's position
                                            ),
                                          ]),
                                      width: screenWidth - 44,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.zero,
                                                child: ClipPath(
                                                  clipper:
                                                      QuarterCircleClipper(),
                                                  child: Container(
                                                    width: screenWidth - 44,
                                                    height: 50,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: screenWidth * 0.02),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("From"),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 2),
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: Icon(
                                                        Icons.trip_origin,
                                                        color: Colors.black,
                                                        size: 10,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                CustomPaint(
                                                  size: Size(
                                                      screenWidth * 0.1, 2),
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
                                                      screenWidth * 0.1, 2),
                                                  painter: DashLinePainter(),
                                                ),
                                                SizedBox(
                                                    width: screenWidth * 0.2,
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
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                          child: Icon(
                                                            Icons.trip_origin,
                                                            color: Colors.black,
                                                            size: 10,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("To".toString()),
                                                      ],
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.1),
                                                    child: Icon(
                                                      Ionicons.time,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: screenWidth * 0.02),
                                                  width: screenWidth * 0.3,
                                                  child: Text(driver["pickUp"]
                                                      .toString())),
                                              SizedBox(
                                                width: screenWidth * 0.16,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.22,
                                                  child: Text(driver["dropOff"]
                                                      .toString())),
                                              Text(driver["date"].toString())
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
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
                                                              0.35,
                                                          child: Text(
                                                              "CargoType")),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(driver[
                                                                  "cargoType"]
                                                              .toString()))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(
                                                              "Packaging")),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(driver[
                                                                  "packaging"]
                                                              .toString()))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child:
                                                              Text("Weight")),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(
                                                              driver["weight"]
                                                                  .toString()))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child:
                                                              Text("Status")),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Container(
                                                          width: screenWidth *
                                                              0.38,
                                                          child: Text(
                                                              driver["status"]
                                                                  .toString()))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(
                                                              "Remaining")),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Container(
                                                          width: screenWidth *
                                                              0.38,
                                                          child: Text(driver[
                                                                  "remaining"]
                                                              .toString()))
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
