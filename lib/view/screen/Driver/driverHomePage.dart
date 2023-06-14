import 'dart:convert';
import 'dart:ui';

import 'package:bazralogin/view/screen/Driver/avilablelMarket_Fordriver.dart';

import 'package:bazralogin/view/screen/Driver/activeWork.dart';
import 'package:bazralogin/view/screen/Owner/Driver/updateDriverinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../config/APIService.dart';
import '../../../controller/Localization.dart';
import '../../../Theme/verticalDash.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;
import 'Notification/driverNotification.dart';
import 'create_alert.dart';
import 'driverReportstatus.dart';

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

  String ownerpic = "";
  Map<String, dynamic>? Result;
  String? driverstate;
  String? startpalce;
  String? endplace;
  String? phoneNumber;
  bool _isLoading = true;
  List Listactivework = [];
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  int _current = 0;
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

// fetch driver info
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

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      await storage.write(
          key: "totalVehicles", value: data["state"].toString());

      driverstate = await storage.read(key: 'totalVehicles');
      await storage.write(
          key: "totalVehicle", value: data["plateNumber"].toString());

      plateNumber = await storage.read(key: 'totalVehicle');
      setState(() {
        _isLoading = false;
        Result = data;
      });

      return Result;
    } else {}
  }
  //

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

  @override
  void initState() {
    fetchDriverinfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(driverstate);
    String tdata;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 243, 1),
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth - 32,
                child: Row(
                  children: [
                    Container(
                      child: SizedBox(
                          height: screenHeight * 0.08,
                          child: ClipOval(
                              child: SizedBox(
                            height: screenHeight * 0.5,
                            width: screenWidth * 0.09,
                            child: FutureBuilder(
                              future: _fetchLogo(),
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
                    SizedBox(
                      width: screenWidth * 0.66,
                    ),
                    Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.09,
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: 7,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        drivernotificationPage()));
                          },

                          child: Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Icon(
                                Ionicons.notifications,
                                size: 23,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          //use this class Circleborder() for circle shape.
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [],
              )
            ],
          ),
        ),
        //ScrollConfiguration to remove glow effect
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // fetch driver info

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(95, 112, 247, 1),
                      Color.fromRGBO(163, 163, 234, 1),
                    ],
                    // stops: [0.4, 0.4],
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
                height: screenHeight * 0.28,
                child: Column(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Today's Schedule",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 14, top: 9),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.trip_origin,
                                  color: Colors.green,
                                  size: 10,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "From ",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: startpalce == null
                                          ? Text('__')
                                          : Text(startpalce.toString()),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 14, top: 0),
                        child: SizedBox(
                          width: screenWidth * 0.22,
                          child: Text(
                            "Start date   \n12/2/2022",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 46,
                      margin:
                          EdgeInsets.only(right: screenWidth * 0.62, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                            child: CustomPaint(
                              painter: DashedLineVerticalPainter(),
                              size: Size(
                                1.5,
                                double.infinity,
                              ),
                            ),
                          ),
                          // Adjust the vertical offset as needed
                          Icon(
                            Icons.local_shipping,
                            color: Colors.black,
                          ),

                          SizedBox(
                            height: 10,
                            child: CustomPaint(
                              painter: DashedLineVerticalPainter(),
                              size: Size(
                                1.5,
                                double.infinity,
                              ),
                            ),
                          ),
                        ],
                      )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.trip_origin,
                                  color: Colors.red,
                                  size: 10,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Text(
                                  "To \n Djibuti",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: SizedBox(
                          width: screenWidth * 0.22,
                          child: Text(
                            "End date   \n12/3/2022",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
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
                                        Icons.calendar_month,
                                        size: 35,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                          TranslationUtil.text(
                                              "Available Market"),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
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
                            print(driverstate);
                            if (Result!['state'] == null) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Container(
                                      padding: EdgeInsets.all(10),
                                      color: kPrimaryColor,
                                      child: Center(
                                          child: Container(
                                              height: 20,
                                              child: Text(
                                                'Alert',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )))),
                                  content: Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        'Driver not accept job',
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => activeWork()));
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
                                    child: Text("Active work",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
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
                                    child: Text(TranslationUtil.text("Report"),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (() {
                            if (Result!['plateNumber'] == null) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Container(
                                      padding: EdgeInsets.all(10),
                                      color: kPrimaryColor,
                                      child: Center(
                                          child: Container(
                                              height: 20,
                                              child: Text(
                                                'Alert',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )))),
                                  content: Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        'Driver not on route',
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAlert(
                                            title: '',
                                          )));
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 13)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: screenHeight / (screenWidth * 1.2),
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _current,
        count: 5,
      );
}
