import 'dart:convert';
import 'package:bazralogin/Model/Loginmodel.dart';
import 'package:http/http.dart' as http;

class Loginapiservice {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://198.199.67.201:9090/Api/SignIn/Admin";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson(), headers: {
      // "Content-Type": "application/json",
      // "Accept": "application/json",
      "Authorization": "token",
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
