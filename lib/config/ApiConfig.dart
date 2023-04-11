import 'dart:convert';


import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/domian/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../Model/DriverResponse.dart';
import '../Model/loginRequestModel.dart';

class APIService {
  var client = http.Client();
  final storage = new FlutterSecureStorage();
  static String? ownername;
  static String? totalStockedVehicles;
  static String? totalVehicle;
  static String? totalDrivers;
  static String? totalMaintainingVehicles;
  static String? totalinRouteVehiclesVehicles;
  static String? totalparkedVehicle;
  // fetch list of car avilable
  static InStock() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            'http://198.199.67.201:9090/Api/Vehicle/Owner/Status/INSTOCK'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['stockedList'];
      await storage.write(
          key: "stockedVehicles",
          value: mapResponse["stockedVehicles"].toString());

      totalStockedVehicles = await storage.read(key: 'stockedVehicles');

      print(results);

      return results;
    } else {
      throw Exception('not loaded ');
    }
  }
  // fetch  parked car

  static parkedCar() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://198.199.67.201:9090/Api/Vehicle/Owner/Status/PARKED'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['parkedList'];
      await storage.write(
          key: "parkedVehicles",
          value: mapResponse["parkedVehicles"].toString());

      totalparkedVehicle = await storage.read(key: 'parkedVehicles');

      // print(results);

      return results;
    } else {
      throw Exception('not loaded ');
    }
  }

// fetch car onroute
  static onroutCar() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            'http://198.199.67.201:9090/Api/Vehicle/Owner/Status/ONROUTE'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['inRoutelist'];
      await storage.write(
          key: "inRouteVehicles",
          value: mapResponse["inRouteVehicles"].toString());

      totalinRouteVehiclesVehicles = await storage.read(key: 'inRouteVehicles');

      // print(results);

      return results;
    } else {
      throw Exception('not loaded ');
    }
  }

// fetch car on maintaining
  static maintainingCar() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            'http://198.199.67.201:9090/Api/Vehicle/Owner/Status/MAINTAINING'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['maintainingList'];
      await storage.write(
          key: "maintainingVehicles",
          value: mapResponse["maintainingVehicles"].toString());

      totalMaintainingVehicles = await storage.read(key: 'maintainingVehicles');

      // print(results);

      return results;
    } else {
      throw Exception('not loaded ');
    }
  }

  static vehicleFetch() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.vehicleApi);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      //  results= Vehicle.fromJson(mapResponse) as List<Vehicle>;

      var resultvehicle = mapResponse['vehiclesINF'];
      await storage.write(
          key: "totalVehicles", value: mapResponse["totalVehicles"].toString());

      totalVehicle = await storage.read(key: 'totalVehicles');
      print(mapResponse);

      return resultvehicle;
    } else {
      throw Exception('not loaded ');
    }
  }

  static tripOptions() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.tripOptions);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      //  results= Vehicle.fromJson(mapResponse) as List<Vehicle>;

      var resultvehicl = mapResponse['triptypes'];
      // await storage.write(
      //     key: "totalVehicles", value: mapResponse["totalVehicles"].toString());

      // totalVehicle = await storage.read(key: 'totalVehicles');
      print(mapResponse);

      return resultvehicl;
    } else {
      throw Exception('not loaded ');
    }
  }

  static driverFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(
            key: "totalDrivers", value: data["totalDrivers"].toString());

        totalDrivers = await storage.read(key: 'totalDrivers');
        var driverdata = data['drivers'];

        return driverdata;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<bool> loginFetch(
    LoginRequestModel model,
  ) async {
    final storage = new FlutterSecureStorage();
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.logIn);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      await storage.write(key: "jwt", value: data["jwt"]);

      ownername = data["user"]["role"][0];

      var value = await storage.read(key: 'jwt');

      print(ownername);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> Driver(LoginRequestModel model) async {
    final storage = new FlutterSecureStorage();
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.logIn);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      await storage.write(key: "jwt", value: data["jwt"]);
      await storage.write(key: "user", value: data["user"]["name"]);

      var value = await storage.read(key: 'jwt');
      ownername = await storage.read(key: 'user');

      return true;
    } else {
      return false;
    }
  }
}
