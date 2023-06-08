import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

import '../../../Theme/clippbox.dart';

class activeWork extends StatefulWidget {
  const activeWork({super.key});

  @override
  State<activeWork> createState() => _activeWorkState();
}

class _activeWorkState extends State<activeWork> {
  bool _isActivebutton = false;
  bool _isActivebutton2 = false;
  //change state of button
  void setActiveButton(bool isActive) {
    setState(() {
      _isActivebutton = isActive;
    });
  }

  void setActiveButton2(bool isActive) {
    setState(() {
      _isActivebutton2 = isActive;
    });
  }

  // load  or unload  car using function
  Unloadandloadcar(String load) async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {"driverState": load};
      var response = await http.put(
          Uri.parse('http://64.226.104.50:9090/Api/Driver/ChangeDriverState'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        if (load == load) {
          print("yes");
        }
      } else {
        print('noo');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(85, 164, 240, 1),
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromRGBO(85, 164, 240, 1),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.05, right: screenWidth * 0.4),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Ionicons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(children: [
                Container(
                  height: screenHeight * 0.25,
                  // margin: EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(85, 164, 240, 1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: [],
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  margin: EdgeInsets.only(top: 99),
                  height: screenHeight * 0.22,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(236, 240, 243, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: screenHeight * 0.19,
                          width: screenWidth - 20,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: screenWidth * 0.05,
                                bottom: screenWidth * 0.05),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.trip_origin,
                                          color: Colors.green,
                                        )),
                                    CustomPaint(
                                      size: Size(screenWidth * 0.19, 2),
                                      painter: DashLinePainter(),
                                    ),
                                    Container(
                                      height: screenHeight * 0.07,
                                      width: screenWidth * 0.07,
                                      child: Icon(
                                        Icons.local_shipping,
                                        color: Colors.red,
                                      ),
                                    ),
                                    CustomPaint(
                                      size: Size(screenWidth * 0.2, 2),
                                      painter: DashLinePainter(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.trip_origin,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenWidth * 0.3,
                                        margin: EdgeInsets.only(
                                            left: screenWidth * 0.15),
                                        child: Text(
                                          "Jimma",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.1,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: screenWidth * 0.3,
                                          child: Text(
                                            "Addisa Ababa",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ]),
            ),
            Container(
              height: screenHeight * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Shadow color
                                    blurRadius: 5, // Spread radius
                                    offset: Offset(
                                        0, 3), // Offset in (x,y) coordinates
                                  ),
                                ],
                                color: Color.fromRGBO(236, 240, 243, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                      255, 255, 255, 1), // Set the border color
                                  width: 2.5,
                                )),
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.1,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar("LOAD");
                                setActiveButton2(true);
                              },
                              child: Text("Load",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 11,
                                  )),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Color.fromRGBO(236, 240, 243, 1);
                                    } else {
                                      return Colors.grey.shade300;
                                    }
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Colors.white;
                                    } else {
                                      return Colors.black;
                                    }
                                  },
                                ),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Shadow color
                                    blurRadius: 5, // Spread radius
                                    offset: Offset(
                                        0, 3), // Offset in (x,y) coordinates
                                  ),
                                ],
                                color: Color.fromRGBO(236, 240, 243, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                      255, 255, 255, 1), // Set the border color
                                  width: 2.5,
                                )),
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.1,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar("UNLOAD");
                                setActiveButton2(false);
                              },
                              child: Text(
                                "Unload",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 11,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Colors.grey.shade300;
                                    } else {
                                      return Color.fromRGBO(236, 240, 243, 1);
                                    }
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Colors.white;
                                    } else {
                                      return Colors.black;
                                    }
                                  },
                                ),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.03),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Shadow color
                                    blurRadius: 5, // Spread radius
                                    offset: Offset(
                                        0, 3), // Offset in (x,y) coordinates
                                  ),
                                ],
                                color: Color.fromRGBO(236, 240, 243, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                      255, 255, 255, 1), // Set the border color
                                  width: 2.5,
                                )),
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.1,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar('');
                                setActiveButton(true);
                              },
                              child: Text(
                                "DEPARTURE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 11,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return Color.fromRGBO(236, 240, 243, 1);
                                    } else {
                                      return Colors.grey.shade300;
                                    }
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return Colors.white;
                                    } else {
                                      return Colors.black;
                                    }
                                  },
                                ),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Shadow color
                                    blurRadius: 5, // Spread radius
                                    offset: Offset(
                                        0, 3), // Offset in (x,y) coordinates
                                  ),
                                ],
                                color: Color.fromRGBO(236, 240, 243, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                      255, 255, 255, 1), // Set the border color
                                  width: 2.5,
                                )),
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.1,
                            child: ElevatedButton(
                              onPressed: () {
                                setActiveButton(false);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return Colors.grey.shade300;
                                    } else {
                                      return Color.fromRGBO(236, 240, 243, 1);
                                    }
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return Colors.white;
                                    } else {
                                      return Colors.black;
                                    }
                                  },
                                ),
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
                              child: Text(
                                "DEPARTUREARRIVED",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                              ],
                              color: Color.fromRGBO(236, 240, 243, 1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromRGBO(
                                    255, 255, 255, 1), // Set the border color
                                width: 2.5,
                              )),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              setActiveButton(false);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Colors.grey.shade300;
                                  } else {
                                    return Color.fromRGBO(236, 240, 243, 1);
                                  }
                                },
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Colors.white;
                                  } else {
                                    return Colors.black;
                                  }
                                },
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                            ),
                            child: Text(
                              "DESTINATIONARRIVED",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
