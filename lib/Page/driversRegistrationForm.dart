import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

//import 'package:open_file/open_file.dart';

class DriversForm extends StatefulWidget {
  const DriversForm({super.key});

  @override
  State<DriversForm> createState() => _DriversFormState();
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

class _DriversFormState extends State<DriversForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void initState() {}
  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers Registrations'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.blueGrey),
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
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.black),
                    ),
                    // Based on passwordVisible state choose the ic
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Last Name';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Gender',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.blueGrey),
                    ),
                    // Based on passwordVisible state choose the ic
                  ),
                  validator: (value) {
                    if (value?.length != 10) {
                      return 'Please Enter Your Name';
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
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
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'License Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Grade',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.blueGrey),
                    ),
                    // Based on passwordVisible state choose the ic
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Grade';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
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
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),

                TextFormField(
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
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  cursorHeight: 25,
                  keyboardType: TextInputType.url,
                  onTap: () async {
                    uploadFiles();
                    //  loadingController.forward();
                    if (pickedfile != null) {
                      SizedBox(
                        height: 300,
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
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                SizedBox(
                  height: 16,
                ),
                //full name
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      height: 50,
                      width: 310,
                      child: Center(
                        child: const Text(
                          " SAVE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
