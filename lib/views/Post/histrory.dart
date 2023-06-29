import 'dart:io';

import 'package:cargo/shared/constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../Components/Noglow.dart';
import '../../localization/app_localizations.dart';
import '../../model/cargo.dart';
import 'package:lottie/lottie.dart';
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

class CargoHistory extends StatefulWidget {
  String? plateNumber;
  final AppLocalizations? localizations;
  CargoHistory({Key? key, this.localizations}) : super(key: key);
  @override
  _CargoHistoryState createState() => _CargoHistoryState();
}

class _CargoHistoryState extends State {
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
    futureCargos = fetchCargos();
  }

  Future searchCargosByOwnerName(String status) async {
    try {
      List cargos = await fetchCargos();
      List filteredCargos = cargos
          .where((cargo) =>
              cargo.status.toLowerCase().contains(status.toLowerCase()))
          .toList();
      return filteredCargos;
    } catch (e) {
      throw Exception('Failed to search cargos by status');
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
    return SafeArea(
      child: Scaffold(
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
                    searchCargosByOwnerName(value).then((searchedCargos) {
                      setState(() {
                        // Wrap the assignment in a setState to refresh the Widget
                        _searchResults = searchedCargos;
                      });
                    }).catchError((error) {
                      print(error);
                    });
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
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: screenHeight,
                child: FutureBuilder(
                  future: searchCargosByOwnerName(searchController.text),
                  builder: (context, snapshot) {
                    if (_searchResults.isEmpty &&
                        searchController.text.isNotEmpty) {
                      if (searchController.text.length < 3 ||
                          searchController.text.contains('dummy')) {
                        Container(
                          height: double.infinity,
                          child: Center(
                            child: Lottie.asset(
                              'assets/images/noapidatas.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        // Display a message indicating that no results were found
                        Text(
                            'No results found for "${searchController.text}".');
                      }
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ScrollConfiguration(
                        behavior: NoGlowScrollBehavior(),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 300),
                          itemBuilder: (context, index) {
                            Cargo cargo = snapshot.data![index];
                            return ListTile(
                              title: Container(
                                height: screenHeight * 0.2,
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
                                                      width: screenWidth * 0.2,
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
                                                child: DottedLine(
                                                  lineThickness: 1.0,
                                                  dashLength: 4.0,
                                                  dashColor: Colors.grey,
                                                  dashGapRadius: 2.0,
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
                                                trailing: SizedBox(
                                                  width: screenWidth * 0.22,
                                                  child: Text(
                                                    cargo.status,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.bold,
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
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    return Center(
                      child: FutureBuilder(
                        future: Future.delayed(Duration(seconds: 10),
                            () => _checkInternetConnection()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.13,
                                width: screenWidth * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
              ),
            ),
          )),
    );
  }
}
