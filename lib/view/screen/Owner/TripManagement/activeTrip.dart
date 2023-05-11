import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/Model/communication.dart';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/view/screen/Owner/TripManagement/tripDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../Model/communicationList.dart';
import '../../../../const/constant.dart';
import '../Vehicle/vehicleDetial.dart';
import '../Vehicle/vehicleStatus.dart';
import 'package:http/http.dart' as http;

class ActiveTrip extends StatefulWidget {
  const ActiveTrip({super.key});
  @override
  State<ActiveTrip> createState() => _ActiveTripState();
}

class _ActiveTripState extends State<ActiveTrip> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  bool _isLoading = true;
  String query = '';
  List Result = [];
  List findVehicle = [];
  List results = [];
  List totalVehicles = [];
  activeTrip() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/Trip/All'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      results = mapResponse['setTrips'];
      setState(() {
        findVehicle = results;
        _isLoading = false;
      });
      return results;
    } else {
      throw Exception('not loaded ');
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    setState(() {
      findVehicle = results.where((driver) {
        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputPlateNumber = enterKeyboard.toLowerCase();
        return plateNumber.contains(inputPlateNumber);
      }).toList();
    });

    setState(() {
      findVehicle = findVehicle;
    });
  }

  void initState() {
    super.initState();

    activeTrip();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final double categoryHeight = screenHeight * 0.30;
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
                onChanged: vehiclesSearch,
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
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    children: findVehicle.map((trip) {
                  return Container(
                    height: screenHeight * 0.08,
                    child: InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => TripDetail(
                                    id: trip['id'],
                                  )),
                        );
                      }),
                      child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: Text(
                                  " " + trip['driverName'].toString(),
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.1,
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  trip['plateNumber'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.1,
                                margin: EdgeInsets.only(left: 5, right: 10),
                                child: Text(
                                  trip['tripType'],
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black87),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  );
                }).toList()),
              ));
  }
}
