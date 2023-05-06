import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


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
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  List vehicleStatusList = [];
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
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Owner/All'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      vehicleStatusList = mapResponse['vehiclesINF'];
      print(vehicleStatusList);
      if (mounted) {
        timer = new Timer.periodic(
            Duration(seconds: 5),
            (Timer t) => setState(() {
                  vehicleStatusList = vehicleStatusList;
                }));
      }
      return vehicleStatusList;
    } else {
      throw Exception('not loaded ');
    }
  }

  void initState() {
    super.initState();
    vehicleFetchbystatus();
    timer = Duration(seconds: 5);
  }

  @override
  void dispose() {
    timer.cancel();
    timer;
    super.dispose();
  }

  void driversSearch(String enterKeyboard) {
    List findVehicle = [];
    setState(() {});
    if (enterKeyboard.isEmpty) {
      vehicleStatusList = findVehicle;
    } else {
      final findVehicle = vehicleStatusList.where((driver) {
        final name = driver['vehicleName'].toLowerCase();

        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || plateNumber.contains(inputName);
      }).toList();
      setState(() {
        this.vehicleStatusList = findVehicle;
      });
    }
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
              child: vehicleStatusList.isEmpty
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
                                    "Assigned Driver",
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
                                    " Plate Number",
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
                            children: vehicleStatusList.map((vehicle) {
                          return Container(
                              height: screenHeight * 0.2,
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
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: screenHeight * 0.03,
                                    width: screenHeight,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      left: const BorderSide(
                                          color: Colors.green, width: 5),
                                    )),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              vehicle['status'] == "ONROUTE"
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      child: Text(
                                                        vehicle['status'],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  : vehicle['status'] ==
                                                          "PARKED"
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Text(
                                                            vehicle['status'],
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .yellow,
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
                                                                      left: 10,
                                                                      top: 10),
                                                              child: Text(
                                                                vehicle[
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
                                                                vehicle[
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
                                              Text(
                                                vehicle['vehicleName'],
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  vehicle['driverName'],
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
                                                width: screenWidth * 0.27,
                                                child: Text(
                                                  vehicle['plateNumber'],
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
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ModifyVehileStatus(
                                                            plateNumber: vehicle[
                                                                'plateNumber'],
                                                          )),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenWidth,
                                              color: Color.fromRGBO(
                                                  244, 244, 244, 0.8),
                                              height: 37,
                                              margin: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: InkWell(
                                                onTap: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ModifyVehileStatus(
                                                                plateNumber:
                                                                    vehicle[
                                                                        'plateNumber'],
                                                              )));
                                                }),
                                                child: const Center(
                                                  child: Text("Update Status",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
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
