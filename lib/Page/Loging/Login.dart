// ignore: file_names
import 'dart:ui';

import 'package:bazralogin/Model/Loginmodel.dart';
import 'package:bazralogin/Page/service/loginapi.dart';
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  LoginRequestModel? requestModel;

  bool isAppprocess = false;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  TextEditingController password = TextEditingController();
  TextEditingController emailControl = TextEditingController();

  Loginvalidate() {
    if (validateandSave()) {
      print(requestModel?.toJson());

      setState(() {
        isAppprocess = true;
      });

      Loginapiservice apiService = new Loginapiservice();
      apiService.login(requestModel!).then((value) {
        if (value.token!.isNotEmpty) {
          Navigator.of(context).pushNamed(AppRoutes.authRegister);
        }
      });
    }
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
                          height: MediaQuery.of(context).size.height - 318,
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
                                margin: const EdgeInsets.only(top: 30),
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
                                              onSaved: (Value) => requestModel
                                                  ?.username = Value,
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
                                              keyboardType: TextInputType.text,
                                              onSaved: (input) => requestModel
                                                  ?.password = input,
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
                                              height: 60,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 70,
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
                                                      onPressed: () {
                                                        // if (_formKey
                                                        //     .currentState!
                                                        //     .validate()) {
                                                        Navigator.of(context)
                                                            .pushNamed(AppRoutes
                                                                .bottom);
                                                        //   }
                                                        // }),
                                                      },
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // if (_formKey
                                                          //     .currentState!
                                                          //     .validate()) {}
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  AppRoutes
                                                                      .bottom);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5.0),
                                                          height: 40,
                                                          width: 310,
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
                                                                        BorderRadius.circular(
                                                                            25)))),
                                                      ),
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
  bool validateandSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
