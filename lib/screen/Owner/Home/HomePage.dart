import 'dart:convert';
import 'dart:ui';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/screen/Owner/Alert/Notification.dart';
import 'package:bazralogin/screen/Owner/market/avilabelMarketforowner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ionicons/ionicons.dart';
import '../../../Model/ApiConfig.dart';
import '../../../Model/driverCount.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;

import '../Driver/driversPage.dart';
import '../TripManagement/setGuzo.dart';
import '../Vehicle/vehicleStatus.dart';
import '../report/ownerReportstatus.dart';

class OwenerHomepage extends StatefulWidget {
  const OwenerHomepage({
    super.key,
  });

  @override
  State<OwenerHomepage> createState() => _OwenerHomepageState();
}

class _OwenerHomepageState extends State<OwenerHomepage> {
  DateTime pre_backprees = DateTime.now();
  static bool isPressed = true;
  bool _showExitSnackbar = false;

  late Future<String> _imageUrl;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  String Logoavtar = "";
  String ownerpic = "";
  String bazralogo = "";
  bool showExitSnackbar = false;
  String? phoneNumber;
  DateTime? currentBackPressTime;

  double _padding = 6.0;
  String query = '';

  Future<String> fetchImage() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "ownerpic", value: data["avatar"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["logo"];
    } else {
      throw Exception('Failed to load image');
    }
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
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "ownerpic", value: data["avatar"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["avatar"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
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

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.07,
              margin: EdgeInsets.only(top: screenHeight * 0.055),
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SizedBox(
                          height: screenHeight * 0.08,
                          width: screenWidth * 0.1,
                          child: ClipOval(
                              child: SizedBox(
                            height: screenHeight * 0.5,
                            width: screenWidth * 0.09,
                            child: FutureBuilder(
                              future: fetchImage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) return Text("");
                                return ClipOval(
                                  child: SizedBox(
                                      height: screenHeight * 0.4,
                                      width: screenWidth * 0.9,
                                      child: Image.network(
                                          snapshot.data.toString())),
                                );
                              },
                            ),
                          ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.13,
                      height: screenHeight * 0.08,
                      margin: EdgeInsets.only(left: screenWidth * 0.26),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    notificationPage()),
                          );
                        },
                        child: Icon(
                          Ionicons.notifications,
                          size: 28,
                          color: Color.fromRGBO(85, 164, 240, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),

                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(95, 112, 247, 1),
                        Color.fromRGBO(163, 163, 234, 1),
                      ],
                      // stops: [0.4, 0.4],
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  height: screenHeight * 0.23,
                  child: Column(children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.45,
                          child: Text(
                            " Good morning",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: screenWidth * 0.1),
                            child: Row(
                              children: [
                                Text(
                                  " Selem" + ",",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.37,
                                  child: Text(
                                    APIService.owner.toString(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: screenWidth * 0.07),
                          child: FutureBuilder(
                            future: _fetchLogo(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) return Text("");
                              return ClipOval(
                                child: SizedBox(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.09,
                                    child: Image.network(
                                        snapshot.data.toString())),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.13, left: 30, right: 30),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth * 0.35,
                                margin: EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 13,
                                        bottom: 13,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimaryColor,
                                      ),
                                      child: Text(
                                        CountDrivers.totalDrivers.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(11),
                                    ),
                                    Text(
                                      TranslationUtil.text('Driver'),
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.35,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 13,
                                        bottom: 13,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimaryColor,
                                      ),

                                      child: Text(
                                        APIService.totalVehicle.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(11),

                                      //use this class Circleborder() for circle shape.
                                    ),
                                    Text(
                                      TranslationUtil.text("Vehicle"),
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Container(
            //   height: screenHeight * 0.05,
            //   decoration: BoxDecoration(
            //     color: kBackgroundColor,
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10)),
            //   ),
            // ),
            Flexible(
              child: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 20),

                // margin: EdgeInsets.only(top: 35),
                child: GridView(
                  padding: EdgeInsets.zero,
                  // ignore: sort_child_properties_last
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkResponse(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => communicate_screen()));
                        }),
                        child: Ink(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(6),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.06,

                                    margin: EdgeInsets.only(top: 12),
                                    //height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/images/driver.png",
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Container(
                                    child: Text(TranslationUtil.text("Driver"),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
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
                                  builder: (context) => VehicleStatus()));
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
                                  margin: EdgeInsets.only(top: 10),
                                  // height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Icon(
                                    Icons.local_shipping,
                                    size: 50,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    TranslationUtil.text("Vehicle"),
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
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
                                  builder: (context) => ownerReportstatus()));
                        },
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/profit-report.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    TranslationUtil.text("Report"),
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
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
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    availabelMarket()),
                          );
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: EdgeInsets.only(top: 6),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/available.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    TranslationUtil.text("Available Market"),
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
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
                                  builder: (context) => tripHistory()));
                        },
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/travel.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    TranslationUtil.text('Trip management'),
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3),
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ));
  }
}
