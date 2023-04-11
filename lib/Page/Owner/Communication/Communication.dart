import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/Model/Vehicle.dart';
import 'package:bazralogin/Model/communication.dart';
import 'package:bazralogin/Page/Localization/Localization.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Bottom/Bottom.dart';
import '../../../Model/communicationList.dart';
import '../../../config/APIService.dart';
import '../../../config/ApiConfig.dart';
import '../Driver/assignDriver.dart';

class CommunicationPage extends StatefulWidget {
  CommunicationPage({
    super.key,
  });
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

late var timer;

class _CommunicationPageState extends State<CommunicationPage> {
  TextEditingController _searchController = TextEditingController();

  List<Communicationlist> find = [];

  List Result = [];
  String query = '';
  List listDriver = [];

  List drivers = [];
  bool ischeckValue = false;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('Success!!!')),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Center(child: Text('Message sent successfully ')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  Future vehicleFetch() async {
    final Result = await APIService.driverFetch();
    if (mounted) {
      timer = Timer.periodic(
          Duration(seconds: 5),
          (Timer t) => setState(() {
                this.Result = Result;
              }));
    }
  }

  void initState() {
    super.initState();

    timer = Duration(seconds: 3);
    vehicleFetch();
  }

  var len;

  @override
  void dispose() {
    timer.cancel();
    timer;
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  sendMessage() async {
    var value = await storage.read(key: 'jwt');
    Map data = {"message": _controller.text, "receipientPhone": listDriver};
    var response = await http.post(
        Uri.parse('http://198.199.67.201:9090/Api/Message/CreateMessage'),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      _showMyDialog();
    } else {
      throw Exception('Failed ');
    }
  }

  OnclickedAll() {
    bool newmessage = false;
    bool newvalue = false;

    setState(() {
      newvalue = false;
      listDriver.clear();
      Result.forEach((element) {
        element['statMessage'] = !newvalue;
        listDriver.add(element['phoneNumber']);
      });
      newvalue = true;
    });
  }

  // void driversSearch(String enterKeyboard) {
  //   setState(() {
  //     this.profiles = find;
  //   });
  //   if (enterKeyboard.isEmpty) {
  //     find = profiles;
  //   } else {
  //     final find = profiles.where((driver) {
  //       final name = driver.name.toLowerCase();

  //       final inputName = enterKeyboard.toLowerCase();
  //       final inputLicense = enterKeyboard.toLowerCase();
  //       return name.contains(inputName);
  //     }).toList();
  //     setState(() {
  //       this.profiles = find;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(listDriver);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 100),
        height: screenHeight,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 30, right: 60, top: 35, bottom: 10),
                    child: Text(TranslationUtil.text('Message'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: kPrimaryColor,
                        )),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 0),
                    height: screenHeight * 0.2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: screenHeight * 0.125,
                                  width: screenWidth - 40,
                                  child: TextFormField(
                                    minLines: 5,
                                    maxLines: 6,
                                    controller: _controller,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: " write message",
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Colors.black!, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              height: 35,
                              width: screenWidth * 0.294,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7.0),
                                child: ElevatedButton(
                                  onPressed: (() {
                                    sendMessage();
                                  }),
                                  child: const Text(
                                    "send",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return ColorsConsts.backgroundColor;
                                        }
                                        return Colors.lightBlue;
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                      height: 65,
                      width: screenWidth * 0.5,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(4, 4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Container(
                        height: screenHeight * 0.01,
                        width: screenWidth,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: 'Search driver',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.black!, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]),
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.18),
                      child: ElevatedButton(
                        onPressed: (() {
                          OnclickedAll();
                        }),
                        child: Text(
                          'Select all',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return ColorsConsts.backgroundColor;
                              }
                              return Colors.lightBlue;
                            }),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    // side: const BorderSide(
                                    //     color:
                                    //         Color.fromRGBO(162, 184, 212, 1)),
                                    borderRadius: BorderRadius.circular(6)))),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth - 20,
                  child: ListView.builder(
                    itemCount: Result.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // color: Color.fromRGBO(162, 184, 212, 1),
                        child: Card(
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 20,
                                            width: screenWidth * 0.3,
                                            child: Text(
                                              " " +
                                                  Result[index]['driverName']
                                                      .toString(),
                                              style: const TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 20,
                                            width: screenWidth * 0.27,
                                            child: Text(
                                              " " +
                                                  Result[index]['phoneNumber']
                                                      .toString(),
                                              style: const TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 8),
                                          child: SizedBox(
                                            width: screenWidth * 0.2,
                                            height: 10,
                                            child: Transform.scale(
                                              scale: 0.9,
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  child: Checkbox(
                                                      activeColor: Colors.green,
                                                      value: Result[index]
                                                          ['statMessage'],
                                                      onChanged: (value) {
                                                        var item = Result[index]
                                                            ['phoneNumber'];
                                                        setState(() {
                                                          Result[index][
                                                                  'statMessage'] =
                                                              value!;
                                                          if (value == true) {
                                                            listDriver
                                                                .add(item);
                                                          } else if (value ==
                                                              false) {
                                                            listDriver.removeWhere(
                                                                (item) =>
                                                                    item ==
                                                                    Result[index]
                                                                        [
                                                                        'phoneNumber']);
                                                          }
                                                        });
                                                      })),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
