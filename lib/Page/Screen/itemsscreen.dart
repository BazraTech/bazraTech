import 'package:bazralogin/Model/item.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.notification_add,
                color: Color.fromRGBO(0, 207, 253, 1),
              ),
            )
          ]),
      body: Container(
        color: const Color.fromRGBO(247, 250, 252, 1),
        height: MediaQuery.of(context).size.height,
        child: GridView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                          margin: EdgeInsets.only(top: 27),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            MdiIcons.carBack,
                            size: 70,
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
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                            child: SvgPicture.asset("assets/icons/driver.svg")),
                      ),
                      Container(
                        child: Text("Driver"),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                          child: SvgPicture.asset("assets/icons/road.svg"),
                        ),
                      ),
                      Text("On Route"),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                          child: Image.asset("assets/images/report.png"),
                        ),
                      ),
                      Text("Report"),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                          child: Image.asset("assets/images/market.png"),
                        ),
                      ),
                      Text("Aviable market"),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 100,
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
                          child: Image.asset("assets/images/time.png"),
                        ),
                      ),
                      Text("Trip manegement"),
                    ],
                  )),
            )
          ],
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            mainAxisExtent: 180,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
