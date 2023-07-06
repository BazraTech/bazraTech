import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/screen/Driver/avilablelMarket_Fordriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/APIService.dart';
import '../../../controller/Localization.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;
import '../../Theme/clippbox.dart';
import 'Notification/driverNotification.dart';
import 'Reportfordriver/driverReportstatus.dart';
import 'activeWork.dart';
import 'create_alert.dart';
import 'package:badges/badges.dart' as badges;

class Driver_Hompage extends StatefulWidget {
  const Driver_Hompage({
    super.key,
  });

  @override
  State<Driver_Hompage> createState() => _Driver_HompageState();
}

class _Driver_HompageState extends State<Driver_Hompage> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  String Logoavtar = "";
  String? plateNumber;
  DateTime? currentBackPressTime;
  String ownerpic = "";
  Map<String, dynamic>? Result;
  String? driverstate;
  String? startpalce;
  String? endplace;
  String? namedriver;
  bool _isLoading = true;
  List Listactivework = [];
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  int _current = 0;
  Map? jsonResponse;
  SharedPreferences? localStorage;
  //String? phoneNumber;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future fetchDriverinfo() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.drverInfo);
    var response = await client.get(url, headers: requestHeaders);
    final Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      await storage.write(
          key: "totalVehicles", value: data["state"].toString());

      driverstate = await storage.read(key: 'totalVehicles');
      await storage.write(
          key: "totalVehicle", value: data["driverName"].toString());

      namedriver = await storage.read(key: 'totalVehicle');
      setState(() {
        _isLoading = false;
        Result = data;
      });

      return Result;
    } else {}
  }

  //fetch driver status
  Future fetchActivework() async {
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

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      endplace = await storage.read(key: 'totalVehicle');
      setState(() {
        _isLoading = false;
        List Results = data["cargos"];
      });

      return Result;
    } else {}
  }

  Future<String> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Driver/Info'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);

      await storage.write(key: "ownerpic", value: data["driverPic"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["driverPic"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        // Show a Snackbar at the bottom indicating to press back again to exit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true; // Stop the default back button event
      }
    }
    return false;
    // Return true to stop the default back button event
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    fetchDriverinfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String tdata;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 243, 1),

        //ScrollConfiguration to remove glow effect
        body: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // fetch driver info

              Container(
                child: Stack(children: [
                  Container(
                    height: screenHeight * 0.25,
                    // margin: EdgeInsets.only(bottom: 40),
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 46),
                                  child: SizedBox(
                                    height: screenHeight * 0.1,
                                    width: screenWidth - 80,
                                    child: FutureBuilder(
                                        future: _fetchLogo(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.done)
                                            return Text("");
                                          return SizedBox(
                                              height: screenHeight * 0.2,
                                              width: screenWidth * 0.9,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      height:
                                                          screenHeight * 0.1,
                                                      child: Image.file(
                                                          File(ownerpic))),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 30),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              screenWidth * 0.3,
                                                          child: Text(
                                                            "Well back ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          width:
                                                              screenWidth * 0.3,
                                                          child:
                                                              Result?['driverName'] ==
                                                                      null
                                                                  ? Container()
                                                                  : Text(
                                                                      Result?[
                                                                          'driverName'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize:
                                                                              14,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ));
                                        }),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              drivernotificationPage()));
                                },
                                child: Container(
                                  height: screenHeight * 0.1,
                                  margin: EdgeInsets.only(right: 35, top: 0),
                                  width: screenWidth * 0.06,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: -10, end: -33),
                                      showBadge: true,
                                      ignorePointer: false,
                                      badgeContent: Text(
                                        "20",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Colors.white,
                                          fontSize: AppFonts.smallFontSize,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      drivernotificationPage()));
                                        },
                                        child: Icon(
                                          Ionicons.notifications,
                                          size: 27,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            child: Text(
                              "Today work shudule",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: screenHeight * 0.24,
                          margin: EdgeInsets.only(top: 150),
                          child: _isLoading
                              ? Text("")
                              : ListView.builder(
                                  itemCount: 1,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            height: screenHeight * 0.19,
                                            width: screenWidth - 42,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                top: screenWidth * 0.05,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.trip_origin,
                                                            color: Colors.green,
                                                          )),
                                                      CustomPaint(
                                                        size: Size(
                                                            screenWidth * 0.14,
                                                            2),
                                                        painter:
                                                            DashLinePainter(),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          height: screenHeight *
                                                              0.09,
                                                          width: screenWidth *
                                                              0.09,
                                                          child: Container(
                                                            child: Icon(
                                                              Icons
                                                                  .local_shipping,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      CustomPaint(
                                                        size: Size(
                                                            screenWidth * 0.14,
                                                            2),
                                                        painter:
                                                            DashLinePainter(),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.trip_origin,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: screenWidth *
                                                              0.26,
                                                          margin: EdgeInsets.only(
                                                              left:
                                                                  screenWidth *
                                                                      0.15),
                                                          child: Text(
                                                            Result!["status"],
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.1,
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Container(
                                                            width: screenWidth *
                                                                0.26,
                                                            child: Text(
                                                              Result!["status"],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                        ),
                      ),
                    ],
                  ))
                ]),
              ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridView(
                    // ignore: sort_child_properties_last
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkResponse(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        availabelMarketfordriver()));
                          }),
                          child: Ink(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
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
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      margin: EdgeInsets.only(top: 12),
                                      //height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Icon(
                                        Icons.work,
                                        size: 35,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                        TranslationUtil.text(
                                            "Available Market"),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: AppFonts.smallFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => activeWork()));
                            // if (Result!.isEmpty) {
                            //   fetchActivework();

                            //   if (Result!["status"] == "ONROUTE") {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => activeWork()));
                            //   }
                            // } else {
                            //   alertutilsfordriver.showMyDialog(
                            //       context, "Alert", "Driver not accept job");
                            // }
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
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
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Icons.work,
                                      size: 35,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Active work",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        driverReportstatus()));
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
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
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Icons.insert_drive_file_rounded,
                                      size: 35,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      TranslationUtil.text("Report"),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (() {
                            if (Result!["plateNumber"] == null) {
                              alertutils.showMyDialog(
                                  context, "Alert", "Driver not onroute");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAlert(
                                            title: '',
                                          )));
                            }
                          }),
                          child: AnimatedContainer(
                              //padding: EdgeInsets.only(bottom: _padding),
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
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
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Ionicons.alert,
                                      size: 35,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      TranslationUtil.text("Create Alert"),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: screenHeight / (screenWidth * 1.4),
                      maxCrossAxisExtent: 260,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
