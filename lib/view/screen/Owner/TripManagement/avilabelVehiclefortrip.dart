import 'dart:async';
import 'dart:convert';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/view/screen/Owner/Driver/assignDriver.dart';
import 'package:bazralogin/view/screen/Owner/TripManagement/setTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../Model/communicationList.dart';
import '../../../../const/constant.dart';
import '../Vehicle/vehicleDetial.dart';
import '../Vehicle/vehicleStatus.dart';
import 'package:http/http.dart' as http;

class AvailableVehicle extends StatefulWidget {
  const AvailableVehicle({super.key});
  @override
  State<AvailableVehicle> createState() => _AvailableVehicleState();
}

class _AvailableVehicleState extends State<AvailableVehicle> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  bool _isLoading = true;
  String query = '';
  List Result = [];
  List assignedVehicle = [];
  List findVehicle = [];

  assignedDrivers() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(Uri.parse(ApIConfig.avaiableTrip),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      List results = mapResponse['available'];

      setState(() {
        _isLoading = false;

        assignedVehicle = results
            .where((element) => element['status'].contains("INSTOCK"))
            .toList();
        findVehicle = assignedVehicle;
      });
      return assignedVehicle;
    } else {
      throw Exception('not loaded ');
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    setState(() {
      findVehicle = assignedVehicle.where((driver) {
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

    assignedDrivers();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final double categoryHeight = screenHeight * 0.30;

    print(Result);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 120,
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
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth * 0.12),
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                onChanged: vehiclesSearch,
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
        body: findVehicle.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    children: findVehicle.map((vehicle) {
                  return Container(
                    height: screenHeight * 0.08,
                    child: InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Settrips(
                                  drivername: vehicle['driverName'],
                                  platenumber: vehicle['plateNumber'],
                                  startLocation: "4444",
                                  destination: "4443",
                                  startDate: "2-11-14",
                                  tripType: "LONG")),
                        );
                      }),
                      child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: Text(
                                  " " + vehicle['vehicleName'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              vehicle['driverName'] != null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: screenWidth * 0.28,
                                      child: Text(
                                        vehicle['driverName'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ))
                                  : Container(
                                      width: screenWidth * 0.25,
                                      child: const Text(
                                        "Unassigned",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                              Container(
                                width: screenWidth * 0.1,
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  vehicle['vehicleCatagory'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              Container(
                                  height: screenHeight * 0.038,
                                  width: screenWidth * 0.23,
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kPrimaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      " " + vehicle['status'],
                                      style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ))
                            ]),
                      ),
                    ),
                  );
                }).toList()),
              ));
  }
}
