import 'dart:convert';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

import '../../config/APIService.dart';

class activeWork extends StatefulWidget {
  const activeWork({super.key});

  @override
  State<activeWork> createState() => _activeWorkState();
}

class _activeWorkState extends State<activeWork> {
  bool _isActivebutton = false;
  bool _isActivebutton2 = false;
  bool _isLoading = true;
  List Result = [];
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

  activecargoFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.corgaStatus);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List Results = data["cargos"];
        setState(() {
          _isLoading = false;
          Result = Results;
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
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
      final Map jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        String alertContent = jsonResponse["message"];

        alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
      } else {
        String alertContent = jsonResponse["message"];

        alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    activecargoFetch();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(178, 142, 22, 1),
                      Color.fromRGBO(226, 193, 121, 1),
                    ],
                    // stops: [0.4, 0.4],
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  )),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
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
                    // Text(
                    //   " Manage Active Work",
                    //   textAlign: TextAlign.left,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //       fontFamily: 'Nunito',
                    //       fontSize: AppFonts.mediumFontSize,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold),
                    // )
                  ],
                ),
              ),
            ),
            Positioned(
                child: Column(
              children: [
                // Container(
                //     margin: EdgeInsets.only(top: 60),
                //     child: Text(
                //       "Active Work",
                //       textAlign: TextAlign.left,
                //       overflow: TextOverflow.ellipsis,
                //       style: const TextStyle(
                //           fontFamily: 'Nunito',
                //           fontSize: AppFonts.smallFontSize,
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold),
                //     )),
                Container(
                    height: screenHeight * 0.22,
                    margin: EdgeInsets.only(top: 10),
                    child: _isLoading ? Text("") : Container()),
              ],
            ))
          ]),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              Unloadandloadcar("DEPARRIVE");
                              setActiveButton(false);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
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
                              "DEPARRIVED",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              Unloadandloadcar("LOAD");
                              setActiveButton2(true);
                            },
                            child: Text(
                              "LOAD",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              setActiveButton(false);
                              Unloadandloadcar("DESTARRIVE");
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
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
                              "DESTARRIVED",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 25,
                                  spreadRadius: 1,
                                ),
                              ]),
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              Unloadandloadcar("UNLOAD");
                              setActiveButton2(false);
                            },
                            child: Text(
                              "UNLOAD",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!_isActivebutton2) {
                                    return Color.fromRGBO(255, 255, 255, 1);
                                  } else {
                                    return Color.fromRGBO(255, 255, 255, 1);
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 5, // Spread radius
                                offset:
                                    Offset(0, 3), // Offset in (x,y) coordinates
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 25,
                                spreadRadius: 1,
                              ),
                            ]),
                        width: screenWidth * 0.44,
                        height: screenHeight * 0.1,
                        child: ElevatedButton(
                          onPressed: () {
                            Unloadandloadcar('DEPARTURE');
                            setActiveButton(true);
                          },
                          child: Text(
                            "DEPARTURE",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (!_isActivebutton) {
                                  return Color.fromRGBO(255, 255, 255, 1);
                                } else {
                                  return Color.fromRGBO(255, 255, 255, 1);
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
