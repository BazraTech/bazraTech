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
  bool isLoading = false;
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
      setState(() {
        isLoading = true;
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
      appBar: AppBar(
        title: Text(
          "Change password",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: kBackgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
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
                            onPressed: isLoading ? null : ChangePasswords,
                            child: Container(
                              height: 55,
                              width: screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isLoading
                                      ? SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : SizedBox(), // Empty SizedBox if not loading
                                  SizedBox(width: 8),
                                  Text(
                                    isLoading ? 'Please Wait' : 'Save',
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromRGBO(255, 148, 165, 223);
                                  }
                                  // 98, 172, 181
                                  return Colors.lightBlue;
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6))))),
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
