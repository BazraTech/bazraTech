import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../../Theme/customAppBar.dart';
import '../../../const/constant.dart';

//import 'package:open_file/open_file.dart';

class updateDriverinfo extends StatefulWidget {
  String? fullname;
  int? phone;
  int? expirence;
  int? licencegrade;
  String? birth;
  String? issuedate;
  String? expiredate;
  updateDriverinfo(
      {super.key,
      this.fullname,
      this.issuedate,
      this.expiredate,
      this.phone,
      this.expirence,
      this.licencegrade,
      this.birth});

  @override
  State<updateDriverinfo> createState() => _updateDriverinfoState();
}

bool isHiddenPassword = true;
FilePickerResult? license;
String? _fileName;
PlatformFile? pickedfile;
File? fileToDisplay;
bool isLoading = false;

File? _file;
PlatformFile? _platformFile;

TextEditingController dateBirth = TextEditingController();
TextEditingController dateIssue = TextEditingController();
TextEditingController dateExpire = TextEditingController();
uploadFiles() async {
  var request =
      http.MultipartRequest("POST", Uri.parse("https://api.imgur.com/3/image"));
  request.fields['title'] = "dummyImage";
  request.headers['Authorization'] = "Client-ID " + "f7........";
  var pdf = http.MultipartFile.fromBytes(
      'image', (await rootBundle.load('assets/Amz7.pdf')).buffer.asUint8List(),
      filename: 'Amz7.pdf');
  request.files.add(pdf);
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var result = String.fromCharCodes(responseData);
  print(result);
}

void showFile_picker() async {
  try {
    license = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (license != null) {
      _fileName = license!.files.first.name;
      pickedfile = license!.files.first;
      fileToDisplay = File(pickedfile!.path.toString());
      print('File Name $_fileName');
    }
  } catch (err) {
    print(err);
  }
}

class _updateDriverinfoState extends State<updateDriverinfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void initState() {}
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      // ignore: prefer_const_constructors
      //  appBar: CustomAppBar(
      //   backgroundColor: kBackgroundColor,
      //   toolbarHeight: 70,
      //       height:screenHeight*0.07,
      //     child: const Center(
      //   child: TextField(
      //     decoration: InputDecoration(
      //         hintText: 'Driver Name or Plate No.',
      //         border: InputBorder.none,
      //         errorBorder: InputBorder.none,
      //         enabledBorder: InputBorder.none,
      //         focusedBorder: InputBorder.none,
      //         prefixIcon: Icon(Icons.search),
      //         suffixIcon: Icon(Icons.clear)),
      //   ),
      // ),),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SizedBox(
            child: Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: 20,
                    right: 20),
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: SizedBox(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: '${widget.fullname}',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(177, 0, 0, 0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              // Based on passwordVisible state choose the ic
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your First Name';
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
                        height: 10,
                      ),
                      SizedBox(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          keyboardType: TextInputType.text,
                          controller: dateBirth,
                          decoration: InputDecoration(
                            hintText: '${widget.birth}',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                          initialValue: '${widget.phone}',
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '${widget.phone}',
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                          initialValue: '${widget.licencegrade}',
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: '${widget.licencegrade}',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                            hintText: '${widget.issuedate}',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                            hintText: '${widget.expiredate}',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                          keyboardType: TextInputType.url,
                          onTap: () async {
                            uploadFiles();
                            //  loadingController.forward();
                            if (pickedfile != null) {
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: 300,
                                child: Image.file(fileToDisplay!),
                              );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Driver License',
                            suffixIcon: Icon(
                              Icons.upload_file,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
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
                      //full name
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: const Text(
                                " UPDATE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
      ),
    );
  }
}
