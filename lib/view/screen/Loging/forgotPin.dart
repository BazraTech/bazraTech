import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Bottom/Bottom.dart';
import '../../../Theme/TextInput.dart';

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
          Uri.parse('http://198.199.67.201:9090/Api/User/SetPassword'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
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
      bottomSheet: ConfirmPassword(),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: kBackgroundColor,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.1, left: screenHeight * 0.01),
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
                          style: TextStyle(fontSize: 23),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.09),
                  child: Row(
                    children: [Text(" New Pin")],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: resetpin,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [Text(" New Password")],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: newpass,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Row(
                    children: [Text(" Confirm  Password")],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: Confirmpass,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ConfirmPassword() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width - 30,
              child: ElevatedButton(
                onPressed: () {
                  ChangePasswords();
                },
                child: const Text(
                  "Confrim",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                style: ThemeHelper().buttonStyle(),
              ),
            ),
          ],
        ));
  }
}
