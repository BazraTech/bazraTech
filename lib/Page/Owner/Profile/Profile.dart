import 'package:bazralogin/Page/Localization/Localization.dart';
import 'package:bazralogin/Page/Loging/forgotPin.dart';
import 'package:bazralogin/Page/Owner/Profile/profileEdit/languageOptions.dart';
import 'package:bazralogin/Page/Owner/Profile/profileEdit/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import '../../../const/constant.dart';
import 'package:ionicons/ionicons.dart';

import '../../Loging/changePassword.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          margin: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: screenWidth * 0.3,
                      margin: EdgeInsets.only(left: screenWidth * 0.38),
                      child: Text(
                        TranslationUtil.text("Profile"),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.13),
                    child: IconButton(
                      onPressed: () {},
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
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.png'),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Text("Alex"),
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
                height: screenHeight * 0.18,
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
                            width: 1.0,
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
                                child: Text(TranslationUtil.text("Email"))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: screenWidth * 0.55,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: screenWidth * 0.16),
                                  child: Row(
                                    children: [
                                      Text("abushj12@gmail.com"),
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
                          width: 1.0,
                        ),
                      )),
                      child: Row(
                        children: [
                          Container(
                              width: screenWidth * 0.2,
                              margin: EdgeInsets.only(left: 10),
                              child:
                                  Text(TranslationUtil.text("Date of Birth"))),
                          Container(
                              width: screenWidth * 0.55,
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.16),
                                child: Row(
                                  children: [
                                    Text("abushj12@gmail.com"),
                                    Icon(Ionicons.chevron_forward_outline)
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
                          width: 1.0,
                        ),
                      )),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              width: screenWidth * 0.2,
                              child: Text(TranslationUtil.text("Gender"))),
                          Container(
                              width: screenWidth * 0.55,
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.16),
                                child: Row(
                                  children: [
                                    Text("abushj12@gmail.com"),
                                    Icon(Ionicons.chevron_forward_outline)
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
                          Icon(Icons.language_sharp),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(TranslationUtil.text("Language"))),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.3),
                            child: IconButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            languageOption()));
                              }),
                              icon: Icon(Ionicons.chevron_forward_outline),
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
                          Icon(Icons.lock_outline),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(
                                    TranslationUtil.text('Change password'))),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.3),
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
                          Icon(Ionicons.help),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(TranslationUtil.text("Help"))),
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
                          Icon(Ionicons.settings),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth * 0.3,
                                child: Text(TranslationUtil.text("Setting"))),
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
