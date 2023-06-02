import 'dart:math';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';

class availabelMarket extends StatefulWidget {
  @override
  State<availabelMarket> createState() => _availabelMarketState();
}

class _availabelMarketState extends State<availabelMarket> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.chevron_back),
                    iconSize: 23,
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: screenHeight * 0.2,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0,
                            4), // Adjust the offset to control the shadow's position
                      ),
                    ]),
                    width: screenWidth - 44,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              child: ClipPath(
                                clipper: QuarterCircleClipper(),
                                child: Container(
                                  width: screenWidth - 44,
                                  height: 50,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Avalabel market"),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("From"),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.trip_origin,
                                    color: Colors.black,
                                    size: 10,
                                  ),
                                )
                              ],
                            ),
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
                                            color: Colors.black, width: 2),
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.trip_origin,
                                        color: Colors.black,
                                        size: 10,
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
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: screenWidth * 0.3,
                                  child: Text("Addisa Ababa")),
                              SizedBox(
                                width: screenWidth * 0.15,
                              ),
                              SizedBox(
                                  width: screenWidth * 0.15,
                                  child: Text("Mekele")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.003,
                        ),
                        Row(
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.04),
                                child: Icon(Ionicons.time)),
                            SizedBox(
                              width: screenHeight * 0.235,
                            ),
                            Text("5/24/2023")
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0,
                            4), // Adjust the offset to control the shadow's position
                      ),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          painter: HalfCirclePainter(),
                          child: Container(
                            width: screenWidth - 44,
                            height: 100,
                            child: Container(
                              margin: EdgeInsets.only(right: 25),
                              child: CustomPaint(
                                size: Size(screenWidth * 0.1, 2),
                                painter: DashLinePainter(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0,
                            4), // Adjust the offset to control the shadow's position
                      ),
                    ]),
                    height: screenHeight * 0.173,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("Package")),
                                SizedBox(
                                  width: screenWidth * 0.08,
                                ),
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("Weight"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("__")),
                                SizedBox(
                                  width: screenWidth * 0.08,
                                ),
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("4500KG"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("Cargo type")),
                                SizedBox(
                                  width: screenWidth * 0.08,
                                ),
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("Price"))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("__")),
                                SizedBox(
                                  width: screenWidth * 0.08,
                                ),
                                Container(
                                    width: screenWidth * 0.35,
                                    child: Text("900000birr"))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
