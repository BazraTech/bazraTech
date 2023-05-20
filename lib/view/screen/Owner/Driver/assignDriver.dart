import 'dart:convert';

import 'package:bazralogin/Route/Routes.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';

import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;
import '../../../../Theme/TextInput.dart';
import '../../../../config/APIService.dart';
import '../../Bottom/Bottom.dart';

class assignDriver extends StatefulWidget {
  final String? licenseNumber;
  final String? plateNumber;
  assignDriver({super.key, this.licenseNumber, this.plateNumber});

  @override
  State<assignDriver> createState() => _assignDriverState();
}

TextEditingController textEditingController = TextEditingController();
final storage = new FlutterSecureStorage();

class _assignDriverState extends State<assignDriver> {
  Future<void> _showMyDialog() async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                    'Assigned Successfully ',
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
                    Get.offNamed(AppRoutes.getDriverpageRoute());
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AssignDriver() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "driver": "${widget.licenseNumber}",
      "plateNumber": "${widget.plateNumber}",
    };
    var response = await http.post(Uri.parse(ApIConfig.assignDriverApi),
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

  // void initState() {
  //   // super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String? selectedItem = 'Single Trip';
    List<String> items = ['Single Trip', 'Round Trip'];
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: const Text(
            " Create Alert Page",
            style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: screenWidth,
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: screenWidth * 0.5,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.white,

                            child: SizedBox(
                              height: screenHeight * 0.08,
                              child: Icon(
                                Ionicons.car,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                            padding: EdgeInsets.all(11),
                            minWidth: screenWidth * 0.004,
                            //use this class Circleborder() for circle shape.
                            shape: const CircleBorder(),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: screenWidth * 0.1),
                            child: Text(" Assign Driver",
                                style: TextStyle(
                                  fontFamily: "Nuinto",
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17,
                                ))),
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.35,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Driver License",
                                    style: TextStyle(
                                      fontFamily: "Nuinto",
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    ' ${widget.licenseNumber}',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Vehicle plate Number",
                                style: TextStyle(
                                  fontFamily: "Nuinto",
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: TextField(
                                    decoration:
                                        ThemeHelper().textInputDecoration(
                                      '${widget.plateNumber}',
                                    ),
                                  )),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.4, 20, 0, 0),
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {
                                AssignDriver();
                              },
                              child: const Text(
                                "Assign Driver",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ThemeHelper().buttonStyle(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ));
  }
}
