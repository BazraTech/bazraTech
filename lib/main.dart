import 'package:bazralogin/Bottom/Bottom.dart';
import 'package:bazralogin/Model/SingleReportmodel.dart';
import 'package:bazralogin/Model/Tripmodel.dart';

import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Model/communica.dart';
import 'package:bazralogin/Page/Loging/Login.dart';
import 'package:bazralogin/Page/Screen/communication/seachdriver.dart';
import 'package:bazralogin/Page/Screen/test.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Carinfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => Commuicationprovider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TravelReportinfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => TripHistoryinfo(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: AppRoutes.define(),
        home: Login(),
      ),
    );
  }
}
