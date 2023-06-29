import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../localization/localization_bloc.dart';
import '../../localization/localization_event.dart';
import '../../shared/constant.dart';
import '../../shared/storage_hepler.dart';
import 'ProfileEdit.dart';
import 'changePassword.dart';
import 'languages.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<String> fetchImage() async {
    var client = http.Client();
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      return data["logo"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  Widget buildLanguageDropdown(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final localeBloc = context.read<LocaleBloc>();
    bool isPressed = true;
    return Container(
      width: screenWidth * 0.09,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular((6))),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 25,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: DropdownButton<Locale>(
        value: localeBloc.state.locale,
        underline: Container(),
        iconSize: 30,
        items: <Locale>[
          Locale('en', ''),
          Locale('am', ''),
        ].map<DropdownMenuItem<Locale>>((Locale value) {
          return DropdownMenuItem<Locale>(
            value: value,
            child: Text(value.languageCode),
          );
        }).toList(),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            localeBloc.add(ChangeLocale(newLocale));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEdit()),
                        );
                      },
                      icon: Icon(
                        Icons.edit_document,
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
                          future: fetchImage(),
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
                height: screenHeight * 0.26,
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
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
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
                                        width: screenWidth * 0.05,
                                      ),
                                      Icon(Icons.keyboard_arrow_right)
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
                                "Date of Birth",
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
                                        child: Icon(Icons.keyboard_arrow_right))
                                  ],
                                ),
                              )),
                        ],
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
                          width: 0.2,
                        ),
                      )),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.03,
                              child: Text(
                                "Gender",
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
                                        child: Icon(Icons.keyboard_arrow_right))
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageListItem()),
                  );
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical:
                          screenHeight * 0.035, // Increase the vertical padding
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(252, 221, 244, 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(Icons.language_sharp),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Text(
                              'Language',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
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
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()),
                        );
                      },
                      child: Padding(
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
                                    'Change password',
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.23),
                                child: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.keyboard_arrow_right))),
                          ],
                        ),
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
                              child: Icon(Icons.help)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                  "Help",
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
                              child: Icon(Icons.keyboard_arrow_right)),
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
                              child: Icon(Icons.settings)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                  "Setting",
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
                              child: Icon(Icons.keyboard_arrow_right)),
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
