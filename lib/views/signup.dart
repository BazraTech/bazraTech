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
    String body = json.encode(requestData);

    try {
      // Make the request and handle the response

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
        showAlertDialogSuccuss(context);
      } else {
        showAlertDialogFail(context);
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
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    "Create An Account ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Phone",
                  textController: _phoneController,
                  obscureText: false,
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
                  hintText: "Password",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  textController: _passwordController,
                  obscureText: false,
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
                  hintText: "Confirm Password",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  textController: _confirmPasswordController,
                  obscureText: false,
                  onChanged: (value) {},
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
                    // Perform your API request

                    await registerCargo(
                        _companyController.text,
                        _phoneController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);
                  },
                  text: 'Signup',
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const Cargo_login()),
                      );
                    },
                    child: Row(
                      children: [
                        const Text(
                          "Already Have An Account ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
