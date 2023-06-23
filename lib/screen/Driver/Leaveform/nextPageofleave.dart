import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Theme/TextInput.dart';

class nextleavePage extends StatefulWidget {
  const nextleavePage({super.key});

  @override
  State<nextleavePage> createState() => _nextleavePageState();
}

class _nextleavePageState extends State<nextleavePage> {
  @override
  bool _value = true;
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Ionicons.arrow_back)),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //       child: Text(
                  //     'Leave form',
                  //     textAlign: TextAlign.left,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(
                  //         fontFamily: 'Nunito',
                  //         fontSize: AppFonts.mediumFontSize,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.bold),
                  //   )),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                margin: EdgeInsets.only(top: screenHeight * 0.15),
                child: Column(children: [
                  Container(
                    height: screenHeight * 0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenWidth * 0.19,
                            height: screenHeight * 0.07,
                            child: Text(
                              "Leave Start",
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
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Column(
                          children: [
                            Container(
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.05,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Month",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          children: [
                            Container(
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.05,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Day",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          children: [
                            Container(
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.05,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Year",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: screenWidth * 0.09,
                              height: screenHeight * 0.05,
                              child: Icon(Icons.calendar_month)),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenWidth * 0.19,
                            height: screenHeight * 0.08,
                            child: Text(
                              "Leave  End",
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
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Column(
                          children: [
                            Container(
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.05,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Month",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          children: [
                            Container(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.14,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Day",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          children: [
                            Container(
                                width: screenWidth * 0.14,
                                height: screenHeight * 0.05,
                                child: TextField(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                                width: screenWidth * 0.14,
                                child: Text(
                                  "Year",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: screenWidth * 0.09,
                              height: screenHeight * 0.05,
                              child: Icon(Icons.calendar_month)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.19,
                            child: Text(
                              "Leave Type",
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
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Container(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
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
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: screenHeight * 0.02,
                                  width: screenWidth * 0.13,
                                  child: Text(
                                    "Vaction",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Container(
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
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: screenHeight * 0.02,
                                  width: screenWidth * 0.13,
                                  child: Text(
                                    "Quitting",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Container(
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
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: screenHeight * 0.02,
                                  width: screenWidth * 0.13,
                                  child: Text(
                                    "Other",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                        SizedBox(
                          width: screenWidth * 0.08,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: screenWidth * 0.23,
                            child: Row(
                              children: [
                                Container(
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
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  height: screenHeight * 0.02,
                                  width: screenWidth * 0.13,
                                  child: Text(
                                    "Sick",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(
                        "Comment",
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth - 24,
                        height: screenHeight * 0.1,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Write your message',
                            border: OutlineInputBorder(),
                            hintStyle: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                        ),
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth - 24,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Empty SizedBox if not loading
                                  SizedBox(width: 8),
                                  Text(
                                    'Request Leave',
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
                                        borderRadius:
                                            BorderRadius.circular(6))))),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
