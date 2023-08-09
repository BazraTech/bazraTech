import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../config/APIService.dart';
import '../../../const/constant.dart';

class leavepremmissionPage extends StatefulWidget {
  leavepremmissionPage({required this.title});
  final String title;
  @override
  _leavepremmissionPageState createState() => _leavepremmissionPageState();
}

class _leavepremmissionPageState extends State {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController locations = TextEditingController();
  //List _toDoListAlert = [];
  final _formKey = GlobalKey<FormState>();
  List<String> _toDoListLocation = [];
  List<String> _toDoListAlert = [];
  int? Resultsm;
  bool isalert = true;
  bool _value = true;
  String? alertType;
  String? Results;
  List findVehicle = [];
  String? selectedType;
  List<bool> _checkedItems = [false, false, false, false, false];
  List<String> type = [
    "Vaction",
    "Quitting",
    "Sick",
    "Other",
  ];
  List<String> day = ["hours", "Days", "Hours"];
  List<String> date = [
    "Start date",
    "End date",
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
    }
  }

  _deleteToDoItem(int index) {
    setState(() {
      _toDoListLocation.removeAt(index);
    });
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

      alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
    } else {
      String alertContent = jsonResponse["message"];
      alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
    }
  }

  driverFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.getalert);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final Result = data['activeAlerts'];
        setState(() {
          final Result = data["activeAlerts"];
          int Resultsm = data["activeAlerts"][0]['id'];
          print(Resultsm);
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
  }

// finish alert
  void finishAlert() async {
    driverFetch();
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map data = {
      "alertType": alertType,
      "location": "ADDIS ABABA",
    };
    final url =
        Uri.parse("http://64.226.104.50:9090/Api/Driver/FinishAlert/96");
    http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    }).then((response) {
      String alertContent = "Alert finished";

      alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
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
    driverFetch();
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
        elevation: 1,
        leading: Container(
          margin: EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(178, 142, 22, 1),
        title: Container(
          margin: EdgeInsets.only(left: screenWidth * 0.15),
          child: Text(
            "Leave page ",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: AppFonts.mediumFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: screenHeight * 0.12,
                width: screenWidth * 0.9,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Container(
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromRGBO(
                                  255, 255, 255, 1), // Set the border color
                              width: 2.5,
                            )),
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Leave Request For",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: AppFonts.smallFontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                height: screenHeight * 0.12,
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Color.fromRGBO(236, 240, 243, 1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            width: 2.5,
                          ),
                        ),
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight * 0.02,
                                width: screenWidth * 0.04,
                                child: Transform.scale(
                                  scale: 1.1,
                                  child: Radio(
                                    value:
                                        0, // Assign a different value for the first radio button
                                    groupValue: selectedIndex,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIndex = value!;
                                        alertType = day[1];
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
                                height: screenHeight * 0.03,
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Hour",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: AppFonts.smallFontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.3,
                              ),
                              Container(
                                height: screenHeight * 0.02,
                                width: screenWidth * 0.04,
                                child: Transform.scale(
                                  scale: 1.1,
                                  child: Radio(
                                    value:
                                        1, // Assign a different value for the second radio button
                                    groupValue: selectedIndex,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIndex = value!;
                                        alertType = day[1];
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
                                height: screenHeight * 0.03,
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Day",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: AppFonts.smallFontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              height: screenHeight * 0.2,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: type.length - 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.3), // Shadow color
                                  blurRadius: 5, // Spread radius
                                  offset: Offset(
                                      0, 3), // Offset in (x,y) coordinates
                                ),
                              ],
                              color: Color.fromRGBO(236, 240, 243, 1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromRGBO(
                                    255, 255, 255, 1), // Set the border color
                                width: 2.5,
                              )),
                          height: screenHeight * 0.09,
                          width: screenWidth * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.02,
                                      width: screenWidth * 0.2,
                                      child: Text(date[index]),
                                    ),
                                    Text("2011/3/3")
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: screenHeight * 0.03,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Icon(
                                      Ionicons.calendar,
                                      color: Color.fromRGBO(178, 142, 22, 1),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
              padding: const EdgeInsets.all(9),
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      blurRadius: 5, // Spread radius
                      offset: Offset(0, 3), // Offset in (x,y) coordinates
                    ),
                  ],
                  color: Color.fromRGBO(236, 240, 243, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(
                        255, 255, 255, 1), // Set the border color
                    width: 2.5,
                  )),
              child: ListView.builder(
                itemCount: type.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    title: Text(type[index]),
                    value: type[index],
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      color: Color.fromRGBO(236, 240, 243, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(
                            255, 255, 255, 1), // Set the border color
                        width: 2.5,
                      )),
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "Leave Request",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
