import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shadows/shadows.dart';

class Category extends StatefulWidget {
  static const routeName = '/Feeds';

  @override
  State<Category> createState() => _CategoryState();
}

bool isPressed = false;

final innerShadow = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.circular(1),
  color: Color.fromRGBO(220, 220, 220, 0.9),
  boxShadow: [
    BoxShadow(
        blurRadius: 1,
        offset: Offset(0, 3),
        spreadRadius: 2,
        color: Colors.black)
  ],
);
final outerShadow = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.circular(1),
  color: Color.fromRGBO(220, 220, 220, 0.9),
  boxShadow: [
    BoxShadow(
        blurRadius: 1,
        offset: Offset(0, 3),
        spreadRadius: 2,
        color: Colors.black)
  ],
);

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(77, 129, 212, 0.9),
          appBar: AppBar(
              backgroundColor: Color.fromRGBO(77, 129, 212, 0.9),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Center(
                child: const Text(
                  "  Wel-come yared ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              // shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(
              //   bottom: Radius.circular(30),
              // )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.notification_add,
                    color: Colors.white,
                  ),
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(220, 220, 220, 0.9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: const Color.fromRGBO(220, 220, 220, 0.9),
                        // margin: EdgeInsets.only(top: 12),
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            child: GridView(
                              // ignore: sort_child_properties_last
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPressed = !isPressed;
                                      });
                                    },
                                    child: AnimatedContainer(
                                        constraints: const BoxConstraints(
                                          minHeight: 60,
                                          maxHeight: 60,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          // boxShadow: [
                                          //   isPressed
                                          //       ? BoxShadow(
                                          //           blurRadius: 15,
                                          //           spreadRadius: 1,
                                          //           offset: Offset(4, 4),
                                          //           color: Colors.grey[500]!,
                                          //         )
                                          //       : BoxShadow(
                                          //           spreadRadius: 1,
                                          //           blurRadius: 15,
                                          //           offset: Offset(-4, -4),
                                          //           color: Colors.grey[500]!,
                                          //         )
                                          // ],
                                          color: Colors.white,
                                        ),
                                        duration:
                                            const Duration(milliseconds: 150),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 115,
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(22),
                                                //   boxShadow: [
                                                //     BoxShadow(
                                                //         blurRadius: 1,
                                                //         offset: Offset(0, 1))
                                                //   ],
                                                //   color: Colors.white,
                                                // ),
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(22),
                                                //   // boxShadow: [
                                                //   //   BoxShadow(
                                                //   //     blurRadius: 1,
                                                //   //     offset: Offset(0, 2),
                                                //   //     color: Colors.black,
                                                //   //   ),
                                                //   //   BoxShadow(
                                                //   //       blurRadius: 1,
                                                //   //       offset: Offset(0, 2),
                                                //   //       color: Colors.black)
                                                //   // ],
                                                // ),
                                                // // color: Color.fromRGBO(217, 217, 217, 1),
                                                margin: EdgeInsets.only(
                                                    top: 33,
                                                    left: 33,
                                                    right: 33),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      "assets/images/carimages.png"),
                                                  onPressed: () {},
                                                )),
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text("vechicle"),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                AnimatedContainer(
                                    constraints: BoxConstraints(
                                      minHeight: 60,
                                      maxHeight: 60,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      // boxShadow: [
                                      //   isPressed
                                      //       ? BoxShadow(
                                      //           blurRadius: 15,
                                      //           spreadRadius: 1,
                                      //           offset: Offset(4, 4),
                                      //           color: Colors.grey[500]!,
                                      //         )
                                      //       : BoxShadow(
                                      //           spreadRadius: 1,
                                      //           blurRadius: 15,
                                      //           offset: Offset(-4, -4),
                                      //           color: Colors.grey[500]!,
                                      //         )
                                      // ],
                                      color: Colors.white,
                                    ),
                                    duration: const Duration(milliseconds: 150),
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 33, left: 33, right: 33),
                                            // color: Color.fromRGBO(217, 217, 217, 1),
                                            height: 115,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Container(
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25.0),
                                                child: Image.asset(
                                                    "assets/images/driverman.png"),
                                              ),
                                            )),
                                        Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text("Driver"),
                                          ),
                                        )
                                      ],
                                    )),

                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                                //   child: Container(
                                //       constraints: BoxConstraints(
                                //         minHeight: 60,
                                //         maxHeight: 60,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(22),
                                //         color: Color.fromRGBO(217, 217, 217, 1),
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(14),
                                //             child: Container(
                                //               margin: EdgeInsets.only(top: 27),
                                //               height: 70,
                                //               width: MediaQuery.of(context).size.width,
                                //               child: SvgPicture.asset(
                                //                   "assets/icons/road.svg"),
                                //             ),
                                //           ),
                                //           Text("On Route"),
                                //         ],
                                //       )),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.carreport);
                                  },
                                  child: AnimatedContainer(
                                      constraints: BoxConstraints(
                                        minHeight: 60,
                                        maxHeight: 60,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        color: Colors.white,
                                        // boxShadow: [
                                        //   isPressed
                                        //       ? BoxShadow(
                                        //           blurRadius: 15,
                                        //           spreadRadius: 1,
                                        //           offset: Offset(4, 4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        //       : BoxShadow(
                                        //           spreadRadius: 1,
                                        //           blurRadius: 15,
                                        //           offset: Offset(-4, -4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        // ],
                                      ),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                // color:
                                                //     Color.fromRGBO(217, 217, 217, 1),
                                                margin: EdgeInsets.only(
                                                    top: 33,
                                                    left: 33,
                                                    right: 33),
                                                height: 115,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/report.png"),
                                                    onPressed: (() {}),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: Text("Report"),
                                          ),
                                        ],
                                      )),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.market);
                                  },
                                  child: AnimatedContainer(
                                      constraints: BoxConstraints(
                                        minHeight: 60,
                                        maxHeight: 60,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        // boxShadow: [
                                        //   isPressed
                                        //       ? BoxShadow(
                                        //           blurRadius: 15,
                                        //           spreadRadius: 1,
                                        //           offset: Offset(4, 4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        //       : BoxShadow(
                                        //           spreadRadius: 1,
                                        //           blurRadius: 15,
                                        //           offset: Offset(-4, -4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        // ],
                                        color: Colors.white,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 150),
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: Color.fromRGBO(217, 217, 217, 1),
                                            height: 115,
                                            margin: EdgeInsets.only(
                                                top: 33, left: 33, right: 33),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Image.asset(
                                                "assets/images/market.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text("Aviable market"),
                                          ),
                                        ],
                                      )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: AnimatedContainer(
                                      constraints: BoxConstraints(
                                        minHeight: 60,
                                        maxHeight: 60,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        // boxShadow: [
                                        //   isPressed
                                        //       ? BoxShadow(
                                        //           blurRadius: 15,
                                        //           spreadRadius: 1,
                                        //           offset: Offset(4, 4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        //       : BoxShadow(
                                        //           spreadRadius: 1,
                                        //           blurRadius: 15,
                                        //           offset: Offset(-4, -4),
                                        //           color: Colors.grey[500]!,
                                        //         )
                                        // ],
                                        color: Colors.white,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 150),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, AppRoutes.trippage);
                                            },
                                            child: Container(
                                              // color: Color.fromRGBO(217, 217, 217, 1),
                                              margin: EdgeInsets.only(
                                                  top: 33, left: 33, right: 33),
                                              height: 115,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Image.asset(
                                                    "assets/images/trip.png"),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: Text("Trip manegement"),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: 3.5 / 4,
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
