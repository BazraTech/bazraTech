import 'package:flutter/material.dart';

import '../../../../Theme/clippbox.dart';
import '../../../../const/constant.dart';

class alertComponent extends StatefulWidget {
  final dynamic data;

  alertComponent({
    required this.data,
  });

  @override
  State<alertComponent> createState() => _alertComponentState();
}

class _alertComponentState extends State<alertComponent> {
  bool isVisible = true;
  void toggleVisibility1() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          isVisible
              ? GestureDetector(
                  onTap: toggleVisibility1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight * 0.2,
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
                              margin: EdgeInsets.only(left: screenWidth * 0.34),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Alert Report",
                                  ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
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
                                  child: Text("1/22/2022",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))),
                            ],
                          ),
                        ],
                      )),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: toggleVisibility1,
                  child: Container(
                      height: screenHeight,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                                      .withOpacity(0.8),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0,
                                                      4), // Adjust the offset to control the shadow's position
                                                ),
                                              ]),
                                          height: screenHeight * 0.26,
                                          margin: EdgeInsets.zero,
                                          width: screenWidth - 22,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.zero,
                                                    child: ClipPath(
                                                      clipper:
                                                          QuarterCircleClipper(),
                                                      child: Container(
                                                        width: screenWidth - 44,
                                                        height: 30,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                width: screenWidth,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                  child: Text(
                                                                      "From",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize: AppFonts
                                                                              .smallFontSize,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.normal))),
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
                                                                      width: 2),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .trip_origin,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 10,
                                                                ),
                                                              )
                                                            ],
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
                                                            height: 35,
                                                            width: screenWidth *
                                                                0.07,
                                                            child: Icon(
                                                              Icons
                                                                  .local_shipping,
                                                              color: Colors.red,
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
                                                                      0.2,
                                                              child: Row(
                                                                children: [
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
                                                                          .red,
                                                                      size: 10,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text("To",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize: AppFonts
                                                                              .smallFontSize,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.normal)),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width: screenWidth *
                                                                  0.3,
                                                              child: Text(
                                                                  widget.data[
                                                                          index][
                                                                      "alertocation"],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.13,
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Mekele",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Driver",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                              width: screenWidth *
                                                                  0.35,
                                                              child: Text(
                                                                  widget.data[
                                                                          index][
                                                                      'driver'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Plate Number")),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                              width: screenWidth *
                                                                  0.35,
                                                              child: Text(
                                                                  widget.data[
                                                                          index][
                                                                      'plateNumber'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Alert Type",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                              width: screenWidth *
                                                                  0.35,
                                                              child: Text(
                                                                  widget.data[
                                                                          index][
                                                                      'alertType'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)))
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Start Time",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                widget.data[
                                                                        index][
                                                                    'alertstart'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width: screenWidth *
                                                                  0.35,
                                                              child: Text(
                                                                  "End Time",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                widget.data[
                                                                        index][
                                                                    'alertfinish'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                  "Alert Location",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal))),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.08,
                                                          ),
                                                          Container(
                                                              width: screenWidth *
                                                                  0.35,
                                                              child: Text(
                                                                  widget.data[
                                                                          index][
                                                                      "alertocation"],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)))
                                                        ],
                                                      ),
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
    );
  }
}
