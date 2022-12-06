
import 'package:practice/Pages/Home_Screen.dart';
import 'package:practice/main.dart';

import '../../Pages/Signup.dart';

//import '../../Pages/Login.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  AppRoutes._();
  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String authHome = '/auth-register';

  

  static Map<String, WidgetBuilder> define() {
    return {
      //authLogin: (context) => const Login(),
      authRegister: (context) => const likedStack(),
      authHome: (context) => const category_screen(),
      authHome: (context) => const RegistrationForm(),
     
    };
  }
}