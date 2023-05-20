import 'dart:convert';

import 'package:bazralogin/Route/Routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Theme/TextInput.dart';
import '../Bottom/Bottom.dart';

class forgotPin extends StatefulWidget {
  String? phone;
  forgotPin({super.key, this.phone});

  @override
  State<forgotPin> createState() => _forgotPinState();
}

class _forgotPinState extends State<forgotPin> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();
  TextEditingController resetpin = TextEditingController();
  ChangePasswords() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "newpassword": "${newpass.text}",
        "confirmPassword": "${Confirmpass.text}",
        "username": "${widget.phone}",
        "pin": "${resetpin.text}"
      };
      var response = await http.post(
          Uri.parse('http://64.226.104.50:9090/Api/User/SetPin'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        Get.offAllNamed("/home");
      } else {
        print('noooo');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("${currentPassword.text}");

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: kBackgroundColor,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.1, left: screenHeight * 0.00),
                child: Row(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(bottom: screenHeight * 0.2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.14),
                        child: Text(
                          "Change password",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: screenHeight * 0.09,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Icon(
                            Ionicons.chatbox,
                            color: Color.fromRGBO(255, 194, 14, 1),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                            "OTP is alread send  to your phone\n ${widget.phone}"),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.09),
                  child: Row(
                    children: [
                      Text(
                        " New Pin",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: resetpin,
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        " New Password",
                        style: TextStyle(fontFamily: "Nunito", fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: newpass,
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Row(
                    children: [
                      Text(
                        " Confirm  Password",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: Confirmpass,
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width - 30,
                        child: ElevatedButton(
                          onPressed: () {
                            ChangePasswords();
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ThemeHelper().buttonStyle(),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
