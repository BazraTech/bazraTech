import 'dart:ui';

import 'package:bazralogin/Page/Loging/Login.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Theme/clippbox.dart';
import '../../../../Theme/verticalDash.dart';
import '../../../../const/constant.dart';
import '../../Localization/Localization.dart';
import 'create_alert.dart';

class Driver_Hompage extends StatefulWidget {
  const Driver_Hompage({
    super.key,
  });

  @override
  State<Driver_Hompage> createState() => _Driver_HompageState();
}

class _Driver_HompageState extends State<Driver_Hompage> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;

  String? phoneNumber;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  int _current = 0;
  SharedPreferences? localStorage;
  //String? phoneNumber;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  List<String> items = [
    'English',
    'Amaharic',
    'Afaan Oromo',
  ];
  String? selectedItem = 'English';
  double _padding = 6.0;
  var locale;
  List languge = ['en_us', 'am_AM', 'a_OR'];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String tdata;
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 210, top: 3),
                child: GestureDetector(
                  onTap: (() {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AlertType()));
                  }),
                  child: const Icon(
                    Icons.notifications,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          hintText: 'Where To?',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                          border: InputBorder.none),
                      value: selectedItem,
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              )))
                          .toList(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter  Plate Number';
                        }
                      },
                      onChanged: (item) {
                        setState(() {
                          selectedItem = item;
                          if (item == 'English') {
                            locale = '${languge[0]}';
                          } else if (item == 'Amaharic') {
                            locale = '${languge[1]}';
                          } else {
                            locale = '${languge[2]}';
                          }

                          final translationController =
                              Get.put(TranslationController());
                          translationController.loadTranslations(locale);
                          Get.updateLocale(Locale(locale));
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        //ScrollConfiguration to remove glow effect
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade100,
                      Color.fromRGBO(114, 82, 246, 1),
                    ],
                    // stops: [0.4, 0.4],
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(8.0),
                height: screenHeight * 0.25,
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        "Today's Schedule",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10, top: 9),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trip_origin,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Text(
                                  "From   \n Addis Abeba",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.08),
                        child: SizedBox(
                          width: screenWidth * 0.22,
                          child: Text(
                            "Start date   \n12/2/2022",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 25,
                      margin: EdgeInsets.only(right: screenWidth * 0.7, top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                            child: CustomPaint(
                              painter: DashedLineVerticalPainter(),
                              size: Size(
                                1.5,
                                double.infinity,
                              ),
                            ),
                          ),
                        ],
                      )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Text(
                                  "To \n Djibuti",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.07),
                        child: SizedBox(
                          width: screenWidth * 0.22,
                          child: Text(
                            "End date   \n12/3/2022",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 35),
                  child: GridView(
                    // ignore: sort_child_properties_last
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkResponse(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAlert()));
                          }),
                          child: Ink(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: Offset(4, 4),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(-2, -2),
                                              blurRadius: 20,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      margin: EdgeInsets.only(top: 12),
                                      //height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Icon(
                                        Icons.calendar_month,
                                        size: 35,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                          TranslationUtil.text(
                                              "Available Market"),
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAlert()));
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-2, -2),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Icons.av_timer,
                                      size: 35,
                                      color: Colors.yellow[500],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: Text("Trip Delay",
                                        style: TextStyle(
                                            color: Colors.yellow[500],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAlert()));
                          },
                          child: AnimatedContainer(
                              //padding: EdgeInsets.only(bottom: _padding),
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-2, -2),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Icons.insert_drive_file_rounded,
                                      size: 35,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(TranslationUtil.text("Report"),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAlert()));
                          }),
                          child: AnimatedContainer(
                              //padding: EdgeInsets.only(bottom: _padding),
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade600,
                                            offset: Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-2, -2),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    margin: EdgeInsets.only(top: 12),
                                    //height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/images/available.png",
                                      color: Colors.green,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: const Text("Available Market",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAlert()));
                          }),
                          child: AnimatedContainer(
                              //padding: EdgeInsets.only(bottom: _padding),
                              duration: Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            offset: Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-2, -2),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      Ionicons.alert,
                                      size: 35,
                                      color: Colors.red[500],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                        TranslationUtil.text("Create Alert"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[500],
                                            fontSize: 13)),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: screenHeight / (screenWidth * 1.2),
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _current,
        count: 5,
      );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.4);

    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.75, size.height * 0.2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
