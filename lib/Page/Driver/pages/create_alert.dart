import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/constant.dart';

class CreateAlert extends StatefulWidget {
  CreateAlert({this.title});

  String? title;

  @override
  _CreateAlertState createState() => _CreateAlertState();
}

class _CreateAlertState extends State {
  TextEditingController _textEditingController = TextEditingController();
  //List _toDoListAlert = [];
  final _formKey = GlobalKey<FormState>();
  List<String> _toDoListLocation = [];
  List<String> _toDoListAlert = [];
  static bool isPressed = true;
  String? alertType;
  List<String> type = [
    "OFFROAD",
    "CAR CRASH",
    "ROAD ACCIDENT",
    "CAR TIRE FAILURE"
  ];

  get kBackgroundColor => null;
  @override
  void initState() {
    super.initState();
    _loadToDoList();
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

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Create Alert Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Container(
              margin: EdgeInsets.only(
                bottom: 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: const Text(
                      "Select Alert Type",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: Offset(2, 2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-2, -2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.06,
                              child: DropdownButton<String>(
                                hint: const Text(
                                  'Select a alert type ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: alertType,
                                iconSize: 24,
                                elevation: 10,
                                onChanged: (String? newValue) {
                                  validator:
                                  validator:
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter phone number';
                                    } else {
                                      return null;
                                    }
                                  };
                                  setState(() {
                                    alertType = newValue!;
                                  });
                                },
                                items: type.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      )),
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
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color.fromRGBO(255, 148, 165, 223);
                            }
                            // 98, 172, 181
                            return Colors.lightBlue;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)))),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.725,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: const Center(
                          child: Text(
                            " ADD ALERT",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _toDoListLocation.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.525,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    tileColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: Text(_toDoListLocation[index])),
                      ],
                    ),
                    trailing: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteToDoItem(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
