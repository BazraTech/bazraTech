import 'dart:convert';
import 'dart:io';
import 'package:cargo/views/usermanagement/Profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cargo/shared/constant.dart';
import 'package:cargo/views/usermanagement/login.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../localization/app_localizations.dart';
import '../../shared/custom-form.dart';
import '../../shared/customButton.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  String? companyName;
  String? ownerAvatar;
  ProfileEdit({super.key, this.companyName, required this.ownerAvatar});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

TextEditingController from = TextEditingController();

class _ProfileEditState extends State<ProfileEdit> {
  final _companyController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PickedFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void takePicture(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _pickedImage = pickedFile != null ? PickedFile(pickedFile.path) : null;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed

    _genderController.dispose();
    _emailController.dispose();
    // _confirmPasswordController.dispose();

    super.dispose();
  }

  void _showSweetAlert(BuildContext context, AlertType alertType, String title,
      String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      style: AlertStyle(
        descStyle: TextStyle(fontSize: 14),
        isOverlayTapDismiss: false,
        overlayColor: Colors.black54,
        animationType: AnimationType.grow,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titleStyle: TextStyle(
          color: alertType == AlertType.error ? Colors.red : Colors.blue,
        ),
        alertAlignment: Alignment.center,
        alertElevation: 10,
      ),
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (alertType == AlertType.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Cargo_login()),
              );
            } else if (alertType == AlertType.error) {
              Navigator.pop(context);
            }
          },
          width: 200,
        ),
      ],
    ).show();
  }

  registerCargo(String company, String gender, String email) async {
    const url = 'http://164.90.174.113:9090/Api/SignUp/Cargo';

    // Define your request data as a Map
    Map requestData = {
      'companyName': "${company}",
      'phone': "${gender}",
      'confirmPassword': "${email}",
    };
    print(requestData);

    print(requestData);

    print("********************************");
    print('Token: $requestData');
    print("********************************");
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
        final Map jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cargo_login()),
          );
        } else {
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'An error occurred, please check your internet connection.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  bool _isErrorVisible = false;
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: screenWidth * 0.12),
              height: 40,
              child: const Center(
                child: Text(
                  "Update Profile Here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.15,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        Positioned(
                            left: screenWidth * 0.3,
                            height: screenHeight * 0.15,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 58,
                                        backgroundColor: Colors.white,
                                        backgroundImage: _pickedImage == null
                                            ? NetworkImage(
                                                "${widget.ownerAvatar}")
                                            : FileImage(
                                                    File(_pickedImage!.path))
                                                as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      left: 62,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: screenHeight * 0.07),
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext contex) {
                                                  return AlertDialog(
                                                    title: Text('Choose Option',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.lightBlue,
                                                        )),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  takePicture(
                                                                      ImageSource
                                                                          .camera);
                                                                },
                                                                splashColor: Colors
                                                                    .lightBlue,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .camera,
                                                                        color: Colors
                                                                            .lightBlue,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        'Camera',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.grey[500]))
                                                                  ],
                                                                )),
                                                            InkWell(
                                                                onTap: () {
                                                                  takePicture(
                                                                      ImageSource
                                                                          .gallery);
                                                                },
                                                                splashColor: Colors
                                                                    .lightBlue,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .browse_gallery,
                                                                        color: Colors
                                                                            .lightBlue,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        'Galley',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.grey[500]))
                                                                  ],
                                                                )),
                                                            InkWell(
                                                                onTap: () {},
                                                                splashColor: Colors
                                                                    .lightBlue,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove_circle,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        'Remove',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.grey[500]))
                                                                  ],
                                                                )),
                                                          ]),
                                                    ),
                                                  );
                                                });
                                          },
                                          elevation: 10,
                                          fillColor: Colors.lightBlue,
                                          child: Icon(Icons.add_a_photo),
                                          shape: CircleBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Roboto"),
                    hintText:
                        AppLocalizations.of(context)?.translate("Full Name") ??
                            "Full Name",
                    textController: _companyController,
                    keyboardType: TextInputType.text,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate("Please enter your full  name") ??
                            "Please enter your full name";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _companyController,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: '${widget.companyName}',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter your company name') ??
                            "Please enter your company name";
                      }
                      return null;
                    },
                    // validator: _validateDate,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    hintText:
                        AppLocalizations.of(context)?.translate("Email") ??
                            "Email",
                    textController: _emailController,
                    obscureText: false,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter your email ') ??
                            "Please enter your email ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    hintText:
                        AppLocalizations.of(context)?.translate("Gender") ??
                            "Gender",
                    textController: _genderController,
                    obscureText: false,
                    hintTextStyle: TextStyle(
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                      color: _isFocus ? Colors.red : Colors.grey,
                      // ... other styles
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)
                                ?.translate('Please enter your gender') ??
                            "Please enter your gender";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await registerCargo(_companyController.text,
                          _genderController.text, _emailController.text);
                    },
                    text: AppLocalizations.of(context)?.translate('Update') ??
                        "Update",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
