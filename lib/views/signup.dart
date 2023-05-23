import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cargo/shared/constant.dart';
import 'package:cargo/views/login.dart';
import 'package:flutter/material.dart';
import '../shared/custom-form.dart';
import '../shared/customButton.dart';
import '../shared/failAlert.dart';
import '../shared/succussAlert.dart';
import 'Bottom_Navigation.dart';

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
    _companyController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
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

        if (response.statusCode == 200) {
          // Parse the response
          var jsonResponse = json.decode(response.body);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
          );
        } else {
          showAlertDialogFail(context);
        }
      }
    } catch (error) {
      showAlertDialogFail(context);
    }
  }

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
                    child: const Text(
                      "Create An Account ",
                      style: TextStyle(
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
                    hintText: "Company Name",
                    textController: _companyController,
                    keyboardType: TextInputType.text,
                    hintTextStyle: const TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number";
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
                    hintText: "Phone",
                    textController: _phoneController,
                    obscureText: false,
                    hintTextStyle: const TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    hintText: 'Password',
                    textController: _passwordController,
                    isPassword: true,
                    hintTextStyle: const TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
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
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    hintText: 'Confirm Password',
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
                    hintTextStyle: const TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      // ... other styles
                    ),
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await registerCargo(
                          _companyController.text,
                          _phoneController.text,
                          _passwordController.text,
                          _confirmPasswordController.text);
                    },
                    text: 'Sign up',
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 20),
                            child: const Text(
                              "Already have an account?",
                              style: TextStyle(
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
                            child: const Text(
                              "Log In",
                              style: TextStyle(
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
