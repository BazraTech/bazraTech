import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/APIService.dart';
import '../screen/Owner/Driver/assignDriver.dart';

class ApiController extends GetxController {
  // Define an observable variable to hold the fetched data
  var data = <String, dynamic>{}.obs;

  // Fetch data from the API
  fetchData() async {
    try {
      var token = await storage.read(key: 'jwt');
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
          Uri.parse("http://64.226.104.50:9090/Api/Vehicle/Owner/Info"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body) as Map<String, dynamic>;
        Map<String, dynamic> results = mapResponse["ownerINF"];
        print("yes");
        print(results);
        data.value = results;
        return results;
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Failed to fetch data: $e');
    }
  }
}

//fetch driver info
class ApiControllerfordriver extends GetxController {
  // Define an observable variable to hold the fetched data
  var data = <String, dynamic>{}.obs;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String? drivername;
  // Fetch data from the API

}
