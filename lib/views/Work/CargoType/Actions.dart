import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Components/Home_Page.dart';
import '../../../model/VehicleListForCargo.dart';
import '../../../shared/constant.dart';
import '../../../shared/storage_hepler.dart';
import '../ActiveCargo.dart';

class Status extends StatefulWidget {
  final int? id;
  Status({super.key, this.id});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  bool isPressed = true;

  void _showSweetAlert(BuildContext context, AlertType alertType, String title,
      String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (alertType == AlertType.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ActiveCargo()),
              );
            } else if (alertType == AlertType.error) {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
      ],
    ).show();
  }

  Future<List<CargoDriver>> fetchCargos() async {
    try {
      StorageHelper storageHelper = StorageHelper();
      String? accessToken = await storageHelper.getToken();
      final response = await http.get(
        Uri.parse(
          'http://64.226.104.50:9090/Api/Cargo/All/CargoDrivers/${widget.id}',
        ),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('cargoDrivers')) {
          final cargoDriversList = (data['cargoDriversINFs'] as List<dynamic>)
              .map<CargoDriver>((cargoDriverData) {
            return CargoDriver(
              id: cargoDriverData['id'],
              driver: cargoDriverData['driver'],
              driverID: cargoDriverData['driverID'],
              cargo: cargoDriverData['cargo'],
              vehicleOwner: cargoDriverData['vehicleOwner'],
              plateNumber: cargoDriverData['plateNumber'],
            );
          }).toList();

          return cargoDriversList;
        } else {
          // Handle missing data
          throw Exception('No cargo drivers found');
        }
      } else {
        // Handle HTTP error
        throw Exception('Failed to fetch cargo drivers');
      }
    } on SocketException catch (e) {
      print('Error connecting to API endpoint: $e');
      throw Exception('Failed to connect to API endpoint');
    } catch (e) {
      print('Error in fetchCargos(): $e');
      throw Exception('Failed to fetch cargo drivers');
    }
  }

  void initState() {
    super.initState();
    confirmDriverState(context);
  }

  Future<void> confirmDriverState(BuildContext context) async {
    try {
      // Fetch cargo drivers
      List<CargoDriver> cargoDrivers = await fetchCargos();

      if (cargoDrivers.isEmpty) {
        // Handle empty list of cargo drivers
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch cargo drivers"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

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
        // Handle response as needed
        if (response.statusCode == 200) {
          // Driver state confirmed successfully
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Driver state confirmed successfully"),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Failed to confirm driver state
          String errorMessage = "Failed to confirm driver state";
          try {
            Map<String, dynamic> body = jsonDecode(response.body);
            errorMessage = body['message'];
          } catch (e) {
            print('Error decoding response body: $e');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
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
    return GridView(
      // ignore: sort_child_properties_last
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              confirmDriverState(context);
            }),
            child: Ink(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
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
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              confirmDriverState(context);
            }),
            child: Ink(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
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
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              confirmDriverState(context);
            }),
            child: Ink(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
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
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: () {
              try {
                confirmDriverState(context);
              } catch (e) {
                print('Error confirming driver state: $e');
              }
            },
            child: Ink(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
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
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              confirmDriverState(context);
              // print("Confirm Driver State");
            }),
            child: Ink(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
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
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4.5),
        maxCrossAxisExtent: 200,
      ),
    );
  }
}
