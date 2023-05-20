import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class reportStatus extends StatefulWidget {
  const reportStatus({super.key});

  @override
  State<reportStatus> createState() => _reportStatusState();
}

class _reportStatusState extends State<reportStatus> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          height: screenHeight * 0.06,
                          margin: EdgeInsets.only(bottom: screenHeight * 0.09),
                          width: screenWidth * 0.13,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Ionicons.chevron_back,
                              size: 34,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
                              color: kBackgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: screenHeight * 0.19,
                          width: screenWidth - 20,
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Ionicons.car),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.trip_origin),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Onroute",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Jimma",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Ionicons.location))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Addisa Ababa",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12,
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.2),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar("LOAD");
                                setActiveButton2(true);
                              },
                              child: Text("Load",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 11,
                                  )),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Colors.blue;
                                    } else {
                                      return Colors.grey;
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
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar("UNLOAD");
                                setActiveButton2(false);
                              },
                              child: Text(
                                "Unload",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton2) {
                                      return Colors.grey;
                                    } else {
                                      return Colors.blue;
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
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Unloadandloadcar('');
                                setActiveButton(true);
                              },
                              child: Text(
                                "DEPARTURE",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return kPrimaryColor;
                                    } else {
                                      return Colors.grey;
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
                            width: screenWidth * 0.44,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                setActiveButton(false);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (!_isActivebutton) {
                                      return Colors.grey;
                                    } else {
                                      return kPrimaryColor;
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
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              setActiveButton(false);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Colors.grey;
                                  } else {
                                    return kPrimaryColor;
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
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
