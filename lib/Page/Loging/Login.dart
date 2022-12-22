// ignore: file_names
import 'dart:ui';

import 'package:bazralogin/Route/route.dart';
import 'package:bazralogin/Theme/clippbox.dart';
import 'package:bazralogin/const/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHiddenPassword = true;
  bool isExcecuted = false;

  final _formKey = GlobalKey<FormState>();
  void _passwordView() {
    //if (isHiddenPassword == true) {
    //isHiddenPassword = false;
    // } else {
    //isHiddenPassword = true;
    //}

    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(129, 152, 170, 1),
                                    width: 5)),
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
                                              keyboardType:
                                                  TextInputType.number,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 233, 237, 235)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 233, 237, 235)),
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
                                              left: 26.0, bottom: 8, top: 8),
                                          child: SizedBox(
                                              height: 20,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 35,
                                                alignment: Alignment.bottomLeft,
                                                child: const Text(
                                                  " Forget Password",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: 200,
                                              height: 40,
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
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(AppRoutes
                                                            .authRegister);
                                                    if (_formKey.currentState!
                                                        .validate()) {}
                                                  },
                                                  child: const Text(
                                                    " Sign IN",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith(
                                                                  (states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .pressed)) {
                                                          return ColorsConsts
                                                              .backgroundColor;
                                                        }
                                                        return const Color
                                                                .fromRGBO(
                                                            69, 92, 128, 1);
                                                      }),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              side: const BorderSide(
                                                                  color:
                                                                      Color.fromRGBO(
                                                                          162,
                                                                          184,
                                                                          212,
                                                                          1)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(32)))),
                                                ),
                                              ))),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Text("New User?",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Text(
                                              " Sign Up",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              )
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
