import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/config/APIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import '../../../../const/constant.dart';
import 'driverDetial.dart';
import 'modifyDriverStatus.dart';

class OwnersDriver extends StatefulWidget {
  OwnersDriver({super.key});

  @override
  State<OwnersDriver> createState() => _OwnersDriverState();
}

class _OwnersDriverState extends State<OwnersDriver> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  List findVehicle = [];
  List drivers = [];
  late var timer;

  List Result = [];
  List totalVehicles = [];
  driverFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(
            key: "totalDrivers", value: data["totalDrivers"].toString());
        setState(() {
          Result = data['drivers'];
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

  void initState() {
    super.initState();
    driverFetch();
  }

  @override
  // void dispose() {
  //   timer.cancel();
  //   timer;
  //   super.dispose();
  // }

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 229, 229, 239),
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
              child: findVehicle.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 130),
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        Container(
                          height: screenHeight * 0.08,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: screenWidth * 0.2,
                                  child: Text(
                                    TranslationUtil.text("Drivers"),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.2,
                                  child: Text(
                                    TranslationUtil.text("License Number"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.2,
                                  child: Text(
                                    TranslationUtil.text("Phone Number"),
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
                        Container(
                          height: 1,
                          margin:
                              EdgeInsets.only(left: 5, right: 9, bottom: 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: screenWidth,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Column(
                            children: findVehicle.map((driver) {
                          return Container(
                              height: screenHeight * 0.27,
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: InkWell(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Driver_Detial(
                                              id: driver['id'],
                                            )),
                                  );
                                }),
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: screenHeight * 0.03,
                                    width: screenHeight,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      left: BorderSide(
                                          color: Colors.green, width: 5),
                                    )),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              driver['status'] == "ASSIGNED"
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            driver['status'],
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    screenWidth *
                                                                        0.17),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                // action to perform when button is pressed
                                                              },
                                                              child: Icon(
                                                                Ionicons.car,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              color:
                                                                  Colors.white,

                                                              shape:
                                                                  CircleBorder(), // set the shape of the button
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left:
                                                                    screenWidth *
                                                                        0.08),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    child: Text(
                                                                  "PlateNumber",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                )),
                                                                Container(
                                                                    child: Text(driver['plateNumber'] ==
                                                                            null
                                                                        ? "__"
                                                                        : driver[
                                                                            'plateNumber'])),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : driver['status'] ==
                                                          "UNASSIGNED"
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            driver['status'],
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : driver['status'] ==
                                                              "PERMIT"
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    driver[
                                                                        'status'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: screenWidth *
                                                                            0.17),
                                                                    child:
                                                                        MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        // action to perform when button is pressed
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Ionicons
                                                                            .car,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      color: Colors
                                                                          .white,

                                                                      shape:
                                                                          CircleBorder(), // set the shape of the button
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: screenWidth *
                                                                            0.08),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                            child:
                                                                                Text(
                                                                          "PlateNumber",
                                                                          style:
                                                                              TextStyle(color: Colors.green),
                                                                        )),
                                                                        Container(
                                                                            child: Text(driver['plateNumber'] == null
                                                                                ? "__"
                                                                                : driver['plateNumber'])),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    driver[
                                                                        'status'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: screenWidth *
                                                                            0.17),
                                                                    child:
                                                                        MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        // action to perform when button is pressed
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Ionicons
                                                                            .car,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      color: Colors
                                                                          .white,

                                                                      shape:
                                                                          CircleBorder(), // set the shape of the button
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: screenWidth *
                                                                            0.08),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                            child:
                                                                                Text(
                                                                          "PlateNumber",
                                                                          style:
                                                                              TextStyle(color: Colors.green),
                                                                        )),
                                                                        Container(
                                                                            child: Text(driver['plateNumber'] == null
                                                                                ? "__"
                                                                                : driver['plateNumber'])),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                            ]),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 30, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.3,
                                                child: Text(
                                                  driver['driverName'],
                                                  textAlign: TextAlign.start,
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
                                                child: Text(
                                                  driver['licenseNumber'],
                                                  textAlign: TextAlign.start,
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
                                                width: screenWidth * 0.3,
                                                child: Text(
                                                  driver['phoneNumber'],
                                                  textAlign: TextAlign.start,
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
                                        Visibility(
                                          visible:
                                              driver['status'] != "ONROUTE",
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ModifyDriverStatus(
                                                    driverLicense:
                                                        driver['licenseNumber'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: screenWidth,
                                                color: Color.fromRGBO(
                                                    244, 244, 244, 0.8),
                                                height: 40,
                                                margin:
                                                    EdgeInsets.only(top: 20),
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
                                          ),
                                        )
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10.0),
                                        //   child: Container(
                                        //     width: screenWidth,
                                        //     color: Color.fromRGBO(
                                        //         244, 244, 244, 0.8),
                                        //     height: 37,
                                        //     margin: EdgeInsets.only(
                                        //         top: screenHeight * 0.02),
                                        //     child: InkWell(
                                        //       onTap: (() {
                                        //         Navigator.push(
                                        //             context,
                                        //             MaterialPageRoute(
                                        //                 builder: (context) =>
                                        //                     ModifyDriverStatus(
                                        //                         driverLicense:
                                        //                             driver[
                                        //                                 'licenseNumber'])));
                                        //       }),
                                        //       child: const Center(
                                        //         child: Text("Update Status",
                                        //             style: TextStyle(
                                        //                 fontSize: 15,
                                        //                 fontWeight:
                                        //                     FontWeight.bold)),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
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
