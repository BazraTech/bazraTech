import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(status: 'Off Road', hour: 8, color: Color.fromRGBO(238, 2, 2, 1)),
    Data(status: 'On Road', hour: 12, color: Color.fromARGB(255, 86, 80, 248)),
    Data(status: 'Park', hour: 4, color: Colors.blueGrey),
  ];
}

class Data {
  String status;

  final double hour;

  final Color color;
  Data({required this.status, required this.hour, required this.color});
}
