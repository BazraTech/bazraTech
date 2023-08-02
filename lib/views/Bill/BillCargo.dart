import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../../Components/Noglow.dart';
import '../../localization/app_localizations.dart';
import '../../model/bill.dart';
import '../../shared/loading.dart';
import '../../shared/networkError.dart';
import '../../shared/storage_hepler.dart';
import '../Bottom_Navigation.dart';
import 'billDetail.dart';

class CargoBill extends StatefulWidget {
  const CargoBill({super.key});

  @override
  State<CargoBill> createState() => _CargoBillState();
}

class _CargoBillState extends State<CargoBill> {
  Future? futureCargoDrivers;
  Future fetchCargos() async {
    try {
      StorageHelper storageHelper = StorageHelper();
      String? accessToken = await storageHelper.getToken();
      final response = await http.get(
          Uri.parse('http://164.90.174.113:9090/Api/Payment/CargOwner/Status'),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
            "Authorization": "Bearer $accessToken",
          });
      print(response);
      if (response.statusCode == 200) {
        List cargoJson = json.decode(response.body)['unPaidCargos'];
        return cargoJson.map((cargo) => Cargo_Bill.fromJson(cargo)).toList();
      } // Handle connection timeout error
      else {
        final message = json.decode(response.body)['error'];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      if (e is http.ClientException &&
          e.message.contains('Connection reset by peer')) {
        Fluttertoast.showToast(
          msg: "Connection reset by peer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        // Display an error message to the user or retry the operation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  const Text('Connection reset by peer. Please try again.'),
              actions: [
                ElevatedButton(
                  child: const Text('Retry'),
                  onPressed: () {
                    // Retry the operation
                    fetchCargos();
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      Alert(
        context: context,
        title: "Error",
        desc: "Failed to fetch data",
        type: AlertType.error,
      ).show();
      return [];
    }
  }

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
              color: Color.fromARGB(255, 162, 162, 162),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 252, 254, 250),
          title: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth * 0.12),
            height: 40,
            color: Color.fromARGB(255, 252, 254, 250),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                          ?.translate('Driver Name or Plate No.') ??
                      "Driver Name or Plate No.",
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: fetchCargos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ScrollConfiguration(
                  behavior: NoGlowScrollBehavior(),
                  child: ListView.builder(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 100),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Cargo_Bill bill = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Bill_Detail(cargoId: bill.id)));
                          },
                          child: Column(
                            children: [
                              Card(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
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
                                height: screenHeight * 0.2,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Column(children: [
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            bill.pickUp,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 123, 129, 236),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 8,
                                            ),
                                            child: const Icon(
                                              Icons.trip_origin,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 123, 129, 236),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.2,
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
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.location_on,
                                                size: 15,
                                                color: Colors.grey.shade300),
                                          ),
                                          Text(
                                            bill.dropOff,
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
                                        top: 20,
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
                                                ?.translate("Payment Status") ??
                                            "Payment Status",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade500,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Text(
                                        bill.payment,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.amber,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )),
                            ],
                          ),
                        );
                      }),
                );
              }
              return const NetWorkError();
            }));
  }
}
