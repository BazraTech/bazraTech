import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  static const routeName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 250, 252, 1),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                "  Wel-come yared ",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.notification_add,
                  color: Color.fromRGBO(0, 207, 253, 1),
                ),
              )
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color.fromRGBO(247, 250, 252, 1),
                height: MediaQuery.of(context).size.height,
                child: Container(
                  child: GridView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: Icon(
                                      MdiIcons.carBack,
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text("vechicle"),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                      height: 70,
                                      margin: EdgeInsets.only(top: 27),
                                      width: MediaQuery.of(context).size.width,
                                      child: SvgPicture.asset(
                                          "assets/icons/driver.svg")),
                                ),
                                Container(
                                  child: Text("Driver"),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 27),
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child: SvgPicture.asset(
                                        "assets/icons/road.svg"),
                                  ),
                                ),
                                Text("On Route"),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.report);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 27),
                                      height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                          "assets/images/report.png"),
                                    ),
                                  ),
                                ),
                                Text("Report"),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    height: 70,
                                    margin: EdgeInsets.only(top: 27),
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                        Image.asset("assets/images/market.png"),
                                  ),
                                ),
                                Text("Aviable market"),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                        child: Container(
                            constraints: BoxConstraints(
                              minHeight: 60,
                              maxHeight: 60,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 27),
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                        Image.asset("assets/images/time.png"),
                                  ),
                                ),
                                Text("Trip manegement"),
                              ],
                            )),
                      )
                    ],
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 3.5 / 4,
                      maxCrossAxisExtent: 220,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
