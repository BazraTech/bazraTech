// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:bazralogin/Model/Assignmodel.dart';

import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../Bottom/Bottom.dart';
import '../../../Model/driversList.dart';
import '../../../Theme/customAppBar.dart';
import '../../../config/APIService.dart';
import 'package:http/http.dart' as http;

class assignscreen extends StatefulWidget {
  final String plateNumber;
  final String lNumber;
  const assignscreen(
      {super.key, required this.plateNumber, required this.lNumber});

  @override
  State<assignscreen> createState() => _assignscreenState();
}

List<ListOfDrivers> list = [];
List<ListOfDriverandplatenumber> find = [];
TextEditingController textEditingController = TextEditingController();
final storage = new FlutterSecureStorage();

class _assignscreenState extends State<assignscreen> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Assigned Successfully '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  AssignDriver() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "driver": "${widget.lNumber}",
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
    } else {
      throw Exception('Failed ');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(widget.plateNumber);
    print(widget.lNumber);
    return Scaffold(
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
        title: const Text("Assigned Driver Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "Plate Number",
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        initialValue: '${widget.plateNumber}',
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '${widget.plateNumber}',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    "License Number",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {
                            textEditingController.text;
                          });
                        },
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: '${widget.lNumber}',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    AssignDriver();
                  },
                  child: const Text(
                    "Assign Driver",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1), fontSize: 15),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.lightBlue;
                        }
                        return Colors.lightBlue;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiConstant {
  static String? assignDriverApi;
}
