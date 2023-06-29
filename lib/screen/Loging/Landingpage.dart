import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasInternetConnection = true;
  bool _isloading = true;

  @override
  void initState() {
    checkServerStatus();
    super.initState();
  }

  Future<void> checkServerStatus() async {
    await Future.delayed(Duration(seconds: 4));

    final isConnected = await InternetConnectionChecker().hasConnection;

    setState(() {
      hasInternetConnection = isConnected;
    });

    if (hasInternetConnection) {
      final response = await http.get(Uri.parse('http://64.226.104.50'));
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        setState(() {
          _isloading = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isloading
              ? SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(child: CircularProgressIndicator()))
              : Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/images/119965-404-error-in-space-astronaut.json', // Path to the Lottie animation file
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
