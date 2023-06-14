import 'dart:async';
import 'dart:convert';

import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/config/APIConfig.dart';
import 'package:cargo/localization/app_localizations.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/usermanagement/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/custom-form.dart';
import '../../shared/failAlert.dart';
import '../../shared/logo.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'changePassword.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  // Future<String> fetchImage() async {
  //   var client = http.Client();
  //   StorageHelper storageHelper = StorageHelper();
  //   String? accessToken = await storageHelper.getToken();

  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   final response = await http.get(
  //       Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
  //       headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the JSON.
  //     Map<String, dynamic> data = json.decode(response.body);
  //     return data["logo"];
  //   } else {
  //     throw Exception('Failed to load image');
  //   }
  // }

  bool _isFocus = false;
  void _showSweetAlert(BuildContext context, AlertType alertType, String title,
      String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChangePassword()),
            )
          },
          width: 120,
        ),
      ],
    ).show();
  }

  generatePin(String cargoOwnerPhone) async {
    const url = 'http://64.226.104.50:9090/Api/User/GeneratePIN';

    // Define your request data as a Map
    Map requestData = {
      'phoneNumber': "${cargoOwnerPhone}",
    };
    print(requestData);

    print(requestData);

    print("********************************");
    print('Token: $requestData');
    print("********************************");
    try {
      String body = json.encode(requestData);
      StorageHelper storageHelper = StorageHelper();
      String? accessToken = await storageHelper.getToken();
      // Make the request and handle the response
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        final response = await http.post(
          Uri.parse(url),
          body: body,
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
          },
        );
        print(response.body);
        print(response.statusCode);
        final Map jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          _showSweetAlert(
              context, AlertType.success, 'Success', jsonResponse['message']);
        } else {
          _showSweetAlert(
              context, AlertType.error, 'Error', jsonResponse['message']);
        }
      }
    } catch (e) {
      _showSweetAlert(context, AlertType.error, 'Error',
          'An error occurred, please check your internet connection.');
    }
  }

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
              // Container(
              //   margin: EdgeInsets.only(left: 20, bottom: 30),
              //   padding: const EdgeInsets.all(2.0),
              //   child: CircleAvatar(
              //     radius: 65,
              //     backgroundColor: Colors.white,
              //     child: FutureBuilder(
              //       future: fetchImage(),
              //       builder:
              //           (BuildContext context, AsyncSnapshot<String> snapshot) {
              //         if (snapshot.connectionState != ConnectionState.done)
              //           return Text("");
              //         return ClipOval(
              //           child: SizedBox(
              //               height: screenHeight * 0.4,
              //               width: screenWidth * 0.9,
              //               child: Image.network(snapshot.data.toString())),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              Center(
                child: Text(
                  AppLocalizations.of(context)?.translate("Forget Password") ??
                      "Forget Password",
                  style: const TextStyle(
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
                child: Text(
                  AppLocalizations.of(context)?.translate(
                          "Enter your phone number to get a verification code.") ??
                      "Enter your phone number to get a verification code.",
                  style: const TextStyle(
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
                hintText:
                    AppLocalizations.of(context)?.translate("Phone Number") ??
                        "Phone Number",
                hintTextStyle: TextStyle(
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  color: _isFocus ? Colors.red : Colors.blue,

                  // ... other styles
                ),
                textController: _phoneController,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                onFocusChange: (focus) {
                  setState(() {
                    _isFocus = focus;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.translate("Please enter your phone number") ??
                        "Please enter your phone number";
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
                  child: Text(
                    AppLocalizations.of(context)?.translate(
                            "You will receive a 5 digit verification code.") ??
                        "You will receive a 5 digit verification code.",
                    style: const TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.black54,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              CustomButton(
                onPressed: () async {
                  await generatePin(
                    _phoneController.text,
                  );
                },
                text:
                    AppLocalizations.of(context)?.translate('Reset') ?? "Reset",
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
