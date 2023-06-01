import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared/ImageHelper.dart';
import '../shared/constant.dart';
import '../shared/storage_hepler.dart';
import '../shared/tapbar.dart';
import '../views/Bill/Bill.dart';
import '../views/Notification/Notification.dart';
import '../views/Report/Report.dart';
import '../views/Work/Acticve_Work.dart';

class CargoOWnerHomePage extends StatefulWidget {
  int? index;
  CargoOWnerHomePage({super.key, this.index});

  @override
  State<CargoOWnerHomePage> createState() => _CargoOWnerHomePageState();
}

class _CargoOWnerHomePageState extends State<CargoOWnerHomePage> {
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
  // Future<String> fetchImage() async {
  //   var client = http.Client();
  //   StorageHelper storageHelper = StorageHelper();
  //   String? accessToken = await storageHelper.getToken();

  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $accessToken',
  //   };
  //   final response = await http.get(
  //       Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
  //       headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the JSON.
  //     Map<String, dynamic> data = json.decode(response.body);
  //     return data["logo"];
  //   } else {
  //     throw Exception('Failed to load image');
  //   }
  // }

  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 247, 249),
        body: Column(
          children: [
            Container(
              height: screenHeight * 0.07,
              margin: EdgeInsets.only(top: screenHeight * 0.055),
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(top: 15),
                  //   padding: const EdgeInsets.all(2.0),
                  //   child: CircleAvatar(
                  //     radius: 50,
                  //     backgroundColor: Colors.white,
                  //     child: ClipOval(
                  //       child: FutureBuilder(
                  //         future: fetchImage(),
                  //         builder: (BuildContext context,
                  //             AsyncSnapshot<String> snapshot) {
                  //           if (snapshot.connectionState !=
                  //               ConnectionState.done) return Text("");
                  //           return Image.network(
                  //             snapshot.data.toString(),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth * 0.13,
                      height: screenHeight * 0.08,
                      margin: EdgeInsets.only(left: screenWidth * 0.26),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Notifications()),
                          );
                        },
                        child: const Icon(
                          Icons.notifications,
                          size: 28,
                          color: Color.fromRGBO(85, 164, 240, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black26,
                        Color.fromRGBO(250, 164, 246, 0.7),
                      ],
                      //stops: [0.4, 0.4],
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  height: screenHeight * 0.23,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              greeting(),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: const Text(
                              "Robel",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.12, left: 20, right: 20),
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            child: SizedBox(
                                height: screenHeight * 0.12,
                                child: Icon(Icons.local_shipping_rounded,
                                    size: 70, color: kPrimaryColor)),
                          ),
                          Positioned(
                              top: 72,
                              bottom: 8,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0, left: 5),
                                    width: screenWidth * 0.25,
                                    child: const Expanded(
                                      child: DottedLine(
                                        direction: Axis.horizontal,
                                        lineThickness: 3.0,
                                        dashLength: 18.0,
                                        dashColor: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 5),
                                    width: screenWidth * 0.25,
                                    child: const Expanded(
                                      child: DottedLine(
                                        direction: Axis.horizontal,
                                        lineThickness: 3.0,
                                        dashLength: 18.0,
                                        dashColor: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              child: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 20),
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
                                  builder: (context) => Active_Work()));
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
                                    child: const Icon(
                                      Icons.work,
                                      size: 50,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: const Text("Active Work",
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
                                  builder: (context) => BillStatus()));
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
                                    Icons.attach_money_rounded,
                                    size: 50,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: const Text(
                                    "Bill",
                                    style: TextStyle(
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
                                  builder: (context) => TabNavigate()));
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 12),
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: const Icon(
                                    Icons.local_shipping,
                                    size: 50,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: const Text(
                                    "Post Cargo Work",
                                    style: TextStyle(
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
                                  builder: (context) => Report()));
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
                                  child: const Icon(
                                    Icons.insert_chart_outlined_rounded,
                                    color: kPrimaryColor,
                                    size: 50,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: const Text(
                                    'Report',
                                    style: TextStyle(
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
                        (MediaQuery.of(context).size.height / 2.8),
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
