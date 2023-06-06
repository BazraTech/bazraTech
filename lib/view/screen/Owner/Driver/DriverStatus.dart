import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../config/APIService.dart';
import 'OwnersDriver.dart';
import 'getDriverByStatus.dart';

class DriverStatus extends StatelessWidget {
  DriverStatus({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  String onroutedriver = "";
  String assign = "";
  String Parked = "";
  String permit = "";
  String Unassigned = "";
  String total = "";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: TabBarView(
          children: [
            OwnersDriver(),
            getDriversBystatus(driverStatus: 'ASSIGNED', driverList: 'drivers'),
            getDriversBystatus(
                driverStatus: 'UNASSIGNED', driverList: 'drivers'),
            getDriversBystatus(driverStatus: 'PERMIT', driverList: 'drivers'),
            getDriversBystatus(driverStatus: 'ONROUTE', driverList: 'drivers'),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              labelColor: kPrimaryColor,
              indicatorPadding: EdgeInsets.all(4),
              indicatorColor: Colors.white,
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }
                return Colors.transparent;
              }),
              tabs: [
                Tab(
                  text: TranslationUtil.text("Total Drivers"),
                  icon: Container(
                    child: FutureBuilder(
                      future: _totaldriver(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(total);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.03,
                            width: width * 0.04,
                            child: CircleAvatar(
                              backgroundColor: Colors.red[400],
                              radius: 10,
                              child: Text(
                                snapshot.data.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                    text: TranslationUtil.text("Assigned Drivers"),
                    icon: Container(
                      child: FutureBuilder(
                        future: _assignedDriver(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.04,
                              child: CircleAvatar(
                                backgroundColor: Colors.red[400],
                                radius: 8,
                                child: Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ));
                        },
                      ),
                    )),
                Tab(
                  text: TranslationUtil.text("UnAssigned Drivers"),
                  icon: Container(
                    child: FutureBuilder(
                      future: _driverUnassigned(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.03,
                            width: width * 0.04,
                            child: CircleAvatar(
                              backgroundColor: Colors.red[400],
                              radius: 8,
                              child: Text(
                                snapshot.data.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                    text: TranslationUtil.text("Permit"),
                    icon: Container(
                      child: FutureBuilder(
                        future: _permit(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.04,
                              child: CircleAvatar(
                                backgroundColor: Colors.red[400],
                                radius: 8,
                                child: Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ));
                        },
                      ),
                    )),
                Tab(
                    text: TranslationUtil.text("OnRoute Drivers"),
                    icon: Container(
                      child: FutureBuilder(
                        future: _onroutedriver(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.04,
                              child: CircleAvatar(
                                backgroundColor: Colors.red[400],
                                radius: 8,
                                child: Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ));
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _onroutedriver() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/ONROUTE"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "onroutedriver", value: data["totalDrivers"].toString());

      onroutedriver = (await storage.read(key: 'onroutedriver'))!;
      return onroutedriver;
    } else {
      throw Exception('Failed to load image');
    }
  }

// fetch total  vehicle onstock
  Future<String> _permit() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse("http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/PERMIT"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "permit", value: data["totalDrivers"].toString());

      permit = (await storage.read(key: 'permit'))!;
      return permit;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch vehicle on route
  Future<String> _assignedDriver() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/ASSIGNED"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "assign", value: data["totalDrivers"].toString());

      assign = (await storage.read(key: 'assign'))!;
      return assign;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on total driver
  Future<String> _totaldriver() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "total", value: data["totalDrivers"].toString());

      total = (await storage.read(key: 'total'))!;
      return total;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on park
  Future<String> _driverUnassigned() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://64.226.104.50:9090/Api/Vehicle/Owner/Drivers/UNASSIGNED"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "assigned", value: data["totalDrivers"].toString());

      Unassigned = (await storage.read(key: 'assigned'))!;
      return Unassigned;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
