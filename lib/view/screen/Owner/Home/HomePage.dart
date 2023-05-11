import 'dart:ui';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/view/screen/Loging/Login.dart';
import 'package:bazralogin/Theme/verticalDash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../Model/driverCount.dart';
import '../../../../Model/ApiConfig.dart';
import '../../../../const/constant.dart';
import '../Driver/driversPage.dart';
import '../TripManagement/setGuzo.dart';
import '../Vehicle/vehicleStatus.dart';

import '../report/alertType.dart';
import '../report/singleReport.dart';

class OwenerHomepage extends StatefulWidget {
  int? index;
  OwenerHomepage({super.key, this.index});

  @override
  State<OwenerHomepage> createState() => _OwenerHomepageState();
}

class _OwenerHomepageState extends State<OwenerHomepage> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<String> items = [
    'English',
    'Amaharic',
    'Afaan Oromo',
  ];
  String? selectedItem = 'English';
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
      return TranslationUtil.text("Good morning");
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  double _padding = 6.0;
  String query = '';
  Future vehicleFetch() async {
    // fetch list of total vehicles
    await APIService.vehicleFetch();
  }

  Future driverFetch() async {
    // fetch list of total vehicles
    await APIService.driverFetch();
  }

  Future maintainingcarFetch() async {
    final maintainin = await APIService.maintainingCar();
  }

  Future parkedFetch() async {
    // fetch  parked car

    await APIService.parkedCar();
  }

  Future onrouteFetch() async {
    // fetch list of  car on route
    await APIService.onroutCar();
  }

  Future instockFetch() async {
    // fetch list of  car in stock
    await APIService.InStock();
  }

  Future Total_Drivers() async {
    final totalDrivers = await CountDrivers.TotalDrivers();
  }

  Future Unassigned() async {
    // fetch  parked car
    final Unassigned = await CountDrivers.UnASSIGNED();
  }

  Future Onroute() async {
    // fetch list of  car on route
    final assignedDrivers = await CountDrivers.ONROUTE();
  }

  Future Permit() async {
    // fetch list of  car in stock
    final assignedDrivers = await CountDrivers.PERMIT();
  }

  Future Assigned() async {
    // fetch list of  car in stock
    final assignedDrivers = await CountDrivers.AssignedDriver();
  }

  var locale;
  List languge = ['en_us', 'am_AM', 'a_OR'];
  @override
  void initState() {
    // TODO: implement initState
    Total_Drivers();
    Assigned();
    Unassigned();
    Onroute();
    Permit();
    maintainingcarFetch();
    parkedFetch();
    vehicleFetch();
    onrouteFetch();
    instockFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String tdata;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.07,
              margin: EdgeInsets.only(top: screenHeight * 0.055),
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SizedBox(
                          height: screenHeight * 0.08,
                          width: screenWidth * 0.1,
                          child: Image(
                              image: AssetImage(
                                  "assets/images/R-removebg-preview.png"))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.13,
                      height: screenHeight * 0.08,
                      margin: EdgeInsets.only(left: screenWidth * 0.26),
                      child: Icon(
                        Ionicons.notifications,
                        size: 28,
                        color: Color.fromRGBO(85, 164, 240, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),

                    gradient: LinearGradient(
                      colors: [
                        Colors.black26,
                        Color.fromRGBO(2, 72, 249, 1),
                      ],
                      // stops: [0.4, 0.4],
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  height: screenHeight * 0.23,
                  child: Column(children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.45,
                          child: Text(
                            " Good morning",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: screenWidth * 0.1),
                            child: Row(
                              children: [
                                Text(
                                  " Selem" + ",",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.37,
                                  child: Text(
                                    "Robel",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: screenWidth * 0.07),
                          child: SizedBox(
                            // width: screenWidth * 0.1,
                            // height: screenHeight * 0.06,
                            child: Container(
                              margin: EdgeInsets.only(right: 27, top: 0),
                              height: screenHeight * 0.075,
                              child: Image.asset(
                                "assets/images/profile.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.13, left: 30, right: 30),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth * 0.35,
                                margin: EdgeInsets.only(right: 30),
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: kPrimaryColor,

                                      child: Text(
                                        "280",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(11),
                                      minWidth: screenWidth * 0.06,
                                      //use this class Circleborder() for circle shape.
                                      shape: const CircleBorder(),
                                    ),
                                    Text(
                                      TranslationUtil.text('Driver'),
                                      style: GoogleFonts.montserrat(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.35,
                                child: Column(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: kPrimaryColor,

                                      child: Text(
                                        "280",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(11),
                                      minWidth: screenWidth * 0.06,
                                      //use this class Circleborder() for circle shape.
                                      shape: const CircleBorder(),
                                    ),
                                    Text(
                                      TranslationUtil.text("Vehicle"),
                                      style: GoogleFonts.montserrat(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Container(
            //   height: screenHeight * 0.05,
            //   decoration: BoxDecoration(
            //     color: kBackgroundColor,
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10)),
            //   ),
            // ),
            Flexible(
              child: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 20),

                // margin: EdgeInsets.only(top: 35),
                child: GridView(
                  padding: EdgeInsets.zero,
                  // ignore: sort_child_properties_last
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkResponse(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => communicate_screen()));
                        }),
                        child: Ink(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: isPressed
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
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
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,

                                    margin: EdgeInsets.only(top: 12),
                                    //height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      "assets/images/driver.png",
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(TranslationUtil.text("Driver"),
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
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
                                  builder: (context) => VehicleStatus()));
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isPressed
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
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
                                    : null),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  // height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: const Icon(
                                    MdiIcons.carBack,
                                    size: 50,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    TranslationUtil.text("Vehicle"),
                                    style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
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
                                  builder: (context) => reportPage()));
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
                                          color: Colors.grey.shade400,
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
                                    : null),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/profit-report.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    TranslationUtil.text("Report"),
                                    style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: (() {
                          // Navigator.push<void>(
                          //   context,
                          //   MaterialPageRoute<void>(
                          //       builder: (BuildContext context) =>
                          //           AvailableMarket()),
                          // );
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
                                          color: Colors.grey.shade400,
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
                                    : null),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/available.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    TranslationUtil.text("Available Market"),
                                    style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
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
                                  builder: (context) => tripHistory()));
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
                                          color: Colors.grey.shade400,
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
                                    : null),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    "assets/images/travel.png",
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    TranslationUtil.text('Trip management'),
                                    style: GoogleFonts.montserrat(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3),
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _current,
        count: 5,
      );
}
