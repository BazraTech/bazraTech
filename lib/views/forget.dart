import 'dart:async';
import 'dart:convert';

import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/config/APIConfig.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/custom-form.dart';
import '../shared/failAlert.dart';
import '../shared/logo.dart';
import '../shared/storage_hepler.dart';
import '../shared/succussAlert.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 30),
                padding: const EdgeInsets.all(2.0),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: kPrimaryColor,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 45),
                child: const Text(
                  "Enter your phone number to get a verification code.",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextFieldForm(
                textStyle: const TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Roboto"),
                hintText: "Phone Number",
                hintTextStyle: const TextStyle(
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  // ... other styles
                ),
                textController: _phoneController,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  }
                },
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "You will receive a 5 digit verification code.",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.black54,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BottomNav()),
                      );
                    }
                  },
                  text: "Continue"),
            ]),
          ),
        ),
      ),
    );
  }
}
