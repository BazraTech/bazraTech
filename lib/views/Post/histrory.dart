import 'dart:io';

import 'package:cargo/shared/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../model/cargo.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/storage_hepler.dart';
import '../Bottom_Navigation.dart';
import 'historyDetail.dart';

Future fetchCargos() async {
  try {
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Cargo/All/Cargos'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        });
    print(response);
    if (response.statusCode == 200) {
      List cargoJson = json.decode(response.body)['cargos'];
      return cargoJson.map((cargo) => Cargo.fromJson(cargo)).toList();
    } // Handle connection timeout error
  } on SocketException catch (_) {
    // Handle connection timeout error
    print('Connection timed out');
  } catch (error) {
    // Handle other errors

    print("error:$error");
  }
}

class CargoListView extends StatefulWidget {
  String? plateNumber;

  @override
  _CargoListViewState createState() => _CargoListViewState();
}

class _CargoListViewState extends State {
  Future? futureCargos;
  TextEditingController searchController = TextEditingController();
  List _searchResults = [];
  List _allCargos = [];

  bool _searching = false;

  @override
  void initState() {
    super.initState();
    fetchCargos().then((cargos) {
      setState(() {
        _allCargos = cargos;
      });
    });
  }

  void searchCargosByOwnerName(String status) async {
    try {
      List cargos = await fetchCargos();
      List filteredCargos = cargos
          .where((cargo) =>
              cargo.status.toLowerCase().contains(status.toLowerCase()))
          .toList();
      setState(() {
        _searchResults = filteredCargos;
      });
    } catch (e) {
      throw Exception('Failed to search cargos by owner name');
    }
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    // Determine which list of cargos to display
    List cargos = _searching ? _searchResults : _allCargos;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNav()));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth * 0.12),
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _searching = false;
                    });
                    return;
                  }
                  _searching = true;
                  searchCargosByOwnerName(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Status',
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        body: Center(
            child: Container(
          margin: EdgeInsets.only(top: 30),
          height: screenHeight,
          child: FutureBuilder(
            future: fetchCargos(), // Otherwise, fetch all cargos
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return cargos.isEmpty && _searching
                    // Display the message if no results were found and user is searching
                    ? Center(
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: screenHeight / 2),
                            width: screenWidth,
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 254, 250),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: isPressed
                                    ? [
                                        BoxShadow(
                                            color: Colors.grey.shade300
                                                .withOpacity(0.7),
                                            blurRadius: 18.0,
                                            spreadRadius: 12.0,
                                            offset: const Offset(
                                              6, // Move to right 7.0 horizontally
                                              -10, // Move to bottom 8.0 Vertically
                                            )),
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 8.0,
                                            spreadRadius: 6.0,
                                            offset: const Offset(
                                              6, // Move to right 7.0 horizontally
                                              -8, // Move to bottom 8.0 Vertically
                                            )),
                                      ]
                                    : null),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.search),
                                  Text(
                                    'No such history or data here',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )))
                    :
                    // Display the cargos list

                    Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searching
                              ? _searchResults.length
                              : _allCargos.length,
                          itemBuilder: (context, index) {
                            Cargo cargo = _searching
                                ? _searchResults[index]
                                : _allCargos[index];
                            return ListTile(
                              title: Container(
                                height: screenHeight * 0.22,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            cargoHistoryDetail(
                                                cargoId: cargo.id),
                                      ),
                                    );
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              cargoHistoryDetail(
                                                  cargoId: cargo.id),
                                        ),
                                      );
                                    },
                                    child: Card(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade200
                                                  .withOpacity(0.7),
                                              blurRadius: 8.0,
                                              spreadRadius: 2.0,
                                              offset: const Offset(
                                                6, // Move to right 7.0 horizontally
                                                8, // Move to bottom 8.0 Vertically
                                              ))
                                        ],
                                      ),
                                      height: screenHeight * 0.18,
                                      child: ListTile(
                                        title: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      cargo.pickUp,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 123, 129, 236),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: const Icon(
                                                        Icons.trip_origin,
                                                        size: 15,
                                                        color: Color.fromARGB(
                                                            255, 123, 129, 236),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenWidth * 0.15,
                                                      child: const Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          DottedLine(
                                                            lineThickness: 1.0,
                                                            dashLength: 4.0,
                                                            dashColor:
                                                                Colors.grey,
                                                            dashGapRadius: 2.0,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .local_shipping,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    123,
                                                                    129,
                                                                    236),
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 8),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    Text(
                                                      cargo.dropOff,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        cargo.date,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: Text(
                                                          cargo.date,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 15,
                                                ),
                                                child: const Expanded(
                                                  child: DottedLine(
                                                    lineThickness: 1.0,
                                                    dashLength: 4.0,
                                                    dashColor: Colors.grey,
                                                    dashGapRadius: 2.0,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  "Cargo Status",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey.shade500,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                trailing: Container(
                                                  width: 70,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color.fromARGB(
                                                        255, 252, 216, 214),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      cargo.status,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 255, 86, 74),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ),

                              // Add other cargo details as needed
                            );
                          },
                        ),
                      );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return Center(
                child: FutureBuilder(
                  future: Future.delayed(
                      Duration(seconds: 10), () => _checkInternetConnection()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.13,
                          width: screenWidth * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.7),
                                  blurRadius: 8.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(
                                    6, // Move to right 7.0 horizontally
                                    8, // Move to bottom 8.0 Vertically
                                  ))
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text('Network Error',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'No Network. Connect your device to internet or mobile data',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ));
                    }
                  },
                ),
              );
            },
          ),
        )));
  }
}
