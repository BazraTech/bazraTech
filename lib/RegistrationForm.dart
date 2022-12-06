import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'components/Route/Route.dart';

class Registration_Form extends StatefulWidget {
  const Registration_Form({super.key});

  @override
  State<Registration_Form> createState() => _Registration_FormState();
}

bool isHiddenPassword = true;

class _Registration_FormState extends State<Registration_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void isPasswordView() {
      setState(() {
        isHiddenPassword = !isHiddenPassword;
      });
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Phone Number',

              suffixIcon: Icon(
                Icons.phone,
                color: Colors.lightBlue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 233, 237, 235)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 255, 235, 255),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.white),
              ),
              // Based on passwordVisible state choose the ic
            ),
            validator: (value) {
              if (value?.length != 10) {
                return 'Please Enter Your Name';
                return null;
              }
            },
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          //password
          SizedBox(
            height: 16,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Full Name',
              suffixIcon: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 233, 237, 235)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 255, 235, 255),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.white),
              ),
              // Based on passwordVisible state choose the ic
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Your Name';
              }
              return null;
            },
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 16,
          ),
          //full name
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              suffixIcon: Icon(
                Icons.email,
                color: Colors.lightBlue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 233, 237, 235)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 255, 235, 255),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.white),
              ),
              // Based on passwordVisible state choose the ic
            ),
            validator: (val) => val!.isEmpty || !val.contains("@")
                ? "Enter a valid eamil"
                : null,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          //password
          SizedBox(
            height: 16,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: InkWell(
                onTap: isPasswordView,
                child: Icon(
                  isHiddenPassword
                      ? Icons.visibility
                      : Icons.visibility_off_sharp,
                  color: Colors.lightBlue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 233, 237, 235)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 255, 235, 255),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.white),
              ),
              // Based on passwordVisible state choose the ic
            ),
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Please Enter 6 character';
              }
              return null;
            },
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          //Confirm Password
          SizedBox(
            height: 16,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              suffixIcon: InkWell(
                onTap: isPasswordView,
                child: Icon(
                  isHiddenPassword
                      ? Icons.visibility
                      : Icons.visibility_off_sharp,
                  color: Colors.lightBlue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 233, 237, 235)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 255, 235, 255),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.white),
              ),
              // Based on passwordVisible state choose the ic
            ),
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Please enter a valid password';
              }
              return null;
            },
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 16,
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color.fromRGBO(255, 148, 165, 223);
                    }
                    return Colors.grey;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(left: 4),
              height: 16,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Text(
                    'Already have an account! ',
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
                          Navigator.of(context).pushNamed(AppRoutes.authLogin);
                        },
                        child: Text('SIGN IN',
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 18)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
