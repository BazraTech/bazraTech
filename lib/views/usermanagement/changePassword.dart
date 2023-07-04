import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cargo/shared/constant.dart';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../localization/app_localizations.dart';
import '../../shared/custom-form.dart';
import '../../shared/customButton.dart';
import 'Profile.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

TextEditingController from = TextEditingController();

class _ChangePasswordState extends State<ChangePassword> {
  final _username = TextEditingController();
  final _pin = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  builder: (BuildContext context) => Cargo_login()),
            )
          },
          width: 120,
        ),
      ],
    ).show();
  }

  registerCargo(
      String newPass, String confirmPass, String userName, String pin) async {
    const url = 'http://64.226.104.50:9090/Api/User/SetPin';

    // Define your request data as a Map
    Map requestData = {
      'newpassword': "${newPass}",
      'confirmPassword': "${confirmPass}",
      'username': "${userName}",
      'pin': "${pin}",
    };
    print(requestData);

    print(requestData);

    print("********************************");
    print('Token: $requestData');
    print("********************************");
    try {
      String body = json.encode(requestData);

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

  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth * 0.12),
            height: 40,
            child: Center(
              child: Text(
                AppLocalizations.of(context)
                        ?.translate("Password change page") ??
                    "Password change page",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 45),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 60,
                      child: Icon(Icons.lock, color: Colors.white, size: 70),
                    ),
                  ),
                  CustomTextFieldForm(
                    hintText: AppLocalizations.of(context)
                            ?.translate('Current Password') ??
                        "Current Password",
                    textController: _passwordController,
                    isPassword: true,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    textStyle: TextStyle(fontSize: 16),
                    onChanged: (value) {
                      print("password changed: $value");
                    },
                    obscureText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter Current password') ??
                            "Please enter Current password";
                      }
                      return PasswordMatchValidator.validate(
                          value!, _confirmPasswordController.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    hintText: AppLocalizations.of(context)
                            ?.translate('New Password') ??
                        "New Password",
                    textController: _passwordController,
                    isPassword: true,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    textStyle: TextStyle(fontSize: 16),
                    onChanged: (value) {
                      print("password changed: $value");
                    },
                    obscureText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter new password') ??
                            "Please enter new password";
                      }
                      return PasswordMatchValidator.validate(
                          value!, _confirmPasswordController.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    hintText: AppLocalizations.of(context)
                            ?.translate('Confirm Password') ??
                        "Confirm Password",
                    textController: _confirmPasswordController,
                    isPassword: true,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    textStyle: TextStyle(fontSize: 16),
                    onChanged: (value) {
                      print("password changed: $value");
                    },
                    obscureText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please Confirm Password') ??
                            "Please Confirm Password";
                      }
                      return PasswordMatchValidator.validate(
                          value!, _passwordController.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await registerCargo(
                        _passwordController.text,
                        _confirmPasswordController.text,
                        _username.text,
                        _pin.text,
                      );
                    },
                    text: AppLocalizations.of(context)
                            ?.translate('Change Password') ??
                        "Change Password",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class PasswordMatchValidator {
  static String? validate(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "password do not match";
    }
    return null;
  }
}
