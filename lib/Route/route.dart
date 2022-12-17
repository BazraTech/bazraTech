import 'package:bazralogin/Bottom/Bottom.dart';

import 'package:bazralogin/Page/Loging/Login.dart';
import 'package:bazralogin/Page/Register/Signup.dart';
import 'package:bazralogin/Page/Screen/Tracking.dart';
import 'package:bazralogin/Page/Screen/carinfodisplayonMap.dart';
import 'package:bazralogin/Page/Screen/Search.dart';

import 'package:bazralogin/main.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String home = '/auth-home';
  static const String bottom = '/auth-bottom';
  static const String mapTracking = '/auth-tracking';
  static const String mapSearch = '/auth-search';
  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => const Login(),
      authRegister: (context) => const RegistrationForm(),
      bottom: (context) => BottomBarScreen(),
      mapTracking: (context) => Tracking(),
      mapSearch: (context) => Searchscreen(),
    };
  }
}
