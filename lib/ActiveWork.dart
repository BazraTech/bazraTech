import 'dart:io';

import 'package:cargo/shared/storage_hepler.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/Work/ActiveCargo.dart';
import 'package:cargo/views/Work/CargoType/Actions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'model/VehicleListForCargo.dart';
import 'model/cargo.dart';
import 'shared/constant.dart';

class VehicleCargo extends StatefulWidget {
  @override
  State<VehicleCargo> createState() => _VehicleCargoState();
}

class _VehicleCargoState extends State<VehicleCargo> {
  Future? futureCargoDrivers;
  Future fetchCargos() async {
    try {
      StorageHelper storageHelper = StorageHelper();
      String? accessToken = await storageHelper.getToken();
      final response = await http.get(
          Uri.parse('http://64.226.104.50:9090/Api/Cargo/All/Cargos'),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            "Authorization": "Bearer $accessToken",
          });
      print(response);
      if (response.statusCode == 200) {
        List cargoJson = json.decode(response.body)['cargos'];
        return cargoJson.map((cargo) => Cargo.fromJson(cargo)).toList();
      } // Handle connection timeout error
      else {
        Alert(
          context: context,
          title: "Error",
          desc: "Failed to fetch data",
          type: AlertType.error,
        ).show();
        return [];
      }
    } catch (e) {
      print('Error in _fetchCargoDrivers(): $e');
      Alert(
        context: context,
        title: "Error",
        desc: "Failed to fetch data",
        type: AlertType.error,
      ).show();
      return [];
    }
  }

  List _allCargos = [];

  bool _searching = false;

  @override
  void initState() {
    super.initState();
    fetchCargos().then((cargos) {
      setState(() {
        _allCargos = cargos;
      });
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   futureCargoDrivers = fetchCargoDrivers().then((value) {
  //     setState(() {
  //       _cargoDrivers = value;
  //     });
  //   }).catchError((error) {
  //     print(error);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Failed to fetch data'),
  //     ));
  //   });
  // }

  bool isExpanded = false;
  List _data = [];
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActiveCargo()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 162, 162, 162),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 252, 254, 250),
          title: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth * 0.12),
            height: 40,
            color: Color.fromARGB(255, 252, 254, 250),
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
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 30),
          child: FutureBuilder(
            future: fetchCargos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Cargo driver = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.7),
                                  blurRadius: 8.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(
                                    6, // Move to right 7.0 horizontally
                                    8, // Move to bottom 8.0 Vertically
                                  ))
                            ],
                          ),
                          child: ExpansionTile(
                            title: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        driver.pickUp,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 123, 129, 236),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: const Icon(
                                          Icons.trip_origin,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 123, 129, 236),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.15,
                                        child: const Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            DottedLine(
                                              lineThickness: 1.0,
                                              dashLength: 4.0,
                                              dashColor: Colors.grey,
                                              dashGapRadius: 2.0,
                                            ),
                                            Icon(
                                              Icons.local_shipping,
                                              color: Color.fromARGB(
                                                  255, 123, 129, 236),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Icon(Icons.location_on,
                                            size: 15,
                                            color: Colors.grey.shade300),
                                      ),
                                      Text(
                                        driver.dropOff,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Container(
                              alignment: Alignment.bottomCenter,
                              child: isExpanded
                                  ? Icon(Icons.keyboard_arrow_down)
                                  : Icon(Icons.keyboard_arrow_down),
                            ),
                            trailing: Container(
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey.shade300,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "+2",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            children: [
                              Stack(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: screenHeight * 0.5,
                                      child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Status()),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    child: SizedBox(
                                      width: screenWidth,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("Button Pressed");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[300],
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          side: BorderSide(
                                              color: Colors.grey.shade400),
                                          elevation: 1,
                                        ),
                                        child: Text(
                                          "Track",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey.shade600,
                                              fontFamily: 'Roboto',
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Add more ListTiles here for displaying other CargoDriver properties
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              return Center(
                child: FutureBuilder(
                  future: Future.delayed(
                      Duration(seconds: 10), () => _checkInternetConnection()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.13,
                          width: screenWidth * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.7),
                                  blurRadius: 8.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(
                                    6, // Move to right 7.0 horizontally
                                    8, // Move to bottom 8.0 Vertically
                                  ))
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text('Network Error',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'No Network. Connect your device to internet or mobile data',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ));
                    }
                  },
                ),
              );
            },
          ),
        ));
  }
}
