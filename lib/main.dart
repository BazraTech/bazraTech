import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/view/screen/Loging/Login.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'Route/Routes.dart';
import 'view/screen/Owner/report/ownerReportstatus.dart';
import 'view/screen/Owner/report/toggelReport.dart';

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
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'us'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.getHomeRoute(),
        getPages: AppRoutes.routes,
        home: Login());
  }
}
