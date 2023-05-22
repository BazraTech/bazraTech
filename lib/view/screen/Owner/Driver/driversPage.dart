import 'package:bazralogin/controller/Localization.dart';


import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: screenHeight * 0.1, top: screenHeight * 0.04),
                      child: Text(
                        "Driver Page",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(30, 120, 30, 0),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriversFormOwner()));
                },
                child: Text(
                  TranslationUtil.text("Register Driver"),
                  style: TextStyle(
                      color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(255, 249, 248, 248);
                      }
                      return const Color.fromARGB(255, 255, 255, 255);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => DriverStatus()));
                },
                child: Text(
                  TranslationUtil.text("Manage Driver"),
                  style: TextStyle(
                      color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(246, 248, 250, 248);
                      }
                      return const Color.fromARGB(255, 255, 255, 255);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => UnassignedDrivers()));
                },
                child: Text(
                  TranslationUtil.text("Assign Driver"),
                  style: TextStyle(
                      color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(246, 248, 250, 248);
                      }
                      return const Color.fromARGB(255, 255, 255, 255);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}