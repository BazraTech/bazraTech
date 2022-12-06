// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Models/signuModel.dart';

//import 'package:email_validator/email_validator.dart' as validator;
void main() {
  runApp(Registration());
}

class Registration extends StatelessWidget {
  const Registration({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  
 late signupModel model;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,

      child:Stack(
         children: [           
            Container(
              child: Column(
                children:<Widget> [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Registration_TextFormField(
                      hintText: "Phone Number",
                      isEmail: false,
                      isPassword: false,
                      key: _formKey,
                      validation: (String value){
                        if(value.isEmpty){
                          return 'Please enter a phone number';
                        }      
                        return null; 
                                  },
                                  onSaved: (String value){
                                    model.phoneNumber=value;
                                  },
                    ),
                  ),
                  Container(
                        alignment: Alignment.topCenter,
                    child: Registration_TextFormField(
                      hintText: "FullName",
                      isEmail: false,
                      isPassword: false,
                      key: _formKey,

                      validation: (String value){
                        if(value.isEmpty)
                        return 'Please enter a full name';
                      return null;
                      },
                       onSaved: (String value){
                                    model.phoneNumber=value;
                                  },

                    ),
                    ),
                  Container(
                        alignment: Alignment.topCenter,
                    child: Registration_TextFormField(
                      hintText: "Email",
                      isEmail: true,
                      isPassword: false,
                      key: _formKey,
                        validation: (String value){
                        if(value.isEmpty)
                        return 'Please enter a valid email';
                      return null;
                      },
                       onSaved: (String value){
                                    model.phoneNumber=value;
                                  },

                    ),
                    
                  ),
                                Container(
                        alignment: Alignment.topCenter,
                    child: Registration_TextFormField(
                      hintText: "password",
                      isPassword: true,
                      isEmail: false,
                      key: _formKey,
                        validation: (String value){
                        if(value.isEmpty)
                        return 'Please enter a full name';
                      return null;
                      },
                       onSaved: (String value){
                                    model.password=value;
                                  },

                    ),
                    
                  ),
                                Container(
                        alignment: Alignment.topCenter,
                    child: Registration_TextFormField(
                      hintText: "Confirm Password",
                      isPassword: true,
                      isEmail: false,
                      key: _formKey,
                        validation: (String value){
                        if(value.isEmpty)
                        return 'Password doesn\'t much';
                      return null;
                      },
                       onSaved: (String value){
                                    model.password=value;
                                  },
                    ),
                    
                  ),
                  Container(

                     child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {}
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 250,
                                          child: Center(
                                            child: const Text(
                                              " SIGN UP",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Color.fromRGBO(255, 148, 165, 223);
                                              }
                                              return Colors.grey;
                                            }),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)))),
                                      ),
                                        ),
                ],
              ),
              height: h - 150,
              width: w,
              margin: EdgeInsets.only(top: 160),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/road.png'),
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(155, 161, 182, 0.8),
                    BlendMode.modulate,
                  ), // <-- BACKGROUND IMAGE
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                ),
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 25,
              left: w * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: w * 0.4,
                  width: w * 0.4,
                  // child: _imageProfile(),
                ),
              ),
            ),
    ],),
         
       );
  }
}

class Registration_TextFormField extends StatelessWidget {
  final String hintText;
  final Function validation;
  final Function onSaved;
  final bool isEmail;
  final bool isPassword;
  Registration_TextFormField(
      {super.key,
      required this.hintText,
      this.isEmail = false,
      this.isPassword = false,
      required this.onSaved,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(Icons.phone, color: Colors.lightBlue),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 255, 235, 255),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.white),
          ),
        ),
        style: TextStyle(fontSize: 15, color: Colors.white),
        obscureText: isPassword ? true : false,
        validator: validation(),
        onSaved: onSaved(),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
