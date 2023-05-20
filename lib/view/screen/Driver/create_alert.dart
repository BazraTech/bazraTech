import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../const/constant.dart';
import 'driverHomePage.dart';

class CreateAlert extends StatefulWidget {
  CreateAlert({required this.title});
  final String title;
  @override
  _CreateAlertState createState() => _CreateAlertState();
}

class _CreateAlertState extends State {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController locations = TextEditingController();
  //List _toDoListAlert = [];
  final _formKey = GlobalKey<FormState>();
  List<String> _toDoListLocation = [];
  List<String> _toDoListAlert = [];
  static bool isPressed = true;
  bool isalert = true;
  String? alertType;
  List<String> type = [
    "OFFROAD",
    "CAR CRASH",
    "ROAD ACCIDENT",
    "CAR TIRE FAILURE",
    "ACCIDENT"
  ];
  int _seconds = 0;
  Timer? _timer;
  String? timecounter;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        Duration duration = Duration(seconds: _seconds);
        timecounter = DateFormat('mm:ss')
            .format(DateTime(0, 0, 0, 0, 0, duration.inSeconds));
      });
    });
  }

  _addToAlert(String chooseAlertType) {
    if (chooseAlertType != null) {
      setState(() {
        _toDoListLocation.add(chooseAlertType);
      });
      _textEditingController.clear();
      _saveToDoList();
    }
  }

  _deleteToDoItem(int index) {
    setState(() {
      _toDoListLocation.removeAt(index);
    });
    _saveToDoList();
  }

  _loadToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? loadedList = prefs.getStringList('toDoList');

    if (loadedList != null) {
      setState(() {
        _toDoListLocation = loadedList.cast();
      });
    }
  }

  _saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('toDoList', _toDoListLocation.cast());
  }

  void Create_Alert() async {
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map data = {
      "alertType": alertType,
      "location": "ADDIS ABABA",
    };
    final url = Uri.parse("http://64.226.104.50:9090/Api/Driver/CreateAlert");
    http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    }).then((response) {
      _startTimer();
    }).catchError((error) {
      print('Error: $error');
    });
  }

// finish alert
  void finishAlert() async {
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map data = {
      "alertType": alertType,
      "location": "ADDIS ABABA",
    };
    final url =
        Uri.parse("http://64.226.104.50:9090/Api/Driver/FinishAlert/224");
    http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    }).then((response) {
      _stopTimer();
      print("yes");
    }).catchError((error) {
      print('Error: $error');
      print("no");
    });
  }

  DateTime greeting() {
    var hour = DateTime.now();

    return hour;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child: Container(
                height: 40,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Register Successfully ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriverHomePage()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var currentTime = new DateTime(now.day, now.hour);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
        title: Container(
          margin: EdgeInsets.only(left: screenWidth * 0.15),
          child: Text(
            "Create Alert ",
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 17,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Container(
                margin: EdgeInsets.only(
                  bottom: 70,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.07,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Select alert type",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 17,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Column(children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.9,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isalert,
                                    onChanged: (value) {},
                                  ),
                                  Text(
                                    " OFFROAD",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.9,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isalert,
                                    onChanged: (value) {},
                                  ),
                                  Text(
                                    " ACCIDENT",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.9,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isalert,
                                    onChanged: (value) {},
                                  ),
                                  Text(
                                    "Car Crash",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.525,
                    height: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      tileColor: Colors.white,
                      title: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 10, bottom: 20),
                              child: Text('$timecounter' ?? '__')),
                          Center(child: Text("$alertType")),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  onPressed: () => {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Color.fromRGBO(
                                              255, 148, 165, 223);
                                        }
                                        // 98, 172, 181
                                        return Colors.lightBlue;
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)))),
                                  child: GestureDetector(
                                    onTap: () {
                                      Create_Alert();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.265,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: Center(
                                        child: Text(" Create Alert",
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  onPressed: () => {
                                    if (_formKey.currentState!.validate())
                                      {
                                        _addToAlert(alertType.toString()),
                                      }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Color.fromRGBO(
                                              255, 148, 165, 223);
                                        }
                                        // 98, 172, 181
                                        return Colors.lightBlue;
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)))),
                                  child: GestureDetector(
                                    onTap: () {
                                      finishAlert();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.265,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: const Center(
                                        child: Text(
                                          " Finish Alert",
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
