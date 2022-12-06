// ignore: file_names
import 'dart:ui';
import '../RegistrationForm.dart';
import '../components/Route/Route.dart';
import '../const/color.dart';

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

  final _formKey = GlobalKey<FormState>();
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
                          height: MediaQuery.of(context).size.height - 320,
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
                                margin: EdgeInsets.only(top: 70),
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
                                            height: 50,
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
                                                  borderSide: BorderSide(
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
                                            height: 50,
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
                                              child: forgetPassword()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: Container(
                                                  child: Signinoption())),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    SizedBox(height: 20, child: signUpOption()),
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(0),
          child: Text("New User?", style: TextStyle(color: Colors.white)),
        ),
        GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(0),
            child: Text(
              " Sign Up",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Signinoption() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.0),
          bottomLeft: Radius.circular(22.0),
          bottomRight: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
          if (_formKey.currentState!.validate()) {}
        },
        child: const Text(
          " Sign IN",
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return ColorsConsts.backgroundColor;
              }
              return const Color.fromRGBO(69, 92, 128, 1);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    side: BorderSide(
                        color: const Color.fromRGBO(162, 184, 212, 1)),
                    borderRadius: BorderRadius.circular(32)))),
      ),
    );
  }

  Widget forgetPassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomLeft,
      child: const Text(
        " Forget Password",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
        size.width - (size.width / 2), size.height, size.width, 0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClippingClasss extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
