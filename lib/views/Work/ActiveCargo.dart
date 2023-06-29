import 'dart:io';

import 'package:cargo/ActiveWork.dart';
import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/shared/storage_hepler.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../Components/Noglow.dart';
import '../../localization/app_localizations.dart';
import '../../model/cargo.dart';
import '../../shared/constant.dart';

class ActiveCargo extends StatefulWidget {
  final AppLocalizations? localizations;
  final int? id;
  @override
  const ActiveCargo({Key? key, this.localizations, this.id}) : super(key: key);

  @override
  _ActiveCargoState createState() => _ActiveCargoState();
}

class _ActiveCargoState extends State<ActiveCargo> {
  Future? futureCargoDrivers;
  List activeCargoStatus = [];
  List _searchResults = [];
  List _allCargos = [];

  bool _searching = false;
  Future fetchActiveCargos() async {
    try {
      StorageHelper storageHelper = StorageHelper();
      String? accessToken = await storageHelper.getToken();
      final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Cargo/All/Cargos'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        },
      );
      print(response);
      if (response.statusCode == 200) {
        List cargoJson = json.decode(response.body)['cargos'];
        List<Cargo> activeCargos = cargoJson
            .map((cargo) => Cargo.fromJson(cargo))
            .where((cargo) => cargo.status == 'ACCEPTED')
            .toList();
        return activeCargos;
      } else {
        Alert(
          context: context,
          title: "Error",
          desc: "Server error",
          type: AlertType.error,
        ).show();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CargoOWnerHomePage()),
        );
        return [];
      }
    } catch (e) {
      print('Error in fetchActiveCargos(): $e');
      Alert(
        context: context,
        title: "Error",
        desc: "Failed to fetch data",
        type: AlertType.error,
      ).show();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CargoOWnerHomePage()),
      );
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchActiveCargos().then((cargos) {
      setState(() {
        _allCargos = cargos;
      });
    });
  }

  TextEditingController searchController = TextEditingController();
  Future searchCargosByOwnerName(String status) async {
    try {
      List cargos = await fetchActiveCargos();
      List filteredCargos = cargos
          .where((cargo) =>
              cargo.dropOff.toLowerCase().contains(status.toLowerCase()))
          .toList();
      return filteredCargos;
    } catch (e) {
      throw Exception('Failed to search cargos by destination');
    }
  }

  bool isExpanded = false;
  List _data = [];
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 162, 162, 162),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 252, 254, 250),
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: screenWidth * 0.12),
          height: 40,
          color: Color.fromARGB(255, 252, 254, 250),
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
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)?.translate('Destination') ??
                        "Destination",
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
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: FutureBuilder(
          future: searchCargosByOwnerName(searchController.text),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 100),
                  itemBuilder: (context, index) {
                    Cargo driver = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        height: screenHeight * 0.2,
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VehicleCargo(id: driver.id)));
                          }),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.grey.shade200.withOpacity(0.7),
                                      blurRadius: 8.0,
                                      spreadRadius: 2.0,
                                      offset: const Offset(
                                        6, // Move to right 7.0 horizontally
                                        8, // Move to bottom 8.0 Vertically
                                      ))
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          driver.pickUp,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 123, 129, 236),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
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
                                            alignment: Alignment.center,
                                            children: [
                                              DottedLine(
                                                lineThickness: 1.0,
                                                dashLength: 4.0,
                                                dashColor: Colors.grey,
                                                dashGapRadius: 2.0,
                                              ),
                                              Icon(
                                                Icons.local_shipping,
                                                color: Color.fromARGB(
                                                    255, 123, 129, 236),
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Icon(Icons.location_on,
                                              size: 15,
                                              color: Colors.grey.shade300),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .translate(driver.dropOff) ??
                                              driver.dropOff,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: const DottedLine(
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Colors.grey,
                                      dashGapRadius: 2.0,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context)
                                              ?.translate("Cargo Status") ??
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
                                        driver.status,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.amber,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
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
      ),
    );
  }
}
