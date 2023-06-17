import 'dart:convert';

import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/view/screen/Owner/TripManagement/setTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import '../../../../const/constant.dart';
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
          toolbarHeight: 80,
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
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
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
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: containerpaddingfordriverandowner,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.08,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  bottomLeft: Radius.circular(6.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: Colors.blue, width: 6),
                                    ),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.25,
                                          child: const Text(
                                            "vehicle",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.2,
                                          child: const Text(
                                            "Driver ",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.26,
                                          child: const Text(
                                            "vehicle Catagory",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.13,
                                          child: const Text(
                                            "Status",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                              children: findVehicle.map((vehicle) {
                            int index = findVehicle.indexOf(vehicle);
                            Color borderLeftColor = Colors.red;
                            if (index % 2 == 0) {
                              borderLeftColor = Colors
                                  .green; // Update border color based on condition
                            } else {
                              borderLeftColor = Colors
                                  .blue; // Update border color for the else case
                            }
                            return Container(
                              height: screenHeight * 0.08,
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
                                            Settrips(
                                                drivername:
                                                    vehicle['driverName'],
                                                platenumber:
                                                    vehicle['plateNumber'],
                                                startLocation: "4444",
                                                destination: "4443",
                                                startDate: "2-11-14",
                                                tripType: "LONG")),
                                  );
                                }),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      bottomLeft: Radius.circular(6.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          left: BorderSide(
                                              color: borderLeftColor, width: 6),
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, right: 10),
                                              child: Text(
                                                " " + vehicle['vehicleName'],
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize:
                                                      AppFonts.smallFontSize,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            vehicle['driverName'] != null
                                                ? Container(
                                                    width: screenWidth * 0.2,
                                                    child: Text(
                                                      vehicle['driverName'],
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: AppFonts
                                                            .smallFontSize,
                                                        color: Colors.black,
                                                      ),
                                                    ))
                                                : Container(
                                                    width: screenWidth * 0.2,
                                                    child: const Text(
                                                      "Unassigned",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                            Container(
                                              width: screenWidth * 0.26,
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text(
                                                vehicle['vehicleCatagory'],
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize:
                                                      AppFonts.smallFontSize,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: screenHeight * 0.038,
                                                width: screenWidth * 0.2,
                                                margin: const EdgeInsets.only(
                                                    left: 30, right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    " " + vehicle['status'],
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ))
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                        ],
                      ),
                    )
                ],
              ));
  }
}
