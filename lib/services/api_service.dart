// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/error_handle.dart';
import '../constant/global_variables.dart';
import '../constant/utils.dart';
import "../shared/storage_hepler.dart";
import '../views/usermanagement/login.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String companyName,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    StorageHelper storageHelper = StorageHelper();
    try {
      final user = {
        'companyName': companyName,
        'phone': phone,
        'password': password,
        'confirmPassword': confirmPassword,
      };

      http.Response res = await http.post(
        Uri.parse('$uri/Api/SignUp/Cargo'),
        body: jsonEncode(user),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );
      print(res.body);
      print(res.statusCode);
      final Map jsonResponse = json.decode(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cargo_login()),
          );
        },
      );
    } catch (e) {
      print("Error occurred: $e"); // Display specific error message in console
      showSnackBar(context,
          "An error occurred: $e"); // Display specific error message in Snackbar
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String password,
    required String username,
  }) async {
    try {
      StorageHelper storageHelper = StorageHelper();
      final Map<String, dynamic> requestData = {
        "username": username,
        "password": password,
      };
      http.Response res = await http.post(
        Uri.parse('$uri/Api/SignIn/Cargo'),
        body: jsonEncode(requestData),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );
      print("Response: ${res.body}");
      // ignore: use_build_context_synchronously
      if (res.statusCode == 200) {
        // Successful response
        var jsonResponse = json.decode(res.body);
        //Get the token from the response
        String? newToken = jsonResponse['jwt'];
        var name = jsonResponse['user']['name'];
        var phoneNumber = jsonResponse['user']['PhoneNumber'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);
        await prefs.setString('phoneNumber', phoneNumber);
        // Save the token to storage
        if (newToken != null) {
          await storageHelper.setToken(newToken);
        }
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => BottomNav(),
              ),
            );
          },
        );
      } else {
        // Error response
        Map<String, dynamic> errorData = jsonDecode(res.body);
        String errorMessage = errorData["message"];
        showSnackBar(context, errorMessage);
      }
    } catch (e) {
      print("Error occurred: $e");
      String errorMessage = "An error occurred";

      if (e is SocketException) {
        errorMessage = "Network error occurred";
      } else if (e is TimeoutException) {
        errorMessage = "Request timed out";
      }
      showSnackBar(context, errorMessage);
    }
  }
}
