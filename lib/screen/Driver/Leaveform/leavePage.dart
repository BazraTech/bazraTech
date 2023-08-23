import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;

class leavepremmissionPage extends StatefulWidget {
  leavepremmissionPage({required this.title});
  final String title;
  @override
  _leavepremmissionPageState createState() => _leavepremmissionPageState();
}

class _leavepremmissionPageState extends State {
  List findVehicle = [];
  String? selectedType;
  List<String> type = [
    "Vaction",
    "Quitting",
    "Sick",
    "Other",
  ];
  TextEditingController _endDate = TextEditingController();
  TextEditingController _startDate = TextEditingController();

  Future<void> endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _endDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> leaveRequest(String? selectedValue) async {
    final url = Uri.parse(
        'http://164.90.174.113:9090/Api/Driver/Request/Permit'); // Replace with your API endpoint
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map<String, dynamic> data = {
      "startDate": _startDate.text,
      "endDate": _endDate.text,
      'reason': selectedValue,
    };
    // Print each data from the user
    data.forEach((key, value) {
      print('$key: $value');
    });
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $value",
      },
      body: jsonEncode(data),
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 400) {
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      Fluttertoast.showToast(
        msg: responseBody['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else if (response.statusCode == 200) {
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      Fluttertoast.showToast(
        msg: responseBody['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: responseBody['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
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
          child: const Text(
            "Leave Request For ",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
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
              height: screenHeight * 0.35,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                      width: screenWidth * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text("Start Date")),
                            TextFormField(
                              controller: _startDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Select start date",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => startDate(context),
                                ),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text("End Date")),
                            TextFormField(
                              controller: _endDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Select end date",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => endDate(context),
                                ),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Color.fromRGBO(255, 148, 165, 223);
                                    }
                                    // 98, 172, 181
                                    return Color.fromRGBO(226, 193, 121, 1);
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                              onPressed: () {
                                leaveRequest(selectedType);
                              },
                              child: Text('Submit'),
                            )),
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
