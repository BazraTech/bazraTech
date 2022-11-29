import 'package:flutter/material.dart';
import 'package:practice/form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Coding with Curry',
     
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: FormScreen(),
    );
  }
}
