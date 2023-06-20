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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/app_localizations.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_event.dart';
import '../../navigate/navigateBloc.dart';
import '../../navigate/navigatestateEvent.dart';
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
          context.read<NavigationBloc>().add(NavigateTo('/bottomNav'));
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

  Widget buildLanguageDropdown(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final localeBloc = context.read<LocaleBloc>();
    bool isPressed = true;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.07,
      width: screenWidth * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular((6))),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 25,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: DropdownButton<Locale>(
        value: localeBloc.state.locale,
        underline: Container(),
        iconSize: 30,
        items: <Locale>[
          Locale('en', ''),
          Locale('am', ''),
        ].map<DropdownMenuItem<Locale>>((Locale value) {
          return DropdownMenuItem<Locale>(
            value: value,
            child: Text(value.languageCode),
          );
        }).toList(),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            localeBloc.add(ChangeLocale(newLocale));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 249),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: screenWidth * 0.7, top: 65),
                child: buildLanguageDropdown(context)),
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 10),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: FutureBuilder(
                          future: fetchImage(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text("");
                            return Image.network(
                              snapshot.data.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Roboto"),
                    hintText: AppLocalizations.of(context)
                            ?.translate("Phone Number") ??
                        "Phone Number",
                    textController: _phoneController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Password') ??
                            "Please enter your phone number";
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
                    hintText:
                        AppLocalizations.of(context)?.translate('Password') ??
                            'Password',
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter a company name') ??
                            "Please enter a company name";
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
                          child: Text(
                            AppLocalizations.of(context)
                                    ?.translate("Forgot Password?") ??
                                "Forgot Password",
                            style: const TextStyle(
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
                      text: AppLocalizations.of(context)?.translate("Login") ??
                          "Login"),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 10),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Don't have an account?") ??
                                  "Don't have an account",
                              style: const TextStyle(
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
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Sign Up") ??
                                  "Sigun up",
                              style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
