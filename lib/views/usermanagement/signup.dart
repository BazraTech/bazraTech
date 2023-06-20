import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cargo/shared/constant.dart';
import 'package:cargo/views/usermanagement/login.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../localization/app_localizations.dart';
import '../../shared/custom-form.dart';
import '../../shared/customButton.dart';
import '../../shared/failAlert.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import '../Bottom_Navigation.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

TextEditingController from = TextEditingController();

class _SignupState extends State<Signup> {
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed

    _phoneController.dispose();
    _passwordController.dispose();
    // _confirmPasswordController.dispose();

    super.dispose();
  }

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
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
  }

  registerCargo(
      String company, String phone, String pass, String confirmPass) async {
    const url = 'http://64.226.104.50:9090/Api/SignUp/Cargo';

    // Define your request data as a Map
    Map requestData = {
      'companyName': "${company}",
      'phone': "${phone}",
      'password': "${pass}",
      'confirmPassword': "${confirmPass}",
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
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      AppLocalizations.of(context)
                              ?.translate("Create An Account ") ??
                          "Create An Account",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        letterSpacing: 2.0,
                        wordSpacing: 1.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Roboto"),
                    hintText: AppLocalizations.of(context)
                            ?.translate("Company Name") ??
                        "Company Name",
                    textController: _companyController,
                    keyboardType: TextInputType.text,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                  
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate("Please enter your company name") ??
                            "Please enter your company name";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    hintText: AppLocalizations.of(context)
                            ?.translate("Phone Number") ??
                        "Phone Number",
                    textController: _phoneController,
                    obscureText: false,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter your phone number') ??
                            "Please enter your phone number ";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    hintText:
                        AppLocalizations.of(context)?.translate('Password') ??
                            "Password",
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
                                ?.translate('Please Enter Password') ??
                            "Please Enter Password";
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
                      textStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontFamily: 'Roboto',
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        print("password changed: $value");
                      },
                      obscureText: true,
                      hintTextStyle: TextStyle(
                        letterSpacing: 1.0,
                        wordSpacing: 2.0,
                        color: _isFocus ? Colors.red : Colors.grey,
                        // ... other styles
                      ),
                      showSuffixIcon: true,
                     
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Confirm Password";
                        }

                        return PasswordMatchValidator.validate(
                            _passwordController.text, value!);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await registerCargo(
                        _companyController.text,
                        _phoneController.text,
                        _passwordController.text,
                        _confirmPasswordController.text,
                      );
                    },
                    text: AppLocalizations.of(context)?.translate('Sign Up') ??
                        "Sign Up",
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 20),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Already have an account?") ??
                                  "Already have an account?",
                              style: const TextStyle(
                                fontSize: 15,
                                letterSpacing: 1,
                                color: Colors.black54,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const Cargo_login()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Login") ??
                                  "Login",
                              style: const TextStyle(
                                fontSize: 15,
                                color: kPrimaryColor,
                                letterSpacing: 1.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
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
