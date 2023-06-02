import 'dart:convert';
import 'dart:ui';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/view/screen/Driver/driverBottomnav.dart';
import 'package:bazralogin/view/screen/Loging/forgotPin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bazralogin/Theme/clippbox.dart';
import 'package:bazralogin/const/color.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Model/driverCount.dart';
import '../../../Model/loginRequestModel.dart';
import '../../../Route/Routes.dart';
import '../../../config/APIService.dart';
import '../../../Model/ApiConfig.dart';
import '../Bottom/Bottom.dart';
import '../Driver/driverHomepage.dart';

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
  Future Total_Drivers() async {
    final totalDrivers = await CountDrivers.TotalDrivers();
  }

  Future vehicleFetch() async {
    // fetch list of total vehicles
    await APIService.vehicleFetch();
  }

  void clickBtnLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      LoginRequestModel model =
          LoginRequestModel(username: username!, password: password!);

      APIService.loginFetch(model).then((response) async {
        if (APIService.ownername == "DRIVER") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => driverBottomn()));
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
        "phoneNumber": "${phoneController.text}",
      };
      var response = await http.post(
          Uri.parse('http://64.226.104.50:9090/Api/User/GeneratePIN'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storage.write(key: "jwt", value: data["message"]);
        var value = await storage.read(key: 'jwt');
        print(value);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => forgotPin(
                      phone: phoneController.text,
                    )));
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
    super.initState();
    Total_Drivers();
    vehicleFetch();
    //futureWelcome = fetchWelcome();
    //clickLoginBtn();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    print("yared");

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/images/a.jpg")),
      ),
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(162, 184, 212, 1),
                  height: hight * 0.91,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: hight * 0.2,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black
                            //         .withOpacity(0.3), // Shadow color
                            //     blurRadius: 5, // Spread radius
                            //     offset:
                            //         Offset(0, 3), // Offset in (x,y) coordinates
                            //   ),
                            // ],
                            color: Color.fromRGBO(50, 56, 61, 1),
                            borderRadius: BorderRadius.circular(18),
                            // border: Border.all(
                            //   color: Colors.white, // Set the border color
                            //   width: 2.5,
                            // ),
                          ),
                          margin: EdgeInsets.only(top: hight * 0.06, bottom: 0),
                          height: hight * 0.5,
                          child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: phoneController,
                                        onSaved: ((newValue) {
                                          username = newValue;
                                        }),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
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
                                                BorderRadius.circular(12.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    129, 152, 170, 1),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                                  BorderRadius.circular(12.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      129, 152, 170, 1),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: width,
                                      height: hight * 0.03,
                                      alignment: Alignment.bottomLeft,
                                      child: InkWell(
                                        onTap: () {
                                          ResetPasswords();
                                        },
                                        child: const Text(
                                          " Forget Password",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: width,
                                        height: hight * 0.13,
                                        child: Container(
                                            child: Container(
                                                // ignore: prefer_const_constructors
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(22.0),
                                                    bottomLeft:
                                                        Radius.circular(22.0),
                                                    bottomRight:
                                                        Radius.circular(22.0),
                                                    topRight:
                                                        Radius.circular(22.0),
                                                  ),
                                                ),
                                                child: TextButton(
                                                  onPressed: (() {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Get.toNamed(AppRoutes
                                                          .getHomeRoute());
                                                    }
                                                  }),
                                                  child: ElevatedButton(
                                                      onPressed: clickBtnLogin,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 5.0),
                                                        height: 40,
                                                        width: 320,
                                                        child: const Center(
                                                          child: Text(
                                                            "SIGN IN",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              6))))),
                                                ))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 100.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Text(
                                              'New User! ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Navigator.of(context).pushNamed(
                                                  //     AppRoutes.authRegister);
                                                },
                                                child: Text('SIGN UP',
                                                    style: TextStyle(
                                                        color: Colors.lightBlue,
                                                        fontSize: 18)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/a.jpg")),
                        ),
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
                    ],
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
