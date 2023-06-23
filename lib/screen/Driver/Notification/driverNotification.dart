import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import '../../../../const/constant.dart';

class drivernotificationPage extends StatefulWidget {
  const drivernotificationPage({super.key});

  @override
  State<drivernotificationPage> createState() => _drivernotificationPageState();
}

class _drivernotificationPageState extends State<drivernotificationPage> {
  bool _isLoading = true;
  List Result = [];
  void MessageHistory() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Alerts/ByStatus'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['activeAlerts'];

      setState(() {
        _isLoading = false;
        Result = results;
      });

      print(results);
    } else {
      throw Exception('not loaded ');
    }
  }

  void initState() {
    super.initState();
    // MessageHistory();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Alerts",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: screenHeight,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400.withOpacity(0.2),
                              spreadRadius: -1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, -3), // horizontal, vertical offset
                            ),
                          ],
                        ),
                        width: screenWidth,
                        child: Container(
                            child: Row(
                          children: [
                            Container(
                              child: SizedBox(
                                height: screenHeight * 0.08,
                                width: screenWidth * 0.1,
                                child: CircleAvatar(
                                  backgroundColor: kBackgroundColor,
                                  child: SizedBox(
                                      height: screenHeight * 0.06,
                                      child: Center(
                                        child: Text(
                                          "Gonder".substring(0, 1),
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.4,
                              margin: EdgeInsets.only(
                                top: screenHeight * 0.03,
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Addisa   ,Tulu",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: screenWidth * 0.07),
                                        child: Text(
                                          "Offf road",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.18,
                              margin: EdgeInsets.only(left: screenWidth * 0.24),
                              child: Text("adama"),
                            )
                          ],
                        )),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}