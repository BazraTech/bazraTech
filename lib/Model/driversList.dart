import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfDrivers{
  final bool status;
  final String driversName;
  //final String plateNumber;
  final String licenseGrade;
  String  experience;
  final String image;
  final String vehicleName;
  ListOfDrivers({
    required this.status,
    required this.driversName,
    required this.licenseGrade,
    required this.experience,
    required this.image,
    required this.vehicleName,
  });
  


}