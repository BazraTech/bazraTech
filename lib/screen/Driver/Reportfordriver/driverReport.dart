import 'dart:convert';

import 'package:bazralogin/Theme/clippbox.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../const/constant.dart';
import 'alertComponent/alertcomponent.dart';

class driverReport extends StatefulWidget {
  @override
  _driverReportState createState() => _driverReportState();
}

class _driverReportState extends State<driverReport> {
  bool showList = false;
  bool showList1 = true;
  bool showList2 = false;
  dynamic fetchedData;
  fetchData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
          'http://64.226.104.50:9090/Api/Driver/Alerts/ByStatus',
        ),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mydata = data["inactiveAlerts"];
      setState(() {
        fetchedData = mydata;
      });
      alertComponent(
        data: mydata,
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void toggleVisibility() {
    setState(() {
      showList = !showList;
    });
  }

  void toggleVisibility1() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void toggleVisibility2() {
    setState(() {
      showList2 = !showList2;
    });
  }

  bool isVisible = false;

  void initState() {
    super.initState();
    fetchData();
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
            SizedBox(
              height: 60,
            ),
            showList
                ? Visibility(
                    visible: showList,
                    child: Container(
                      height: screenHeight,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: toggleVisibility,
                              child: Container(
                                  height: screenHeight,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8),
                                                              spreadRadius: 2,
                                                              blurRadius: 5,
                                                              offset: Offset(0,
                                                                  4), // Adjust the offset to control the shadow's position
                                                            ),
                                                          ]),
                                                      height:
                                                          screenHeight * 0.4,
                                                      margin: EdgeInsets.zero,
                                                      width: screenWidth - 22,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .zero,
                                                                child: ClipPath(
                                                                  clipper:
                                                                      QuarterCircleClipper(),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        screenWidth -
                                                                            44,
                                                                    height: 50,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "From"),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 2),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .trip_origin,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                CustomPaint(
                                                                  size: Size(
                                                                      screenWidth *
                                                                          0.19,
                                                                      2),
                                                                  painter:
                                                                      DashLinePainter(),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      screenHeight *
                                                                          0.07,
                                                                  width:
                                                                      screenWidth *
                                                                          0.07,
                                                                  child: Icon(
                                                                    Icons
                                                                        .local_shipping,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 23,
                                                                  ),
                                                                ),
                                                                CustomPaint(
                                                                  size: Size(
                                                                      screenWidth *
                                                                          0.2,
                                                                      2),
                                                                  painter:
                                                                      DashLinePainter(),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.2,
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.black, width: 2),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          child:
                                                                              Icon(
                                                                            Icons.trip_origin,
                                                                            color:
                                                                                Colors.black,
                                                                            size:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                            "To"),
                                                                      ],
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width:
                                                                        screenWidth *
                                                                            0.3,
                                                                    child: Text(
                                                                        "Addisa Ababa")),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.15,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.15,
                                                                    child: Text(
                                                                        "Mekele")),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.003,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    child: Icon(
                                                                        Ionicons
                                                                            .time)),
                                                                SizedBox(
                                                                  width:
                                                                      screenHeight *
                                                                          0.235,
                                                                ),
                                                                Text(
                                                                    "5/24/2023")
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            width: screenWidth,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("Package")),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("Weight"))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("__")),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("4500KG"))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("Cargo type")),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("Price"))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("__")),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text("900000birr"))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  )),
                            ),
                            // Add more containers as needed
                          ],
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: toggleVisibility,
                    child: showList
                        ? Container(
                            width: screenWidth,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: screenHeight * 0.16,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0,
                                        4), // Adjust the offset to control the shadow's position
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.03,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: screenWidth * 0.34),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Trip Report"))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.trip_origin,
                                          color: Colors.green,
                                          size: 10,
                                        ),
                                      ),
                                      CustomPaint(
                                        size: Size(screenWidth * 0.2, 2),
                                        painter: DashLinePainter(),
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.07,
                                        child: Icon(
                                          Icons.local_shipping,
                                          color: Colors.red,
                                          size: 23,
                                        ),
                                      ),
                                      CustomPaint(
                                        size: Size(screenWidth * 0.2, 2),
                                        painter: DashLinePainter(),
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.2,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: Icon(
                                                  Icons.trip_origin,
                                                  color: Colors.red,
                                                  size: 10,
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: screenWidth * 0.36,
                                          child: Text("12/2/220")),
                                      SizedBox(
                                        width: screenWidth * 0.15,
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.2,
                                          child: Text("1/22/2022")),
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          )),
            // alert report
            showList2
                ? Visibility(
                    visible: showList2,
                    child: Container(
                      height: screenHeight,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: toggleVisibility2,
                            child: Container(
                                height: screenHeight,
                                width: double.infinity,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                4), // Adjust the offset to control the shadow's position
                                                          ),
                                                        ]),
                                                    height: screenHeight * 0.38,
                                                    margin: EdgeInsets.zero,
                                                    width: screenWidth - 22,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .zero,
                                                              child: ClipPath(
                                                                clipper:
                                                                    QuarterCircleClipper(),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      screenWidth -
                                                                          44,
                                                                  height: 50,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text("From"),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              2),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .trip_origin,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 10,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            CustomPaint(
                                                              size: Size(
                                                                  screenWidth *
                                                                      0.12,
                                                                  2),
                                                              painter:
                                                                  DashLinePainter(),
                                                            ),
                                                            Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.07,
                                                              width:
                                                                  screenWidth *
                                                                      0.07,
                                                              child: Icon(
                                                                Icons
                                                                    .local_shipping,
                                                                color:
                                                                    Colors.red,
                                                                size: 23,
                                                              ),
                                                            ),
                                                            CustomPaint(
                                                              size: Size(
                                                                  screenWidth *
                                                                      0.12,
                                                                  2),
                                                              painter:
                                                                  DashLinePainter(),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.13,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 2),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .trip_origin,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text("To"),
                                                                  ],
                                                                ))
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  width:
                                                                      screenWidth *
                                                                          0.3,
                                                                  child: Text(
                                                                      "Addisa Ababa")),
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.15,
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.15,
                                                                  child: Text(
                                                                      "Mekele")),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeight *
                                                              0.003,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  child: Icon(
                                                                      Ionicons
                                                                          .time)),
                                                              SizedBox(
                                                                width:
                                                                    screenHeight *
                                                                        0.22,
                                                              ),
                                                              Text("5/24/2023")
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          width: screenWidth,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Package")),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Weight"))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "__")),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "4500KG"))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Cargo type")),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Price"))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "__")),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "900000birr"))
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                )),
                          ),
                          // Add more containers as needed
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: toggleVisibility2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight * 0.16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0,
                                  4), // Adjust the offset to control the shadow's position
                            ),
                          ],
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.34),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Work Report"))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: screenWidth * 0.08,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.trip_origin,
                                    color: Colors.green,
                                    size: 10,
                                  ),
                                ),
                                CustomPaint(
                                  size: Size(screenWidth * 0.2, 2),
                                  painter: DashLinePainter(),
                                ),
                                Container(
                                  height: screenHeight * 0.07,
                                  width: screenWidth * 0.07,
                                  child: Icon(
                                    Icons.local_shipping,
                                    color: Colors.red,
                                    size: 23,
                                  ),
                                ),
                                CustomPaint(
                                  size: Size(screenWidth * 0.2, 2),
                                  painter: DashLinePainter(),
                                ),
                                SizedBox(
                                    width: screenWidth * 0.2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.trip_origin,
                                            color: Colors.red,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: screenWidth * 0.36,
                                    child: Text("12/2/220")),
                                SizedBox(
                                  width: screenWidth * 0.15,
                                ),
                                SizedBox(
                                    width: screenWidth * 0.2,
                                    child: Text("1/22/2022")),
                              ],
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
            //work report
            Container(
              height: screenHeight,
              child: fetchedData != null
                  ? alertComponent(
                      data: fetchedData,
                    )
                  : Center(child: CircularProgressIndicator()),
              //
            )
          ],
        ),
      ),
    );
  }
}
