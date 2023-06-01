import 'package:cargo/shared/constant.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../model/cargo.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/storage_hepler.dart';
import 'historyDetail.dart';

Future fetchCargos() async {
  StorageHelper storageHelper = StorageHelper();
  String? accessToken = await storageHelper.getToken();
  final response = await http.get(
      Uri.parse('http://64.226.104.50:9090/Api/Cargo/All/Cargos'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization": "Bearer $accessToken",
      });

  if (response.statusCode == 200) {
    List cargoJson = json.decode(response.body)['cargos'];
    return cargoJson.map((cargo) => Cargo.fromJson(cargo)).toList();
  } else {
    throw Exception('Failed to load cargos');
  }
}

class CargoListView extends StatefulWidget {
  String? plateNumber;
  @override
  _CargoListViewState createState() => _CargoListViewState();
}

class _CargoListViewState extends State {
  Future? futureCargos;

  @override
  void initState() {
    super.initState();
    futureCargos = fetchCargos();
  }

  bool? _isConnectd;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            height: screenHeight,
            child: FutureBuilder(
              future: futureCargos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Cargo cargo = snapshot.data![index];
                      return ListTile(
                        title: Container(
                          height: screenHeight * 0.25,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      cargoHistoryDetail(cargoId: cargo.id),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300
                                            .withOpacity(0.7),
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                        offset: const Offset(
                                          6, // Move to right 7.0 horizontally
                                          8, // Move to bottom 8.0 Vertically
                                        ))
                                  ],
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Trip start icon

                                            Row(
                                              children: [
                                                const Icon(Icons.trip_origin,
                                                    size: 20,
                                                    color: Colors.blue),
                                                Container(
                                                    width: screenWidth * 0.3,
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: ListTile(
                                                      title: Text(
                                                        cargo.pickUp,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                        cargo.date,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Icon(Icons.attach_money,
                                                    size: 20,
                                                    color: Colors.blue),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      cargo.price,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      // Dotted line

                                      Row(
                                        children: [
                                          Container(
                                            height: screenHeight * 0.1,
                                            child: const Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                DottedLine(
                                                  lineThickness: 1.0,
                                                  direction: Axis.vertical,
                                                  dashLength: 4.0,
                                                  dashColor: Colors.grey,
                                                  dashGapRadius: 2.0,
                                                ),
                                                Icon(
                                                  Icons.local_shipping,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: const Text(
                                                "30 Km",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black54,
                                                    fontFamily: 'Roboto',
                                                    letterSpacing: 1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),

                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Trip start icon

                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    size: 20,
                                                    color: Colors.blue),
                                                Container(
                                                    width: screenWidth * 0.3,
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: ListTile(
                                                      title: Text(
                                                        cargo.dropOff,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                        cargo.date,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )),
                                              ],
                                            ),

                                            Column(
                                              children: [
                                                Icon(Icons.local_shipping,
                                                    size: 20,
                                                    color: Colors.grey),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      cargo.weight,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Add other cargo details as needed
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
