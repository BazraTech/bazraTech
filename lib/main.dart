// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/RegistrationForm.dart';
import './Models/signuModel.dart';
import 'components/Route/Route.dart';

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
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

PickedFile? _imageFile;

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  void takePicture(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  bool isHiddenPassword = true;
  late signupModel model;
  void isPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
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

    return Scaffold(
      body: SingleChildScrollView(
        //Signu
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: w * 0.8,
                      margin: EdgeInsets.only(top: 150),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.topCenter,
                      child: Registration_Form()),

                  ],
                ),
                height: h - 140,
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
                    child: _imageProfile(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
