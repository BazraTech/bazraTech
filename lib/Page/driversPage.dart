// ignore_for_file: sort_child_properties_last

import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'driversProfile.dart';

class communicate_screen extends StatelessWidget {
  const communicate_screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text('Communicate'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 234, 242),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFA7A9AF),
                  offset: Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 0.0,
                  // inset:isPressed,
                ),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 30),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(30, 120, 30, 0),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.driverRegistration);
              },
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
                          borderRadius: BorderRadius.circular(25)))),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 234, 242),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFA7A9AF),
                  offset: Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 0.0,
                  // inset:isPressed,
                ),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 30),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DriversProfile()));
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
                          borderRadius: BorderRadius.circular(25)))),
            ),
          ),
        ],
      ),
    );
  }
}
