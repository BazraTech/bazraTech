import 'dart:convert';

import 'package:bazralogin/Theme/customAppBar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../config/APIService.dart';
import '../../../../const/constant.dart';
import 'updateDriverinfo.dart';

class drivermakeActive extends StatefulWidget {
  final String conditionName;
  final String driver;
  final int id;
  drivermakeActive(
      {super.key,
      required this.conditionName,
      required this.id,
      required this.driver});

  @override
  State<drivermakeActive> createState() => _drivermakeActiveState();
}

class _drivermakeActiveState extends State<drivermakeActive> {
  bool selected = false;
  setSelected() {
    setState(() {
      selected = !selected;
    });
  }

  Map<String, dynamic>? results;
  static final storage = const FlutterSecureStorage();
  _getdriverbyid() async {
    var value = await storage.read(key: 'jwt');
    var client = http.Client();
    try {
      var response = await http.get(
          Uri.parse('http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/All' +
              '/${widget.id}'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        print(widget.id);
        setState(() {
          results = result;
        });
        return results;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void initState() {
    super.initState();
    _getdriverbyid();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var newCondition = '${widget.conditionName}';
    print(newCondition);
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: CustomAppBar(
        backgroundColor: kBackgroundColor,
            height:screenHeight*0.07,
            toolbarHeight: 70,
          leading:IconButton(icon:Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ) , onPressed: () {  Navigator.pop(context); },),
          child: const Center(
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Driver Name or Plate No.',
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.clear)),
        ),
      ),),
      backgroundColor: kBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: results == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 30, left: 220, right: 2, bottom: 20),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.045,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => updateDriverinfo(
                                        fullname: '${widget.driver}',
                                        phone: 0973965944,
                                        expirence: 6,
                                        licencegrade: 007474,
                                        issuedate: '6/22/199',
                                        expiredate: '20/2/2029',
                                        birth: '20/07/1997',
                                      )));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromRGBO(
                                    255, 148, 165, 223);
                              }
                              // 98, 172, 181
                              return Colors.lightBlue;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(6)))),
                        child: const Center(
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            child: ListTile(
                              title: const Text(
                                "Full Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                results!['driverName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: const Icon(
                                Icons.person_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                "Gender",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                "Male",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.info_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            child: ListTile(
                              title: Text(
                                "Date Of Birth",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                "12/07/1997",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.calendar_month,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            child: ListTile(
                              title: Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                "0973965944",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.phone_iphone,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            child: ListTile(
                              title: Text("Experience",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                              trailing: Text(
                                "6",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.info_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text("License Grade",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                              trailing: Text(
                                results!['licenseNumber'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: const Icon(
                                Icons.info_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            child: ListTile(
                              title: Text("Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                              trailing: Text(
                                "Permit",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.info_rounded,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                "Issue Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                "07/12/2022",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.calendar_month,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          const Card(
                            child: ListTile(
                              title: Text(
                                "Expire Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              trailing: Text(
                                "One",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              leading: Icon(
                                Icons.calendar_month,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              newCondition == 'alex'
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 30,
                                          left: 20,
                                          right: 20,
                                          bottom: 50),
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.85,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.05,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new updateDriverinfo()));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return const Color.fromRGBO(
                                                    255, 148, 165, 223);
                                              }
                                              // 98, 172, 181
                                              return Colors.lightBlue;
                                            }),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(6)))),
                                        child: const Center(
                                          child: Text(
                                            "Permit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(
                                          top: 30,
                                          left: 20,
                                          right: 20,
                                          bottom: 50),
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.85,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.05,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new updateDriverinfo()));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return const Color.fromRGBO(
                                                    255, 148, 165, 223);
                                              }
                                              // 98, 172, 181
                                              return Colors.lightBlue;
                                            }),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(6)))),
                                        child: const Center(
                                          child: Text(
                                            "DisCharge",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
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
  }
}
