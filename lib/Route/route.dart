import 'package:bazralogin/Model/DropdownSearch.dart';
import 'package:bazralogin/view/screen/Loging/Login.dart';
import 'package:flutter/cupertino.dart';
import '../view/screen/Owner/Tracking/carHistory.dart';
import '../view/screen/Owner/TripManagement/setTrip.dart';
import '../view/screen/Owner/Vehicle/vehicleDetial.dart';
import '../view/screen/Owner/report/CarReport.dart';
import '../view/screen/Owner/report/reportsWithGraph.dart';
import '../view/screen/Owner/report/singleReport.dart';

class AppRoutes {
  AppRoutes._();
  static const String authRegister = '/auth-register';
  static const String driversProfile = '/auth-profile';
  static const String driverRegistration = '/auth-drivers';
  static const String driversCommunicate = '/auth-communicate';
  static const String itemScreen = '/auth-itemScreen';
  static const String home = '/auth-home';
  static const String carhistory = '/auth-home';
  static const String mapTracking = '/auth-tracking';
  static const String mapSearch = '/auth-search';
  static const String driver = '/auth-driver';
  static const String vehicle = '/vehicle';
  static const String singleReport = '/singleReport';
  static const String report = '/report';
  static const String chart = '/TripChart';
  static const String trip = '/trip';
  static const String set = '/trip';
  static const String management = '/trip';
  static const String tripHistory = '/history';
  static const String market = '/market';
  static const String manageDriver = '/mangeDriver';
  static const String assignee = '/assignee';
  static const String detialvehicle = '/detialvehicle';
  static const String manage = '/drivermange';
  static const String permitAssign = '/d';
  static Map<String, WidgetBuilder> define() {
    return {
      // authRegister: (context) => RegistrationForm(),

      // vehicle: (context) => allVehicle(),
      report: (context) => Report(),

      singleReport: (context) => reportPage(),
      carhistory: (context) => CarHistory(),
      set: (context) => Settrips(),
      chart: (context) => TripChart(),

      detialvehicle: (context) => vehicleDetial(),
    };
  }
}
