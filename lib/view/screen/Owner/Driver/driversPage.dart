import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

import 'DriverStatus.dart';
import 'OwnersDriver.dart';
import 'UnassignedDrivers.dart';
import 'driversRegistrationForm.dart';

class communicate_screen extends StatelessWidget {
  const communicate_screen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 240, 243, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.04),
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.14,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(
                          Ionicons.chevron_back,
                          size: 23,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: screenHeight * 0.1, top: screenHeight * 0.04),
                      child: Text(
                        "Driver Page",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => UnassignedDrivers()));
                  },
                  child: Container(
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.39,
                    // Height of the border

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.3), // Shadow color
                              blurRadius: 5, // Spread radius
                              offset:
                                  Offset(0, 3), // Offset in (x,y) coordinates
                            ),
                          ],
                          color: Color.fromRGBO(236, 240, 243, 1),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Color.fromRGBO(
                                255, 255, 255, 1), // Set the border color
                            width: 2.5,
                          )),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Assign driver",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => DriverStatus()));
                  },
                  child: Container(
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.39,
                    // Height of the border

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.3), // Shadow color
                              blurRadius: 5, // Spread radius
                              offset:
                                  Offset(0, 3), // Offset in (x,y) coordinates
                            ),
                          ],
                          color: Color.fromRGBO(236, 240, 243, 1),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Color.fromRGBO(
                                255, 255, 255, 1), // Set the border color
                            width: 2.5,
                          )),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Manage driver",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: screenWidth * 0.1),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriversFormOwner()));
                    },
                    child: Container(
                      height: screenHeight * 0.17,
                      width: screenWidth * 0.39,
                      // Height of the border

                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 5, // Spread radius
                            offset: Offset(0, 3), // Offset in (x,y) coordinates
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 5, // Spread radius
                                offset:
                                    Offset(0, 3), // Offset in (x,y) coordinates
                              ),
                            ],
                            color: Color.fromRGBO(236, 240, 243, 1),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white, // Set the border color
                              width: 2.5,
                            )),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Register driver",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
