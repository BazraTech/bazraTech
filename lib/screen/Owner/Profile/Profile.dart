import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/screen/Owner/Profile/profileEdit/updateOwnerprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../../controller/apiController.dart';
import '../../Loging/changePassword.dart';
import '../../../../const/constant.dart';
import '../Driver/assignDriver.dart';
import 'profileEdit/languageOptions.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Map<String, dynamic>? Result;
String? driverstate;

String? namedriver;
bool _isLoading = true;

class _ProfileState extends State<Profile> {
  String ownerpic = "";
  DateTime? currentBackPressTime;
  bool _isLoading = true;
  Map<String, dynamic>? Result;
  Map<String, dynamic>? findVehicle;
  String? ownername;
  String? ownerphone;
  String? owneremail;

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

// fetch owner info
  ownerinfo() async {
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response =
        await http.get(Uri.parse(ApIConfig.ownerInfo), headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      Map<String, dynamic> results = mapResponse['ownerINF'];

      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    } else {
      throw Exception('not loaded ');
    }
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        // Show a Snackbar at the bottom indicating to press back again to exit

        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true; // Stop the default back button event
      }
    } else {
      Navigator.pop(context); // Navigate back to the home page
      return true; // Stop the default back button event
    }
  }

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

    ownerinfo();
  }

  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TranslationController controller = Get.put(TranslationController());
    final ApiController _apiController = Get.put(ApiController());

    print(_apiController.data);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 28),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ownerprofileUpadate(
                                      image: "${ownerpic}",
                                      email: Result!['email'].toString(),
                                      phone: ownerphone,
                                      datebirth: "12/4/000",
                                      name: ownername,
                                      gender: "Male",
                                      woreda: Result!["woreda"],
                                      houseNumber: Result!["houseNum"],
                                      notificationmedia:
                                          Result!["notificationMedium"],
                                    )));
                      },
                      icon: Icon(
                        Ionicons.pencil,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: FutureBuilder(
                          future: _fetchLogo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text("");
                            return Container(
                              height: screenHeight * 0.09,
                              width: screenWidth * 0.18,
                              child: ClipOval(
                                child: Container(
                                  child: SizedBox(
                                      height: screenHeight * 0.06,
                                      width: screenWidth * 0.05,
                                      child: Image.network(
                                          snapshot.data.toString())),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ownername == null
                              ? Container()
                              : Text(ownername.toString())
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.28,
                width: screenWidth,
                child: Column(children: [
                  SizedBox(
                      height: screenHeight * 0.28,
                      child: _isLoading
                          ? Container()
                          : Container(
                              height: screenHeight * 0.23,
                              child: ListView.builder(
                                itemCount: 1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.2,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.03),
                                                    width: screenWidth * 0.2,
                                                    child: Text(
                                                      TranslationUtil.text(
                                                          "Email"),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: Result!['email'] ==
                                                              null
                                                          ? Container()
                                                          : Text(
                                                              Result!['email']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                    ),
                                                    Icon(
                                                      Ionicons
                                                          .chevron_forward_outline,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.3,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      TranslationUtil.text(
                                                          "Date of Birth"),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: Text(
                                                        "2022-12-2",
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                    Container(
                                                        child: Icon(Ionicons
                                                            .chevron_forward_outline))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.2,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      TranslationUtil.text(
                                                        "Gender",
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 20),
                                                        child: Center(
                                                            child: Text(
                                                          "Male",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: AppFonts
                                                                  .smallFontSize,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ))),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                        child: Icon(Ionicons
                                                            .chevron_forward_outline))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )

                      // child: _isLoading
                      //     ? Container()
                      //     : ListView.builder(
                      //         itemCount: 1,
                      //         padding: EdgeInsets.zero,
                      //         itemBuilder: (context, index) {
                      //           return
                      //         },
                      //       ),
                      ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => languageOption()));
                },
                child: Container(
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: screenWidth * 0.08,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(252, 221, 244, 1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Icon(Icons.language_sharp)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: screenWidth -
                                      (screenWidth * 0.08 +
                                          screenWidth * 0.03 +
                                          76),
                                  child: Text(
                                    TranslationUtil.text("Language"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: AppFonts.smallFontSize,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                            Container(
                                child: Icon(Ionicons.chevron_forward_outline)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.3,
                width: screenWidth,
                child: Column(
                  children: [
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
                              child: Icon(Icons.lock_outline)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth -
                                    (screenWidth * 0.08 +
                                        screenWidth * 0.03 +
                                        76),
                                child: Text(
                                  TranslationUtil.text('Change password'),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: AppFonts.smallFontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChangePassword()),
                                      );
                                    },
                                    child: Icon(
                                        Ionicons.chevron_forward_outline))),
                          ),
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
                                  color: Color.fromRGBO(255, 245, 210, 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(Ionicons.help)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth -
                                    (screenWidth * 0.08 +
                                        screenWidth * 0.03 +
                                        76),
                                child: Text(
                                  TranslationUtil.text("Help"),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: AppFonts.smallFontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: Icon(Ionicons.chevron_forward_outline)),
                          ),
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
                              child: Icon(Ionicons.settings)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth -
                                    (screenWidth * 0.08 +
                                        screenWidth * 0.03 +
                                        76),
                                child: Text(
                                  TranslationUtil.text("Setting"),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: AppFonts.smallFontSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: Icon(Ionicons.chevron_forward_outline)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
