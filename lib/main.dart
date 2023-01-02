//import 'package:bazralogin/Bottom/Bottom.dart'
import 'package:bazralogin/Model/communication.dart';
import 'package:bazralogin/Model/item.dart';
import 'package:bazralogin/Model/report.dart';
import 'package:bazralogin/Model/yaredtripmanagement.dart';
import 'package:bazralogin/Page/Loging/Login.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Carinfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => TravelReportinfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => TripHistoryinfo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: AppRoutes.define(),
        home: const Login(),
      ),
    );
  }
}
