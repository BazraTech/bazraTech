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
import 'TotalVehicles.dart';

class ModifyVehileStatus extends StatefulWidget {
  String? plateNumber;
  String? sttatus;

  ModifyVehileStatus({super.key, this.plateNumber, this.sttatus});

  @override
  State<ModifyVehileStatus> createState() => _ModifyVehileStatusState();
}

class _ModifyVehileStatusState extends State<ModifyVehileStatus> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<String> location = ['INSTOCK', "MAINTAINING", 'ONROUTE', 'PARKED'];
  TextEditingController statusController = TextEditingController();
  String? vehiclestatus;
  String? selectedItem = "INSTOCK";
  String? plateNum;
  String? platenumber;
  String? loc;
  bool _shouldShowDialog = true;
  final storage = new FlutterSecureStorage();
  AlertDialog? _myAlertDialog;

  UpdateStatus() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "status": "$selectedItem",
      "plateNumber": "${widget.plateNumber}",
    };
    var response = await http.post(Uri.parse(ApIConfig.changeVehicleStatus),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      showPopUpAlert(context);
      _myAlertDialog = null;
    }
    print(response.statusCode.toString());
  }

  void showPopUpAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child:
                  Center(child: Container(height: 20, child: Text('Alert')))),
          content:
              Container(height: 50, child: Center(child: Text('successfully'))),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                // Pop the dialog route to remove it from the tree
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.plateNumber}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
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
          "Modify Vehicle Status",
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
                      color: Color.fromRGBO(236, 240, 243, 1),
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
                            "Change Status",
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
                          Icon(
                            Icons.local_shipping,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.sttatus}",
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
                          color: Colors.white, // Set the border color
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
                                  text: "${widget.plateNumber}",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth - 65,
                              height: screenHeight * 0.065,
                              child: DropdownButtonFormField<String>(
                                decoration: ThemeHelper().textInputDecoration(),
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
                      SizedBox(),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.4, 20, 0, 0),
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                                onPressed: () {
                                  UpdateStatus();
                                },
                                child: const Text(
                                  "Update Status",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(5, 5)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
