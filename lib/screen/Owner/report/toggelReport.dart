import 'dart:convert';

import 'package:bazralogin/Theme/clippbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../../../const/constant.dart';
import 'alertComponet/alertComponetforowner.dart';

class MyScreen extends StatefulWidget {
  String? time;
  MyScreen({this.time});
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool showList = false;
  bool showList1 = false;
  bool showList2 = false;
  dynamic fetchedData;

  final ScrollController _scrollController = ScrollController();
  List<String> yourList = []; // Your initial list of data
  int currentPage = 1;
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
          'http://64.226.104.50:9090/Api/Vehicle/Alerts/ByStatus',
        ),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mydata = data["inactiveAlerts"];
      List results = [];
      String? Daily = "Daily";
      String? Weekly = "Weekly";
      if (Daily == "${widget.time}") {
        var output = <String>[];
        DateTime startDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 168))));
        DateTime endDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 24))));
        for (var i = 0; i < mydata.length; i += 1) {
          List filteredDataList = mydata.where((data) {
            DateTime date = DateTime.parse(mydata[i]["alertstart"]);
            return date.isBefore(endDate);
          }).toList();
          // mydata[i]["alertstart"];
          // print(mydata[i]["alertstart"]);

          // if (mydata[i]["alertstart"].compareTo(
          //             DateFormat('yyyy-MM-dd HH').format(DateTime.now())) <=
          //         0 &&
          //     mydata[i]["alertstart"].compareTo(DateFormat('yyyy-MM-dd HH')
          //             .format(DateTime.now().subtract(Duration(hours: 24)))) <=
          //         0) {
          //   output.add(mydata[i]["alertstart"]);
          // }
          print(filteredDataList);
        }

        setState(() {
          fetchedData = mydata;
          currentPage++;
        });
        alertComponentforowner(
          data: mydata,
          scrollController: _scrollController,
        );
      }
      // } else if (Weekly == "${widget.time}") {
      //   var output = <String>[];
      //   DateTime startDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
      //       .format(DateTime.now().subtract(Duration(hours: 168))));
      //   DateTime endDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
      //       .format(DateTime.now().subtract(Duration(hours: 24))));
      //   for (var i = 0; i < mydata.length; i += 1) {
      //     List filteredDataList = mydata.where((data) {
      //       DateTime date = DateTime.parse(mydata[i]["alertstart"]);
      //       return date.isAfter(startDate) && date.isBefore(endDate);
      //     }).toList();
      //     // mydata[i]["alertstart"];
      //     // print(mydata[i]["alertstart"]);

      //     // if (mydata[i]["alertstart"].compareTo(
      //     //             DateFormat('yyyy-MM-dd HH').format(DateTime.now())) <=
      //     //         0 &&
      //     //     mydata[i]["alertstart"].compareTo(DateFormat('yyyy-MM-dd HH')
      //     //             .format(DateTime.now().subtract(Duration(hours: 24)))) <=
      //     //         0) {
      //     //   output.add(mydata[i]["alertstart"]);
      //     // }
      //     print(filteredDataList);
      //   }

      //   setState(() {
      //     fetchedData = mydata;
      //     currentPage++;
      //   });
      //   alertComponentforowner(
      //     data: mydata,
      //     scrollController: _scrollController,
      //   );
      // }
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
      showList1 = !showList1;
    });
  }

  void toggleVisibility2() {
    setState(() {
      showList2 = !showList2;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      fetchData();
    }
  }

  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Container(
          child: Text(
            "Report",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: AppFonts.mediumFontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                                                          screenHeight * 0.28,
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
                                                                    height: 30,
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
                                                                      "From",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
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
                                                                          "To",
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
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
                                                                      "Addisa Ababa",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    )),
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
                                                                      "Mekele",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    )),
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
                                                                    child: Text(
                                                                  "Time",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                                SizedBox(
                                                                  width:
                                                                      screenHeight *
                                                                          0.235,
                                                                ),
                                                                Text(
                                                                  "5/24/2023",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )
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
                                                                              Text(
                                                                            "Package",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text(
                                                                            "Weight",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ))
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
                                                                              Text(
                                                                            "4500KG",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text(
                                                                            "Cargo type",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text(
                                                                            "Price",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text(
                                                                            "__",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: screenWidth *
                                                                            0.08,
                                                                      ),
                                                                      Container(
                                                                          width: screenWidth *
                                                                              0.35,
                                                                          child:
                                                                              Text(
                                                                            "900000birr",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ))
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
              height: screenHeight - 30,
              child: fetchedData != null
                  ? alertComponentforowner(
                      data: fetchedData,
                      scrollController: _scrollController,
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
