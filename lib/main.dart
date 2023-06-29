import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/screen/Bottom/Bottom.dart';
import 'package:bazralogin/screen/Driver/driverBottomnav.dart';
import 'package:bazralogin/screen/Loging/Landingpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final translationController = Get.put(TranslationController());
  final prefs = await SharedPreferences.getInstance();
  phone = prefs.getString('phone_number');
  translationController.loadTranslations('en_us');
  runApp(const MyApp());
}

var phone;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'us'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => BottomNav()),
        GetPage(name: '/drivehome', page: () => BottomTabBarPage()),
      ],
    );
  }
}
