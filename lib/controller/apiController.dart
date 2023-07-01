import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/APIService.dart';
class ApiController extends GetxController {
  List<dynamic> dataList = [];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
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

    if (response.statusCode == 200) {
      // Parse the response body and store the
      var data = json.decode(response.body);
      dataList = data['drivers'];
      update();
    }
  }
}

// fetch vehicle
class ApiControllerforvehicle extends GetxController {
  List<dynamic> dataList = [];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(Uri.parse(ApIConfig.allvehicle),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      // Parse the response body and store the
      var data = json.decode(response.body);
      dataList = data['vehiclesINF'];
      update();
    }
  }
}
