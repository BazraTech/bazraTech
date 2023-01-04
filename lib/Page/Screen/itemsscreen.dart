import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../../Route/route.dart';
import '../../const/constant.dart';
import '../customAppBar.dart';
import '../glow.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  double _padding = 6.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: CustomAppBar(
        height: 120,
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
              child: Container(
                margin: const EdgeInsets.only(top: 74, left: 300),
                padding: const EdgeInsets.all(2.0),
                child: const Icon(
                  Icons.notification_add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      //ScrollConfiguration to remove glow effect
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(20),
              )),
          height: MediaQuery.of(context).size.height,
          child: GridView(
            // ignore: sort_child_properties_last
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(AppRoutes.vehicle);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.car,
                              size: 68,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("Vehicle",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(AppRoutes.driversProfile);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.horseHuman,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("Driver",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.driversCommunicate);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.road,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("On Route",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(AppRoutes.carreport);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.progressCheck,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("Report",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(AppRoutes.report);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.car,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("Available Market",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.of(context).pushNamed(AppRoutes.tripmanage);
                  }),
                  child: AnimatedContainer(
                      //padding: EdgeInsets.only(bottom: _padding),
                      duration: Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 248, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isPressed
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
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
                            margin: EdgeInsets.only(top: 27),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: const Icon(
                              MdiIcons.car,
                              size: 70,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: const Text("Trip Managemet",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),
                          ),
                        ],
                      )),
                ),
              ),
            ],
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 3.7 / 4,
              maxCrossAxisExtent: 250,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
