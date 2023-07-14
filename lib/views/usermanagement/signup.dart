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
import 'package:fluttertoast/fluttertoast.dart';

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
      style: AlertStyle(
        descStyle: TextStyle(fontSize: 14),
        isOverlayTapDismiss: false,
        overlayColor: Colors.black54,
        animationType: AnimationType.grow,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titleStyle: TextStyle(
          color: alertType == AlertType.error ? Colors.red : Colors.blue,
        ),
        alertAlignment: Alignment.center,
        alertElevation: 10,
      ),
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (alertType == AlertType.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Cargo_login()),
              );
            } else if (alertType == AlertType.error) {
              Navigator.pop(context);
            }
          },
          width: 200,
        ),
      ],
    ).show();
  }

  registerCargo(
    String company,
    String phone,
    String pass,
    String confirmPass,
  ) async {
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
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cargo_login()),
          );
        } else {
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      }
    } catch (e) {
      if (e is http.ClientException &&
          e.message.contains('Connection reset by peer')) {
        Fluttertoast.showToast(
          msg: "Connection reset by peer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        // Display an error message to the user or retry the operation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Connection reset by peer. Please try again.'),
              actions: [
                ElevatedButton(
                  child: Text('Retry'),
                  onPressed: () {
                    // Retry the operation
                    registerCargo(
                      company,
                      phone,
                      pass,
                      confirmPass,
                    );
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      Fluttertoast.showToast(
          msg: 'An error occurred, please check your internet connection.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  bool _isErrorVisible = false;
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                margin: EdgeInsets.only(top: 40, left: 10),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cargo_login()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.3),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Roboto",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: screenHeight - 30,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(top: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                              return AppLocalizations.of(context)?.translate(
                                      "Please enter your company name") ??
                                  "Please enter your company name";
                            }
                            return null;
                          },
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 30,
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
                              return AppLocalizations.of(context)?.translate(
                                      'Please enter your phone number') ??
                                  "Please enter your phone number ";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFieldForm(
                              hintText: AppLocalizations.of(context)
                                      ?.translate('Password') ??
                                  "Password",
                              textController: _passwordController,
                              isPassword: true,
                              hintTextStyle: TextStyle(
                                letterSpacing: 1.0,
                                wordSpacing: 2.0,
                                color:
                                    _isErrorVisible ? Colors.red : Colors.grey,
                                // ... other styles
                              ),
                              textStyle: TextStyle(fontSize: 16),
                              onChanged: (value) {
                                print("password changed: $value");
                                if (_isErrorVisible) {
                                  setState(() {
                                    _isErrorVisible = false;
                                  });
                                }
                              },
                              obscureText: true,
                              showSuffixIcon: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)
                                          ?.translate(
                                              'Please Enter Password') ??
                                      "Please Enter Password";
                                }

                                final passwordRegex =
                                    RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
                                if (!passwordRegex.hasMatch(value)) {
                                  setState(() {
                                    _isErrorVisible = true;
                                  });
                                  return " ";
                                }

                                return PasswordMatchValidator.validate(
                                    value, _confirmPasswordController.text);
                              },
                            ),
                            if (_isErrorVisible) // Only show the error message if it's visible
                              Text(
                                "Password must contain at least one capital letter, one number, and be at least 8 characters long",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
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
                          height: 30,
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
                          text: AppLocalizations.of(context)
                                  ?.translate('Sign Up') ??
                              "Sign Up",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 40, right: 20),
                                  child: Text(
                                    AppLocalizations.of(context)?.translate(
                                            "Already have an account?") ??
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
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Cargo_login()),
                                      (route) => false,
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
              ),
            ],
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
