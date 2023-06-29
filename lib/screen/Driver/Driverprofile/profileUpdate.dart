import 'dart:convert';
import 'dart:io';

import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/Theme/TextInput.dart';
import 'package:bazralogin/const/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

import '../../Owner/Driver/assignDriver.dart';

class driverprofileUpadate extends StatefulWidget {
  String? image;
  String? email;
  String? phone;
  String? datebirth;
  String? gender;
  String? name;

  driverprofileUpadate(
      {super.key,
      this.image,
      this.email,
      this.datebirth,
      this.gender,
      this.name,
      this.phone});

  @override
  State<driverprofileUpadate> createState() => _driverprofileUpadateState();
}

class _driverprofileUpadateState extends State<driverprofileUpadate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  bool isHiddenPassword = true;

  String Logoavtar = "";
  String ownerpic = "";
  PickedFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? owneriamg;

  void isPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void takePicture(ImageSource source) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      owneriamg = File(image!.path).path;
    });

    print(owneriamg);
  }

  registerDriver(String? pickedImage) async {
    var value = await storage.read(key: 'jwt');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    };

    final formData = http.MultipartRequest(
      'PUT',
      Uri.parse("http://64.226.104.50:9090/Api/Driver/UpdateInfo"),
    );
    formData.headers['Authorization'] = "Bearer $value";

    formData.files.add(
      await http.MultipartFile.fromPath('driverPic', pickedImage!),
    );
    print("yared12222 992900");
    print(
        "/data/user/0/com.example.bazralogin/cache/0e681c23-32a7-4b98-9dbd-ba18c4f8e2c6/Screenshot_20230502-041436.png");

    final response = await formData.send();
    var responseData = await response.stream.bytesToString();
    var decodedResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      String alertContent = decodedResponse["message"];

      alertutilsfordriver.showMyDialog(context, "Alert", alertContent);
    } else {
      // String alertContent = decodedResponse["message"];

      // throw Exception(
      //     'Failed load data with status code ${response.statusCode}');
      print("no");
    }
  }

  Future<String> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "ownerpic", value: data["avatar"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["avatar"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String readOnlyText = "${widget.name}";
    String email = "${widget.email}";
    String date = "${widget.datebirth}";
    String genderowner = "${widget.gender}";
    String phonenumber = "${widget.phone}";

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.06, right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Ionicons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: height * 0.2,
              child: Stack(
                children: [
                  Positioned(
                      left: width * 0.3,
                      height: height * 0.2,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 51,
                                backgroundColor: Colors.blueGrey,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: owneriamg == null
                                      ? null
                                      : FileImage(File(owneriamg.toString()))
                                          as ImageProvider,
                                ),
                              ),
                              Positioned(
                                left: 40,
                                child: Container(
                                  margin: EdgeInsets.only(top: height * 0.07),
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) {
                                            return AlertDialog(
                                              title: Text('Choose Option',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.lightBlue,
                                                  )),
                                              content: SingleChildScrollView(
                                                child: ListBody(children: [
                                                  InkWell(
                                                      onTap: () {
                                                        takePicture(
                                                            ImageSource.camera);
                                                      },
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.camera,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                          ),
                                                          Text('Camera',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        takePicture(ImageSource
                                                            .gallery);
                                                      },
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .browse_gallery,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                          ),
                                                          Text('Galley',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {},
                                                      splashColor:
                                                          Colors.lightBlue,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text('Remove',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]))
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: readOnlyText),
                        decoration: ThemeHelper().textInputDecoration(""))),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(
                          text: email,
                        ),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Phone number",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.07,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: phonenumber),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: genderowner),
                        decoration: ThemeHelper().textInputDecoration(""))),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: Text(
                  "Birth Date",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: width - 32,
                    height: height * 0.08,
                    child: TextFormField(
                        enabled: false,
                        controller: TextEditingController(text: date),
                        decoration: ThemeHelper().textInputDecoration())),
              ],
            ),
            SizedBox(height: height * 0.03),
            Container(
              width: width - 20,
              margin: EdgeInsets.only(bottom: 20),
              height: height * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    registerDriver(owneriamg!);
                  },
                  child: Container(
                    height: 55,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Empty SizedBox if not loading

                        Text(
                          'Update',
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))))),
            ),
          ],
        ),
      ),
    );
  }
}
