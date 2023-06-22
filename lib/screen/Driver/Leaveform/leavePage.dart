import 'package:flutter/material.dart';

import '../../../Theme/TextInput.dart';
import 'nextPageofleave.dart';

class leavepremmissionPage extends StatefulWidget {
  const leavepremmissionPage({super.key});

  @override
  State<leavepremmissionPage> createState() => _leavepremmissionPageState();
}

class _leavepremmissionPageState extends State<leavepremmissionPage> {
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.8,
              margin: EdgeInsets.only(top: screenHeight * 0.15),
              child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Text(
                      "First name",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Text(
                      "Last name",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Text(
                      "Phone number",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Text(
                      "Manager",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Text(
                      "Manager email",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ),
                Container(
                  height: screenHeight * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: screenHeight * 0.15,
                          child: Text(
                            "Leave Request For",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Container(
                          child: Container(
                            height: screenHeight * 0.02,
                            width: screenWidth * 0.08,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                value: _value,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Container(
                          child: Text(
                            'Days',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Container(
                          child: Container(
                            height: screenHeight * 0.02,
                            width: screenWidth * 0.08,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                value: _value,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Container(
                          child: Text(
                            'Hours',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => nextleavePage()));
                        },
                        child: Container(
                          height: 55,
                          width: screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Empty SizedBox if not loading
                              SizedBox(width: 8),
                              Text(
                                'Contiue',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromRGBO(255, 148, 165, 223);
                              }
                              // 98, 172, 181
                              return Colors.lightBlue;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))))),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
