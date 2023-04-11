import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:bazralogin/Bottom/Bottom.dart';
import 'package:bazralogin/Page/Localization/Localization.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../Theme/customAppBar.dart';
import '../../../../config/ApiConfig.dart';
import '../../../../const/constant.dart';
import 'assignDriver.dart';

class DriversFormOwner extends StatefulWidget {
  const DriversFormOwner({super.key});

  @override
  State<DriversFormOwner> createState() => _DriversFormOwnerState();
}

bool isHiddenPassword = true;
FilePickerResult? license;
var timer;

final storage = new FlutterSecureStorage();
TextEditingController driverName = TextEditingController();
TextEditingController LicenseNumber = TextEditingController();
TextEditingController licensePic = TextEditingController();
TextEditingController driverPic = TextEditingController();
TextEditingController ownerPhone = TextEditingController();
TextEditingController driverPhone = TextEditingController();
TextEditingController dateBirth = TextEditingController();
TextEditingController Experience = TextEditingController();
TextEditingController LicenseGrade = TextEditingController();
TextEditingController Gender = TextEditingController();
TextEditingController dateIssue = TextEditingController();
TextEditingController dateExpire = TextEditingController();

class _DriversFormOwnerState extends State<DriversFormOwner> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List Result = [];
  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Register Successsful !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Phone number already in use! !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> registerDriver(String driverFile, String licenseFile) async {
    var value = await storage.read(key: 'jwt');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    };

    final formData = http.MultipartRequest(
      'POST',
      Uri.parse("http://198.199.67.201:9090/Api/Driver/AddDriver"),
    );
    formData.headers['Authorization'] = "Bearer $value";

    formData.fields['driverName'] = driverName.text;
    formData.fields['licenseNumber'] = LicenseNumber.text;
    formData.fields['OwnerPhone'] = ownerPhone.text;
    formData.fields['driverPhone'] = driverPhone.text;
    formData.fields['birthDate'] = dateBirth.text;
    formData.fields["experience"] = Experience.text;
    formData.fields["licenseGrade"] = LicenseGrade.text;
    formData.fields["gender"] = Gender.text;
    formData.fields["licenseIssueDate"] = dateIssue.text;
    formData.fields["licenseExpireDate"] = dateExpire.text;

    formData.files.add(
      await http.MultipartFile.fromPath('licensePic', licenseFile),
    );
    formData.files.add(
      await http.MultipartFile.fromPath('driverPic', driverFile),
    );
    print(licenseFile);
    final response = await formData.send();

    if (response.statusCode == 200) {
      _showMyDialog1();
    } else if (Result.isNotEmpty) {
      for (var a in Result) {
        var plateNumber = a['phoneNumber'];
        if (plateNumber == ownerPhone.text) {}
      }
      _showMyDialog();
    } else {
      print(response.statusCode.toString());
      throw Exception(
          'Failed load data with status code ${response.statusCode}');
    }
  }

  Future vehicleFetch() async {
    final Result = await APIService.driverFetch();

    if (mounted) {
      timer = Timer.periodic(
          Duration(seconds: 5),
          (Timer t) => setState(() {
                this.Result = Result;
              }));
    }
  }

  void initState() {
    super.initState();

    vehicleFetch();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(Result);
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text(TranslationUtil.text("Registration Form Page")),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Container(
              width: screenWidth - 10,
              height: screenHeight,
              margin: EdgeInsets.only(
                  top: screenHeight * 0.05, left: 20, right: 20),
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: SizedBox(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          controller: driverName,
                          decoration: InputDecoration(
                            hintText: 'Drive Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.blueGrey),
                            ),
                            // Based on passwordVisible state choose the ic
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Driver Name';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        controller: LicenseGrade,
                        decoration: InputDecoration(
                          hintText: 'License Grade',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your License Grade';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.text,
                        controller: Gender,
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value?.length != 10) {
                            return 'Please Enter Your Gender';
                            return null;
                          }
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.text,
                        controller: dateBirth,
                        decoration: InputDecoration(
                          hintText: 'Birth Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.black),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        onTap: () async {
                          DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2101));
                          if (pickDate != null) {
                            dateBirth.text =
                                DateFormat('yyyy-MM-dd').format(pickDate);
                          }
                          return null;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Date Of Birth';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.phone,
                        controller: ownerPhone,
                        decoration: InputDecoration(
                          hintText: 'Owner Phone Number',
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value?.length != 10) {
                            return 'Please Enter Your Phone Correctly';
                          }
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.phone,
                        controller: driverPhone,
                        decoration: InputDecoration(
                          hintText: 'Driver Phone Number',
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value?.length != 10) {
                            return 'Please Enter Your Driver Phone Number Correctly';
                          }
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.text,
                        controller: LicenseNumber,
                        decoration: InputDecoration(
                          hintText: 'License Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.black),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your License Number';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.text,
                        controller: dateIssue,
                        onTap: () async {
                          DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2101));
                          if (pickDate != null) {
                            dateIssue.text =
                                DateFormat('yyyy-MM-dd').format(pickDate);
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Issue Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Issue Date';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.text,
                        controller: dateExpire,
                        onTap: () async {
                          DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1980),
                              lastDate: DateTime(2101));
                          if (pickDate != null) {
                            dateExpire.text =
                                DateFormat('yyyy-MM-dd').format(pickDate);
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Expire Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Expire Date';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        controller: licensePic,
                        keyboardType: TextInputType.url,
                        onTap: () async {
                          final XFile? image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          setState(() {
                            licensePic.text = File(image!.path).path;
                          });
                          print(licensePic.text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Driver License',
                          suffixIcon: Icon(
                            Icons.upload_file,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Upload Your Driver License ';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        controller: driverPic,
                        keyboardType: TextInputType.url,
                        onTap: () async {
                          final XFile? image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          setState(() {
                            driverPic.text = File(image!.path).path;
                          });
                          print(driverPic.text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Driver Picture',
                          suffixIcon: Icon(
                            Icons.upload_file,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(177, 0, 0, 0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.blueGrey),
                          ),
                          // Based on passwordVisible state choose the ic
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Upload Your Driver picture ';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //full name
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          registerDriver(licensePic.text, driverPic.text);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: const Text(
                              " SAVE",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromRGBO(255, 148, 165, 223);
                              }
                              // 98, 172, 181
                              return Colors.lightBlue;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
