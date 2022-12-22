import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfDrivers {
  bool? status;
  final String driversName;
  final  String date;


  ListOfDrivers({
    required this.status,
    required this.driversName,
    required this.date,
  });
}
