import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Components/Noglow.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_event.dart';
import '../../shared/cargoInfo.dart';
import '../../shared/cargoInfo.dart';
import '../../shared/cargoPhone.dart';
import '../../shared/constant.dart';
import '../../shared/storage_hepler.dart';
import 'ProfileEdit.dart';
import 'changePassword.dart';
import 'languages.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  String? companyName;
  Profile({super.key, this.companyName});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ownerPic = "";
  Future<String> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(
        Uri.parse('http://164.90.174.113:9090/Api/Admin/LogoandAvatar'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "ownerpic", value: data["avatar"].toString());

      ownerPic = (await storage.read(key: 'ownerpic'))!;
      return data["avatar"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  String name = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    if(mounted){
    getCargoInfo();
    getPhoneNumber();
    }
    
  }

  Future<void> getCargoInfo() async {
    CargoInfo cargoInfo = CargoInfo();
    String? cargoName = await cargoInfo.getCargoInfo();

    setState(() {
      name = cargoName ?? '';
    });
  }

  Future<void> getPhoneNumber() async {
    CargoPhoneNumber phoneNum = CargoPhoneNumber();
    String? cargoPhone = await phoneNum.getCargoPhoneNumber();

    setState(() {
      phone = cargoPhone ?? '';
    });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Cargo_login()),
                  (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget buildLanguageDropdown(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final localeBloc = context.read<LocaleBloc>();
    bool isPressed = true;
    return Container(
      width: screenWidth * 0.09,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular((6))),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 25,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: DropdownButton<Locale>(
        value: localeBloc.state.locale,
        underline: Container(),
        iconSize: 30,
        items: <Locale>[
          Locale('en', ''),
          Locale('am', ''),
        ].map<DropdownMenuItem<Locale>>((Locale value) {
          return DropdownMenuItem<Locale>(
            value: value,
            child: Text(value.languageCode),
          );
        }).toList(),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            localeBloc.add(ChangeLocale(newLocale));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FutureBuilder(
                          future: _fetchLogo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text("");
                            return CircleAvatar(
                              radius: 58,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data.toString(),
                                  fit: BoxFit
                                      .cover, // Adjust the fit property to your desired value
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$name"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  height: screenHeight * 0.2,
                  width: screenWidth,
                  child: Column(children: [
                    SizedBox(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEdit(
                                      companyName: name,
                                      ownerAvatar: ownerPic,
                                    )),
                          );
                        },
                        leading: Container(
                          height: screenWidth * 0.08,
                          width: screenWidth * 0.08,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                        title: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ListTile(
                        title: const Text(
                          "Phone Number",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$phone",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageListItem()),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight *
                            0.035, // Increase the vertical padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: screenWidth * 0.08,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(252, 221, 244, 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(Icons.language_sharp),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  height: screenHeight * 0.35,
                  width: screenWidth,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()),
                          );
                        },
                        leading: Container(
                          height: screenWidth * 0.08,
                          width: screenWidth * 0.08,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(201, 252, 248, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.lock_outline),
                        ),
                        title: const Text(
                          'Change password',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                                height: screenWidth * 0.08,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 245, 210, 1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Icon(Icons.help)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: screenWidth * 0.3,
                                  child: const Text(
                                    "Help",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.37),
                                child: Icon(Icons.keyboard_arrow_right)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                                height: screenWidth * 0.08,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(201, 252, 248, 1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(Icons.settings)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: screenWidth * 0.3,
                                  child: const Text(
                                    "Setting",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(left: screenWidth * 0.37),
                                child: Icon(Icons.keyboard_arrow_right)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // Other widgets in the row
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () {
                                _showLogoutConfirmationDialog(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
