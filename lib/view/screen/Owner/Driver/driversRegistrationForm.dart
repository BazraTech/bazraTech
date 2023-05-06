import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bazralogin/Bottom/Bottom.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import '../../../../Theme/TextInput.dart';
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
      Uri.parse("http://64.226.104.50:9090/Api/Driver/AddDriver"),
    );
    formData.headers['Authorization'] = "Bearer $value";
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
      await http.MultipartFile.fromPath('licensePic', image!.path),
    );
    formData.files.add(
      await http.MultipartFile.fromPath('driverPic', image.path),
    );
    print(licenseFile);
    final response = await formData.send();

    if (response.statusCode == 200) {
      print("yes");
    } else {
      print(response.statusCode.toString());
      // throw Exception(
      //     'Failed load data with status code ${response.statusCode}');
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
    print("${driverName}");
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: kPrimaryColor,
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.14,
                              margin: EdgeInsets.only(top: screenHeight * 0.04),
                              child: MaterialButton(
                                onPressed: () async {
                                  Navigator.pop(
                                    context,
                                  );
                                },

                                child: Material(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Icon(
                                      Ionicons.chevron_back,
                                      size: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),

                                //use this class Circleborder() for circle shape.
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: screenHeight * 0.1,
                                  top: screenHeight * 0.04),
                              child: Text(
                                "Registation From",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            child: SizedBox(
                              child: TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                controller: driverName,
                                decoration: ThemeHelper()
                                    .textInputDecoration("Driver Name"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Driver Name';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              controller: LicenseGrade,
                              decoration: ThemeHelper()
                                  .textInputDecoration("License Grade"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your License Grade';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.text,
                              controller: ownerPhone,
                              decoration: ThemeHelper()
                                  .textInputDecoration("owner phone "),
                              validator: (value) {
                                if (value?.length != 10) {
                                  return 'Please Enter Your Gender';
                                  return null;
                                }
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.text,
                              controller: Gender,
                              decoration:
                                  ThemeHelper().textInputDecoration("Gender"),
                              validator: (value) {
                                if (value?.length != 10) {
                                  return 'Please Enter Your Gender';
                                  return null;
                                }
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.text,
                              controller: dateBirth,
                              decoration: ThemeHelper()
                                  .textInputDecoration('Date Of Birth'),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.phone,
                              controller: driverPhone,
                              decoration:
                                  ThemeHelper().textInputDecoration('Phone'),
                              validator: (value) {
                                if (value?.length != 10) {
                                  return 'Please Enter Your Driver Phone Number Correctly';
                                }
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.text,
                              controller: Experience,
                              decoration: ThemeHelper()
                                  .textInputDecoration('Exprience'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your License Number';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              keyboardType: TextInputType.text,
                              controller: LicenseNumber,
                              decoration: ThemeHelper()
                                  .textInputDecoration('License Number'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your License Number';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
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
                              decoration: ThemeHelper()
                                  .textInputDecoration("Issue Date"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Issue Date';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                              decoration: ThemeHelper()
                                  .textInputDecoration("Expire Date"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your Expire Date';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                              decoration: ThemeHelper()
                                  .textInputDecoration("Driver License"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Upload Your Driver License ';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                              decoration: ThemeHelper()
                                  .textInputDecoration('Driver picture'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Upload Your Driver picture ';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //full name
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                registerDriver(licensePic.text, driverPic.text);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Center(
                                  child: const Text(
                                    " SAVE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              style: ThemeHelper().buttonStyle(),
                            ),
                          ),
                        ],
                      ),
                    )
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
