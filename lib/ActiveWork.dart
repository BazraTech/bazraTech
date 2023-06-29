import 'dart:io';

import 'package:cargo/shared/storage_hepler.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cargo/views/Work/ActiveCargo.dart';
import 'package:cargo/views/Work/CargoType/Actions.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';
import 'Components/Home_Page.dart';
import 'Components/Noglow.dart';
import 'model/VehicleListForCargo.dart';

import 'shared/constant.dart';

class VehicleCargo extends StatefulWidget {
  final int? id;
  @override
  const VehicleCargo({Key? key, this.id}) : super(key: key);
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
          Uri.parse(
              'http://64.226.104.50:9090/Api/Cargo/All/CargoDrivers/${widget.id}'),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            "Authorization": "Bearer $accessToken",
          });
      print(response);
      if (response.body.contains('cargoDriversINFs')) {
        final data = jsonDecode(response.body);
        final cargoDriversList = data['cargoDriversINFs'] as List<dynamic>;
        final cargoDrivers = cargoDriversList.map((cargoDriverData) {
          return CargoDriver(
            id: cargoDriverData['id'],
            driver: cargoDriverData['driver'],
            driverID: cargoDriverData['driverID'],
            cargo: cargoDriverData['cargo'],
            vehicleOwner: cargoDriverData['vehicleOwner'],
            plateNumber: cargoDriverData['plateNumber'],
          );
        }).toList();
        return cargoDrivers;
      } // Handle connection timeout error
      else {
        Fluttertoast.showToast(
            msg: "Failed To load...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0);

        Navigator.of(context, rootNavigator: true).pop();
        return [];
      }
    } catch (e) {
      print('Error in _fetchCargoDrivers(): $e');
      Fluttertoast.showToast(
          msg: "Failed To load...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  List activeCargoStatus = [];
  List _searchResults = [];
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

  TextEditingController searchController = TextEditingController();
  Future searchCargosByOwnerName(String status) async {
    try {
      List cargos = await fetchCargos();
      List filteredCargos = cargos
          .where((cargo) =>
              cargo.driver.toLowerCase().contains(status.toLowerCase()))
          .toList();
      return filteredCargos;
    } catch (e) {
      throw Fluttertoast.showToast(
          msg: "Failed to search cargos by driver name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

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

  bool isPressed = true;
  Future<void> confirmDriverState(BuildContext context) async {
    try {
      // Fetch cargo drivers
      List<CargoDriver> cargoDrivers = await fetchCargos();

      // Loop through each cargo driver and confirm the driver state
      for (CargoDriver cargoDriver in cargoDrivers) {
        int driverId = cargoDriver.driverID;
        print('Confirming driver state for driver ID $driverId');

        // Call the endpoint to confirm the driver state
        StorageHelper storageHelper = StorageHelper();
        String? accessToken = await storageHelper.getToken();
        final response = await http.post(
            Uri.parse(
                'http://64.226.104.50:9090/Api/Cargo/ConfirmDriverState/$driverId'),
            headers: {
              "Content-Type": "application/json",
              'Accept': 'application/json',
              "Authorization": "Bearer $accessToken",
            });
        print(response.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> body = jsonDecode(response.body);
          String message = body['message'];
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0);
        } else {
          String errorMessage = "Failed to confirm driver state";
          try {
            Map<String, dynamic> body = jsonDecode(response.body);
            errorMessage = body['message'];
          } catch (e) {
            print('Error decoding response body: $e');
          }
          Fluttertoast.showToast(
              msg: errorMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      }
    } catch (e) {
      print('Error in confirming driver state: $e');
      // Handle error as needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to confirm driver state"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  searchCargosByOwnerName(value).then((searchedCargos) {
                    setState(() {
                      // Wrap the assignment in a setState to refresh the Widget
                      _searchResults = searchedCargos;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Driver Name ',
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
            margin: EdgeInsets.only(left: 5, right: 5, top: 30),
            child: FutureBuilder(
                future: searchCargosByOwnerName(searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.08,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Vehicle Owner",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 123, 129, 236),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Driver",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 123, 129, 236),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Plate Number",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 123, 129, 236),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Notifications",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 123, 129, 236),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            height: screenHeight * 0.6,
                            child: Stack(
                              children: [
                                ScrollConfiguration(
                                  behavior: NoGlowScrollBehavior(),
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      CargoDriver cargoDriver =
                                          snapshot.data![index];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                left: BorderSide(
                                                  color: Colors.blue,
                                                  width: 3,
                                                ),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.7),
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
                                                      Expanded(
                                                        child: Text(
                                                          cargoDriver
                                                              .vehicleOwner,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    123,
                                                                    129,
                                                                    236),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          cargoDriver.driver,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    123,
                                                                    129,
                                                                    236),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          cargoDriver
                                                              .plateNumber,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    123,
                                                                    129,
                                                                    236),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                              subtitle: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: isExpanded
                                                    ? Icon(Icons
                                                        .keyboard_arrow_down)
                                                    : Icon(Icons
                                                        .keyboard_arrow_down),
                                              ),
                                              trailing: Container(
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "+2",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.red,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              children: [
                                                Stack(
                                                  children: [
                                                    Center(
                                                      child: SizedBox(
                                                        height:
                                                            screenHeight * 0.5,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: GridView(
                                                            // ignore: sort_child_properties_last
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    InkResponse(
                                                                  onTap: (() {
                                                                    confirmDriverState(
                                                                        context);
                                                                  }),
                                                                  child: Ink(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(255, 252, 254, 250),
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          boxShadow: isPressed
                                                                              ? [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.shade300,
                                                                                    offset: Offset(4, 4),
                                                                                    blurRadius: 15,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ]
                                                                              : null),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "Load",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade600,
                                                                              fontFamily: 'Roboto',
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    InkResponse(
                                                                  onTap: (() {
                                                                    confirmDriverState(
                                                                        context);
                                                                  }),
                                                                  child: Ink(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(255, 252, 254, 250),
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          boxShadow: isPressed
                                                                              ? [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.shade300,
                                                                                    offset: Offset(4, 4),
                                                                                    blurRadius: 15,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                  const BoxShadow(
                                                                                    color: Colors.white,
                                                                                    offset: Offset(-4, -4),
                                                                                    blurRadius: 25,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ]
                                                                              : null),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "UnLoad",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade600,
                                                                              fontFamily: 'Roboto',
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    InkResponse(
                                                                  onTap: (() {
                                                                    confirmDriverState(
                                                                        context);
                                                                  }),
                                                                  child: Ink(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(255, 252, 254, 250),
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          boxShadow: isPressed
                                                                              ? [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.shade300,
                                                                                    offset: Offset(4, 4),
                                                                                    blurRadius: 15,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ]
                                                                              : null),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "DepArrived",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade600,
                                                                              fontFamily: 'Roboto',
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    try {
                                                                      confirmDriverState(
                                                                          context);
                                                                    } catch (e) {
                                                                      print(
                                                                          'Error confirming driver state: $e');
                                                                    }
                                                                  },
                                                                  child: Ink(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(255, 252, 254, 250),
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          boxShadow: isPressed
                                                                              ? [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.shade300,
                                                                                    offset: Offset(4, 4),
                                                                                    blurRadius: 15,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ]
                                                                              : null),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "DestArrived",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade600,
                                                                              fontFamily: 'Roboto',
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    InkResponse(
                                                                  onTap: (() {
                                                                    confirmDriverState(
                                                                        context);
                                                                    // print("Confirm Driver State");
                                                                  }),
                                                                  child: Ink(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(255, 250, 250, 250),
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          boxShadow: isPressed
                                                                              ? [
                                                                                  BoxShadow(
                                                                                    color: Colors.grey.shade300,
                                                                                    offset: Offset(3, 3),
                                                                                    blurRadius: 10,
                                                                                    spreadRadius: 1,
                                                                                  ),
                                                                                ]
                                                                              : null),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "Departure",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.grey.shade600,
                                                                              fontFamily: 'Roboto',
                                                                              letterSpacing: 1,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                            gridDelegate:
                                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                              childAspectRatio: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      4.5),
                                                              maxCrossAxisExtent:
                                                                  200,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 2,
                                                      child: SizedBox(
                                                        width: screenWidth,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            print(
                                                                "Button Pressed");
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .grey[300],
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        15),
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                            ),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                            elevation: 1,
                                                          ),
                                                          child: Text(
                                                            "Track",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () async {
                                          final pdf = pw.Document();
                                          pdf.addPage(
                                            pw.MultiPage(
                                              pageFormat: PdfPageFormat.a4,
                                              build: (pw.Context context) => [
                                                pw.Header(
                                                    text: 'My Cargos',
                                                    level: 0),
                                                pw.Table.fromTextArray(
                                                  headers: [
                                                    '#',
                                                    'Vehicle Owner Name',
                                                    'Driver Name',
                                                    'Plate Number'
                                                  ],
                                                  data: List<
                                                      List<String>>.generate(
                                                    snapshot.data!.length > 5
                                                        ? 5
                                                        : snapshot.data!.length,
                                                    (index) => [
                                                      (index + 1).toString(),
                                                      snapshot.data![index]
                                                          .vehicleOwner,
                                                      snapshot
                                                          .data![index].driver,
                                                      snapshot.data![index]
                                                          .plateNumber,
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          final bytes = await pdf.save();
                                          await Share.file(
                                            'My Cargos',
                                            'my_cargos.pdf',
                                            bytes.buffer.asUint8List(),
                                            'application/pdf',
                                          );
                                        },
                                        child: Icon(Icons.share),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  return Center(
                    child: FutureBuilder(
                      future: Future.delayed(Duration(seconds: 10),
                          () => _checkInternetConnection()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return Container(
                              alignment: Alignment.center,
                              height: screenHeight * 0.13,
                              width: screenWidth * 0.7,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.7),
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
                })));
  }
}
