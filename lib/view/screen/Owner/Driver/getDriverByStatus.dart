import 'dart:async';
import 'dart:convert';

import 'package:bazralogin/controller/Localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../Theme/customAppBar.dart';
import '../../../../const/constant.dart';
import '../Vehicle/vehicleDetial.dart';
import 'driverDetial.dart';
import 'modifyDriverStatus.dart';

class getDriversBystatus extends StatefulWidget {
  String? driverList;
  String? driverStatus;
  getDriversBystatus({super.key, this.driverList, required this.driverStatus});

  @override
  State<getDriversBystatus> createState() => _getDriversBystatusState();
}

class _getDriversBystatusState extends State<getDriversBystatus> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String query = '';
  List books = [];
  List vehicleStatusList = [];
  List findVehicle = [];
  late var timer;
  vehicleFetchbystatus() async {
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
            'http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/${widget.driverStatus}'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      vehicleStatusList = mapResponse['${widget.driverList}'];
      print(vehicleStatusList);
      setState(() {
        vehicleStatusList = vehicleStatusList;

        findVehicle = vehicleStatusList;
      });

      return vehicleStatusList;
    } else {
      
    }
  }

  void initState() {
    super.initState();
    vehicleFetchbystatus();
    timer = Duration(seconds: 5);
  }

  @override
  void dispose() {
    // timer.cancel();
    // timer;
    super.dispose();
  }

  void driversSearch(String enterKeyboard) {
    final findVehicle = vehicleStatusList.where((driver) {
      final name = driver['driverName'].toLowerCase();
      final plateNumber = driver['licenseNumber'].toLowerCase();
      final inputName = enterKeyboard.toLowerCase();
      final inputLicense = enterKeyboard.toLowerCase();
      return name.contains(inputName) || plateNumber.contains(inputName);
    }).toList();
    setState(() {
      this.findVehicle = findVehicle;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
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
                                      fontSize: 15,
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
                        Column(
                            children: findVehicle.map((driver) {
                          return Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              height: screenHeight * 0.2,
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
                                  elevation: 3,
                                  child: Container(
                                    height: screenHeight * 0.03,
                                    width: screenHeight,
                                    decoration: BoxDecoration(
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
                                                      child: Text(
                                                        driver['status'],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                              child: Text(
                                                                driver[
                                                                    'status'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 10),
                                                              child: Text(
                                                                driver[
                                                                    'status'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                        GestureDetector(
                                          onTap: (() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ModifyDriverStatus(
                                                          driverLicense: driver[
                                                              'licenseNumber'],
                                                        )));
                                          }),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenWidth,
                                              color: Color.fromRGBO(
                                                  244, 244, 244, 0.8),
                                              height: 40,
                                              margin: EdgeInsets.only(top: 20),
                                              child: const Center(
                                                child: Text("Update Status",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        )
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
