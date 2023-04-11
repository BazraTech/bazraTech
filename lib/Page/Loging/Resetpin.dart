import 'dart:convert';

import 'package:bazralogin/Page/Loging/forgotPin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../Theme/TextInput.dart';

class ResetPin extends StatefulWidget {
  const ResetPin({super.key});

  @override
  State<ResetPin> createState() => _ResetPinState();
}

class _ResetPinState extends State<ResetPin> {
  TextEditingController ResetPassword = TextEditingController();
  ResetPasswords() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "phoneNumber": "0927272727",
      };
      var response = await http.post(
          Uri.parse('http://198.199.67.201:9090/Api/User/GeneratePIN'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          });

      if (response.statusCode == 200) {
        print('yaes');
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.12),
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
                      margin: EdgeInsets.only(
                          right: 30, bottom: screenHeight * 0.1),
                      child: Text(
                        "Forgot pin",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                            height: screenHeight * 0.09,
                            width: screenWidth * 0.07,
                            margin: EdgeInsets.only(left: 10),
                            child: Image(
                                image:
                                    AssetImage('assets/images/9195102.png'))),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "We just sent a code to ",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '0927272727',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "\nEnter the code here and we can continue!",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,

                    child: SizedBox(
                      height: screenHeight * 0.08,
                      child: Image.asset('assets/images/reset-password.png'),
                    ),
                    padding: EdgeInsets.all(17),
                    minWidth: screenWidth * 0.007,
                    //use this class Circleborder() for circle shape.
                    shape: const CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth - 20,
                    padding: EdgeInsets.only(left: screenWidth * 0.08),
                    height: screenHeight * 0.08,
                    child: PinCodeTextField(
                      maxLength: 6,
                      pinBoxWidth: 50,
                      pinBoxHeight: 40,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Didn't receive the code? ",
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        child: Text(
                          "Resend",
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth - 30,
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgotPin()));
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ThemeHelper().buttonStyle(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
