import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import '../Owner/Driver/driversRegistrationForm.dart';
import 'DriverStatus.dart';
import 'OwnersDriver.dart';
import 'UnassignedDrivers.dart';

class communicate_screen extends StatelessWidget {
  const communicate_screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        // ignore: prefer_const_constructors
        title: Center(
          child: const Text(
            "Message",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(30, 120, 30, 0),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Register Driver",
                style: TextStyle(
                    color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
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
              child: const Text(
                "Manage Driver",
                style: TextStyle(
                    color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
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
                        builder: (context) => new UnassignedDrivers()));
              },
              child: const Text(
                "Assign Driver",
                style: TextStyle(
                    color: Color.fromRGBO(28, 21, 27, 0.7), fontSize: 20),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
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
    );
  }
}
