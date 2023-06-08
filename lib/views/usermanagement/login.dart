import 'dart:async';
import 'dart:convert';

import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/config/APIConfig.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:cargo/shared/logoStorage.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/usermanagement/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/ImageHelper.dart';
import '../../shared/checkConnection.dart';
import '../../shared/custom-form.dart';
import '../../shared/failAlert.dart';
import '../../shared/logo.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import 'forgetPassword.dart';

class Cargo_login extends StatefulWidget {
  const Cargo_login({super.key});

  @override
  State<Cargo_login> createState() => _Cargo_loginState();
}

class _Cargo_loginState extends State<Cargo_login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? ownerPic;
  bool _isFocused = false;
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed

    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  loginCargo(String phone, String pass) async {
    const url = 'http://64.226.104.50:9090/Api/SignIn/Cargo';
    StorageHelper storageHelper = StorageHelper();
    String? retrievedToken = await storageHelper.getToken();
    // Define your request data as a Map
    Map requestData = {
      'username': "${phone}",
      'password': "${pass}",
    };

    print(requestData);

    print("********************************");
    print('Token: $retrievedToken');
    print("********************************");
    bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      // Show an error message
      print(
          'No internet connection found, please check your internet settings.');
      // Define this function to show an alert
      return;
    }
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
          //Get the token from the response
          String? newToken = jsonResponse['jwt'];
          var name = jsonResponse['user']['name'];
          var phoneNumber = jsonResponse['user']['PhoneNumber'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', name);
          await prefs.setString('phoneNumber', phoneNumber);
          // Save the token to storage
          if (newToken != null) {
            await storageHelper.setToken(newToken);
          }
          print(newToken);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
          );
        } else {
          _showSweetAlert(context);
        }
      }
    } catch (error) {
      _showSweetAlert(context);
    }
  }

  void _showSweetAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      desc: "Invalid User Name Or Passowrd.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cargo_login())),
          width: 180,
        )
      ],
    ).show();
  }

  Future<String> fetchImage() async {
    var client = http.Client();
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      return data["logo"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 249),
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 60),
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: FutureBuilder(
                    future: fetchImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text("");
                      return ClipOval(
                        child: SizedBox(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.9,
                            child: Image.network(snapshot.data.toString())),
                      );
                    },
                  ),
                ),
              ),
              CustomTextFieldForm(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Roboto"),
                hintText: "Phone Number",
                textController: _phoneController,
                onFocusChange: (focused) {
                  setState(() {
                    _isFocused = focused;
                  });
                },
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  }
                },
                obscureText: false,
                hintTextStyle: TextStyle(
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  color: _isFocused ? Colors.green.shade700 : Colors.grey,
                  // ... other styles
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldForm(
                hintText: 'Password',
                textController: _passwordController,
                isPassword: true,
                textStyle: TextStyle(fontSize: 16),
                onChanged: (value) {
                  print("password changed: $value");
                },
                obscureText: true,
                showSuffixIcon: true,
                hintTextStyle: TextStyle(
                  letterSpacing: 1.0,
                  wordSpacing: 2.0,
                  color: _isFocused ? Colors.red : Colors.grey,
                  // ... other styles
                ),
                onFocusChange: (focus) {
                  setState(() {
                    _isFocused = focus;
                  });
                },
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
              Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Forget()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 25),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 15,
                          color: kPrimaryColor,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
              CustomButton(
                  onPressed: () async {
                    await loginCargo(
                        _phoneController.text, _passwordController.text);
                  },
                  text: "Sign In"),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 40, right: 10),
                        child: const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.5,
                            wordSpacing: 1.0,
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
                                    const Signup()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.5,
                            color: kPrimaryColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
