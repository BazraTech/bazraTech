import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../Theme/TextInput.dart';
import '../../../../config/APIService.dart';
import '../../Bottom/Bottom.dart';
import '../Vehicle/TotalVehicles.dart';
import 'UnassignedDrivers.dart';
import 'vehicleOnStock.dart';

class ModifyDriverStatus extends StatefulWidget {
  String? driverLicense;
  String? status;
  String? licenseNumber;
  ModifyDriverStatus(
      {super.key, this.driverLicense, this.status, this.licenseNumber});

  @override
  State<ModifyDriverStatus> createState() => _ModifyDriverStatusState();
}

class _ModifyDriverStatusState extends State<ModifyDriverStatus> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<String> location = [
    "ASSIGNED",
    "Select Status",
    "UNASSIGNED",
    'ONROUTE',
    'PERMIT'
  ];

  List<String> unassigndsatus = ["ASSIGNED", "Select Status"];

  TextEditingController statusController = TextEditingController();
  String? vehiclestatus;
  String? selectedItem = "Select Status";
  String? plateNum;
  String? platenumber;
  String? loc;
  final storage = new FlutterSecureStorage();

  UpdateStatus() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "driverStatus": "$selectedItem",
      "driverLicense": "${widget.driverLicense}",
    };
    var response = await http.put(Uri.parse(ApIConfig.changeDriverStatus),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      _showMyDialog();
    }
    print(response.statusCode.toString());
  }

  Future<void> _showMyDialog() async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    platenumber = "${widget.driverLicense}";
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.07,
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child: Center(
                child: Container(
                  height: 20,
                  child: const Text(
                    "Alert",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Updated Successfully ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnersVehicle()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Set the color of the icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Modify Drivers Status",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  height: screenWidth * 0.24,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white, // Set the border color
                        width: 2.5,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Driver Status",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.status}",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 5, // Spread radius
                        offset: Offset(0, 2), // Offset in (x,y) coordinates
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            blurRadius: 5, // Spread radius
                            offset: Offset(0, 2), // Offset in (x,y) coordinates
                          ),
                        ],
                        color: Color.fromRGBO(236, 240, 243, 1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color.fromRGBO(
                              236, 240, 243, 1), // Set the border color
                          width: 2.5,
                        )),
                    width: screenWidth * 0.5,
                    child: Column(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.07),
                              width: double.infinity,
                              child: TextFormField(
                                enabled: false,
                                controller: TextEditingController(
                                  text: "${widget.driverLicense}",
                                ),
                                decoration: ThemeHelper().textInputDecoration(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if ("${widget.status}" == "ASSIGNED")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth - 65,
                                height: screenHeight * 0.08,
                                child: DropdownButtonFormField<String>(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                  value: selectedItem,
                                  items: location
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          )))
                                      .toList(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter  Plate Number';
                                    }
                                  },
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItem = newValue;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      if (selectedItem == "PERMIT")
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(screenWidth * 0.4, 20, 0, 0),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.05,
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Text(
                              "Update Status",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VehicleOnstock(
                                          licenseNumber:
                                              '${widget.driverLicense}',
                                        )),
                              );
                            },
                          ),
                        )
                      else if ("${widget.status}" == "UNASSIGNED")
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(screenWidth * 0.4, 20, 0, 0),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.05,
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Text(
                              "Update Status",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VehicleOnstock(
                                          licenseNumber:
                                              "${widget.driverLicense}",
                                        )),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(screenWidth * 0.4, 20, 0, 0),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.05,
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Text(
                              "Update Status",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              UpdateStatus();
                            },
                          ),
                        )
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
