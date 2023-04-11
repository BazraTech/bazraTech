import 'dart:async';

import 'package:bazralogin/Model/communication.dart';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../Model/communicationList.dart';
import '../../../config/ApiConfig.dart';
import '../../../const/constant.dart';
import '../../../widget/SearchPage.dart';
import '../Owner/Vehicle/vehicleDetial.dart';

class OwnersDriver extends StatefulWidget {
  const OwnersDriver({super.key});
  @override
  State<OwnersDriver> createState() => _OwnersDriverState();
}

class _OwnersDriverState extends State<OwnersDriver> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  late var timer;
  List totalVhicles = [];
  List maintainin = [];
  List onroute = [];
  List parked = [];
  List Instock = [];
  List driverlist = [];
  Future onrouteFetch() async {
    // fetch list of total vehicles
    // fetch list of  car on route
    final onroute = await APIService.onroutCar();
    // fetch car parked
    final parked = await APIService.parkedCar();
    if (mounted) {
      timer = new Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => setState(() {
                this.onroute = onroute;
              }));
    }
  }

  Future totalVehicles() async {
    // fetch list of total vehicles
    final totalVhicles = await APIService.vehicleFetch();
    final inStock = await APIService.InStock();
    // fetch list of on maintainance

    if (mounted) {
      timer = new Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => setState(() {
                this.Instock = inStock;
                this.totalVhicles = totalVhicles;
              }));
    }
  }

  Future parkedFetch() async {
    // fetch car parked

    final parked = await APIService.parkedCar();
    if (mounted) {
      timer = new Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => setState(() {
                this.parked = parked;
              }));
    }
  }

  Future maintainingcarFetch() async {
    // fetch list of total vehicles
    final totalVhicles = await APIService.vehicleFetch();
    final inStock = await APIService.InStock();
    // fetch list of on maintainance
    final maintainin = await APIService.maintainingCar();
    // fetch list of  car on route

    // fetch car parked

    if (mounted) {
      timer = new Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => setState(() {
                this.maintainin = maintainin;
              }));
    }
  }

  Future vehicleFetch() async {
    final Result = await APIService.vehicleFetch();
    if (mounted) {
      timer = Timer.periodic(
          Duration(seconds: 5),
          (Timer t) => setState(() {
                this.Result = Result;
              }));
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    if (enterKeyboard.isNotEmpty) {
      for (var a in Result) {
        if (a['driverName'].toLowerCase().contains(query.toLowerCase())) {
          driverlist.add(a);
        }
      }
    } else {
      driverlist = Result;
    }
    setState(() {
      Result = driverlist;
    });
  }

  void initState() {
    super.initState();
    timer = Duration(seconds: 5);
    totalVhicles;
    vehicleFetch();
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
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final double categoryHeight = screenHeight * 0.30;
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Result.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
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
                                  "Drivers",
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
                                  "Plate No",
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
                                  " Status",
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
                          children: Result.map((vehicle) {
                        return Container(
                          height: screenHeight * 0.08,
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
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, left: 15, right: 20),
                                          height: screenHeight * 0.05,
                                          child: const Icon(
                                            MdiIcons.carBack,
                                            size: 20,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 10),
                                          child: Text(
                                            " " + vehicle['vehicleName'],
                                            style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                    vehicle['driver'] != null
                                        ? Container(
                                            margin: EdgeInsets.only(left: 20),
                                            width: screenWidth * 0.28,
                                            child: Text(
                                              vehicle['driver']['driverName'],
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    Container(
                                      width: screenWidth * 0.1,
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        vehicle['plateNumber'],
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Container(
                                        height: screenHeight * 0.03,
                                        width: screenWidth * 0.22,
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: kPrimaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            " " + vehicle['status'],
                                            style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ))
                                  ]),
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
