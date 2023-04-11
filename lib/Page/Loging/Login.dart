import 'dart:convert';
import 'dart:ui';

import 'package:bazralogin/Page/Loging/Resetpin.dart';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/Theme/clippbox.dart';
import 'package:bazralogin/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Bottom/Bottom.dart';
import '../../Model/loginRequestModel.dart';
import '../../config/APIService.dart';
import '../../config/ApiConfig.dart';

import '../Driver/pages/driverHm.dart';
import '../Driver/pages/driverHomePage.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHiddenPassword = true;
  bool isExcecuted = false;
  bool value = false;
  String? username;
  var name;
  String? password;

  final _formKey = GlobalKey<FormState>();
  void _passwordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // UserController userController = UserController();
  void clickBtnLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      LoginRequestModel model =
          LoginRequestModel(username: username!, password: password!);

      APIService.loginFetch(model).then((response) async {
        if (APIService.ownername == "DRIVER") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Driver_Hompage()));
        } else if (APIService.ownername == "OWNER") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else {
          showAlertDialog(context);
        }
      });
    }
    APIService.ownername = "";
  }

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
  void initState() {
    {}
    super.initState();
    //futureWelcome = fetchWelcome();
    //clickLoginBtn();
  }

  @override
  Widget build(BuildContext context) {
    print("yared");

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/images/a.jpg")),
      ),
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(162, 184, 212, 1),
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 175,
                            child: ClipPath(
                              clipper: ClippingClass(),
                              child: Container(
                                  decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/a.jpg")),
                              )),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7, bottom: 34, left: 8, right: 8),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 316,
                          child: Card(
                            color: const Color.fromRGBO(66, 74, 109, 1),
                            elevation: 6,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.only(top: 50),
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: SizedBox(
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: phoneController,
                                              onSaved: ((newValue) {
                                                username = newValue;
                                              }),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'please enter phone number';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: "Phone Number",
                                                labelStyle: const TextStyle(
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          129, 152, 170, 1),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          129, 152, 170, 1),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: TextFormField(
                                              controller: passwordController,
                                              onSaved: ((newValue) {
                                                password = newValue;
                                              }),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'please enter password';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              obscureText: isHiddenPassword,
                                              decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    color: Colors.white),
                                                labelText: "Password",
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isHiddenPassword =
                                                          !isHiddenPassword;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    isHiddenPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.lightBlue,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          129, 152, 170, 1),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          129, 152, 170, 1),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 26.0,
                                            bottom: 8,
                                          ),
                                          child: SizedBox(
                                              height: 45,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 70,
                                                alignment: Alignment.bottomLeft,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ResetPin()));
                                                  },
                                                  child: const Text(
                                                    " Forget Password",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 300,
                                            height: 70,
                                            child: Container(
                                                child: Container(
                                                    // ignore: prefer_const_constructors
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                22.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                22.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                22.0),
                                                        topRight:
                                                            Radius.circular(
                                                                22.0),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: (() {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          Navigator.of(context)
                                                              .pushNamed(AppRoutes
                                                                  .authRegister);
                                                        }
                                                      }),
                                                      child: ElevatedButton(
                                                          onPressed:
                                                              clickBtnLogin,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5.0),
                                                            height: 40,
                                                            width: 320,
                                                            child: const Center(
                                                              child: Text(
                                                                "SIGN IN",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .pressed)) {
                                                                  return Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          148,
                                                                          165,
                                                                          223);
                                                                }
                                                                // 98, 172, 181
                                                                return Colors
                                                                    .lightBlue;
                                                              }),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6))))),
                                                    ))),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 100.0),
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        'New User! ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  AppRoutes.authRegister);
                                            },
                                            child: Text('SIGN UP',
                                                style: TextStyle(
                                                    color: Colors.lightBlue,
                                                    fontSize: 18)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/a.jpg")),
                    ),
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ClipPath(
                            clipper: ClippingClasss(),
                            child: Container(
                                decoration: const BoxDecoration(
                              color: Color.fromRGBO(162, 184, 212, 1),
                            )),
                          ),
                        ),
                        Container(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

}
