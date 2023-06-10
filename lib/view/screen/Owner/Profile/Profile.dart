import 'dart:convert';

import 'package:bazralogin/Route/Routes.dart';
import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/view/screen/Loging/forgotPin.dart';
import 'package:bazralogin/view/screen/Owner/Profile/profileEdit/languageOptions.dart';
import 'package:bazralogin/view/screen/Owner/Profile/profileEdit/updateOwnerprofile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../Loging/changePassword.dart';
import '../../../../const/constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ownerpic = "";
  Future<String> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "ownerpic", value: data["avatar"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["avatar"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TranslationController controller = Get.put(TranslationController());
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 28),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ownerprofileUpadate(
                                      image: "${ownerpic}",
                                      email: "abushj12@gmail.com",
                                      phone: "0978999967",
                                      datebirth: "12/4/000",
                                      name: "Alex",
                                      gender: "Male",
                                    )));
                      },
                      icon: Icon(
                        Ionicons.pencil,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: FutureBuilder(
                          future: _fetchLogo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text("");
                            return Container(
                              height: screenHeight * 0.09,
                              width: screenWidth * 0.18,
                              child: ClipOval(
                                child: Container(
                                  child: SizedBox(
                                      height: screenHeight * 0.06,
                                      width: screenWidth * 0.05,
                                      child: Image.network(
                                          snapshot.data.toString())),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Alex"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.28,
                width: screenWidth,
                child: Column(children: [
                  SizedBox(
                    // height: screenHeight * 0.06,
                    // width: screenWidth * 0.85,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.2,
                          ),
                        )),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                width: screenWidth * 0.2,
                                child: Text(
                                  TranslationUtil.text("Email"),
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: screenWidth * 0.60,
                                height: screenHeight * 0.06,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: screenWidth * 0.12),
                                  child: Row(
                                    children: [
                                      Text(
                                        "abushj12@gmail.com",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.07,
                                      ),
                                      Icon(Ionicons.chevron_forward_outline)
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      )),
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth * 0.25,
                              height: screenHeight * 0.06,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                TranslationUtil.text("Date of Birth"),
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(
                              width: screenWidth * 0.54,
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.1),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenWidth * 0.07),
                                      child: Text(
                                        "2022-12-2",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: screenWidth * 0.12),
                                        child: Icon(
                                            Ionicons.chevron_forward_outline))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                      )),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              child: Text(
                                TranslationUtil.text(
                                  "Gender",
                                ),
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(
                              width: screenWidth * 0.6,
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: screenWidth * 0.21),
                                        child: Center(
                                            child: Text(
                                          "Male",
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: screenWidth * 0.22),
                                        child: Icon(
                                            Ionicons.chevron_forward_outline))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(252, 221, 244, 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(Icons.language_sharp)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                  TranslationUtil.text("Language"),
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: screenWidth * 0.26),
                            child: IconButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            languageOption()));
                              }),
                              icon: Container(
                                  child:
                                      Icon(Ionicons.chevron_forward_outline)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.3,
                width: screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(201, 252, 248, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.lock_outline)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.36,
                                child: Text(
                                  TranslationUtil.text('Change password'),
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.23),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangePassword()),
                                    );
                                  },
                                  child:
                                      Icon(Ionicons.chevron_forward_outline))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 245, 210, 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(Ionicons.help)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                  TranslationUtil.text("Help"),
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.3),
                              child: Icon(Ionicons.chevron_forward_outline)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(201, 252, 248, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Ionicons.settings)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                  TranslationUtil.text("Setting"),
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.3),
                              child: Icon(Ionicons.chevron_forward_outline)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
