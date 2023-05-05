import 'dart:async';
import 'package:bazralogin/Model/communication.dart';
import 'package:bazralogin/Page/Localization/Localization.dart';
import 'package:bazralogin/Page/Loging/Login.dart';
import 'package:bazralogin/Page/Owner/report/singleReport.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'Page/Driver/pages/driverHm.dart';
import 'Page/Driver/pages/reportStatus.dart';
import 'Page/Localization/Localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final translationController = Get.put(TranslationController());
  translationController.loadTranslations('en_us');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: LocaleController.supportedLocales,
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'us'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: AppRoutes.define(),
      home: Login(),
    );
  }
}
