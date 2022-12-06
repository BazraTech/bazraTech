import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../components/Route/Route.dart';

class likedStack extends StatefulWidget {
  const likedStack({super.key});

  @override
  State<likedStack> createState() => _likedStackState();
}

class _likedStackState extends State<likedStack> {


  
  PickedFile? _imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    void takePicture(ImageSource source) async {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    }

    void isPasswordView() {
      setState(() {
        isHiddenPassword = !isHiddenPassword;
      });
    }

    void isConfirmPasswordView() {
      setState(() {
        isPassword = !isPassword;
      });
    }

    Widget bottomSheet() {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.camera_enhance_rounded),
                      onPressed: () {
                        takePicture(ImageSource.camera);
                      },
                      label: Text("Camera"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        takePicture(ImageSource.gallery);
                      },
                      label: Text("Gallery"),
                    ),
                  ),
                ])
          ],
        ),
      );
    }

    Widget _imageProfile() {
      return Container(
        alignment: Alignment.topCenter,
        child: Center(
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(155, 161, 182, 0.4),
                      spreadRadius: 3)
                ],
              ),
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Color.fromRGBO(155, 161, 182, 1),
                backgroundImage: _imageFile == null
                    ? AssetImage("asset/profile.png")
                    : FileImage(File(_imageFile!.path)) as ImageProvider,
              ),
            ),
            Positioned(
              bottom: 3.0,
              right: 8.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.lightBlue,
                  size: 28.0,
                ),
              ),
            ),
          ]),
        ),
      );
    }

    Widget _buildPnoneNumber() {
      EdgeInsets.all(30.0);
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            suffixIcon: Icon(Icons.phone, color: Colors.lightBlue),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 4, color: Color.fromARGB(255, 233, 237, 235)),
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
            // Based on passwordVisible state choose the ic
          ),
          style: TextStyle(fontSize: 15, color: Colors.white),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Phone Number';
            }
            return null;
          },
        ),
      );
    }

    Widget _buildFullName() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          decoration: InputDecoration(
            labelText: 'Full Name',
            suffixIcon: Icon(Icons.person, color: Colors.lightBlue),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 4, color: Color.fromARGB(255, 233, 237, 235)),
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
            // Based on passwordVisible state choose the ic
          ),
          style: TextStyle(fontSize: 15, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Full Name';
            }
            return null;
          },
        ),
      );
    }

    Widget _buildEmail() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          decoration: InputDecoration(
            labelText: 'Email',
            suffixIcon: Icon(
              Icons.email,
              color: Colors.lightBlue,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 4, color: Color.fromARGB(255, 233, 237, 235)),
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
            // Based on passwordVisible state choose the ic
          ),
          style: TextStyle(fontSize: 15, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter valid email';
            }
            return null;
          },
        ),
      );
    }

    Widget _buildPassword() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          obscureText: isHiddenPassword,
          decoration: InputDecoration(
            labelText: 'Password',
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
            labelStyle: TextStyle(
              color: Color.fromARGB(255, 255, 235, 255),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  width: 1, style: BorderStyle.solid, color: Colors.white),
            ),
            // Based on passwordVisible state choose the ic
          ),
          style: TextStyle(fontSize: 15, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Password';
            }

            return null;
          },
        ),
      );
    }

    Widget _buildConfirmPassword() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            suffixIcon: InkWell(
              onTap: isConfirmPasswordView,
              child: Icon(
                isPassword ? Icons.visibility : Icons.visibility_off_sharp,
                color: Colors.lightBlue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 4, color: Color.fromARGB(255, 233, 237, 235)),
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
            // Based on passwordVisible state choose the ic
          ),
          style: TextStyle(fontSize: 15, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'your password doesn\'s much';
            }
            return null;
          },
        ),
      );
    }

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          color: Colors.white,
          child: Stack(children: [
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 70, 15, 0),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    suffixIcon: Icon(Icons.phone,
                                        color: Colors.lightBlue),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 4,
                                          color: Color.fromARGB(
                                              255, 233, 237, 235)),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 235, 255),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.white),
                                    ),
                                    // Based on passwordVisible state choose the ic
                                  ),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone Number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              _buildFullName(),
                              _buildEmail(),
                              _buildPassword(),
                              _buildConfirmPassword(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                child: Container(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 4),
                                  height: 16,
                                  width: w,
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
                                              Navigator.of(context).pushNamed(
                                                  AppRoutes.authLogin);
                                            },
                                            child: Text('SIGN IN',
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
                            ],
                          )),
                    ],
                  ),
                ),
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
                  child: _imageProfile(),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

}
