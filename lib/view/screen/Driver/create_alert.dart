import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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

  bool isalert = true;
  bool _value = true;
  String? alertType;

  List<bool> _checkedItems = [false, false, false, false, false];
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
  int selectedIndex = -1;

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
      "alertType": "${alertType}",
      "location": "ADDIS ABABA",
    };
    final url = Uri.parse("http://64.226.104.50:9090/Api/Driver/CreateAlert");
    final response = await http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    });
    final Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      String alertContent = jsonResponse["message"];
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('API Response'),
          content: Text(alertContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      String alertContent = jsonResponse["message"];
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(''),
          content: Text(alertContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Center(child: Text('Success')),
          content: Text('API call was successful'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      print("yes");
    }).catchError((error) {});
  }

  DateTime greeting() {
    var hour = DateTime.now();

    return hour;
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
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(left: screenWidth * 0.15),
          child: Text(
            "Create Alert ",
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 17,
              color: Colors.black,
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
                      height: screenHeight * 0.4,
                      child: ListView.builder(
                        itemCount: type.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.3), // Shadow color
                                                      blurRadius:
                                                          5, // Spread radius
                                                      offset: Offset(0,
                                                          3), // Offset in (x,y) coordinates
                                                    ),
                                                  ],
                                                  color: Color.fromRGBO(
                                                      236, 240, 243, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        255,
                                                        255,
                                                        255,
                                                        1), // Set the border color
                                                    width: 2.5,
                                                  )),
                                              height: screenHeight * 0.07,
                                              width: screenWidth * 0.9,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(9.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:
                                                          screenHeight * 0.02,
                                                      width: screenWidth * 0.04,
                                                      child: Transform.scale(
                                                        scale: 1.1,
                                                        child: Radio(
                                                          value: index,
                                                          groupValue:
                                                              selectedIndex,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedIndex =
                                                                  value!;
                                                              alertType =
                                                                  type[index];
                                                              isalert = false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height:
                                                          screenHeight * 0.03,
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        type[index],
                                                        style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            blurRadius: 5, // Spread radius
                            offset: Offset(0, 3), // Offset in (x,y) coordinates
                          ),
                        ],
                        color: Color.fromRGBO(236, 240, 243, 1),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Color.fromRGBO(
                              255, 255, 255, 1), // Set the border color
                          width: 2.5,
                        )),
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
                              child:
                                  isalert ? Text('__') : Text('${alertType}')),
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
                                        return Colors.white;
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
                                        return Colors.white;
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
