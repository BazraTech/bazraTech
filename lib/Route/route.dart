import 'package:bazralogin/Model/DropdownSearch.dart';
import 'package:bazralogin/Page/Loging/Login.dart';

import '../Bottom/Bottom.dart';

import '../Page/Driver/driversRegistrationForm.dart';
import '../Page/Owner/Tracking/carHistory.dart';
import '../Page/Owner/Tracking/caronMap.dart';
import '../Page/Owner/TripManagement/setTrip.dart';
import '../Page/Owner/Vehicle/vehicleDetial.dart';
import '../Page/Owner/report/CarReport.dart';
import '../Page/Owner/report/reportsWithGraph.dart';
import '../Page/Owner/report/singleReport.dart';
import '../Page/Register/Signup.dart';

import 'package:flutter/cupertino.dart';

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
      authRegister: (context) => RegistrationForm(),

      driverRegistration: (context) => DriversForm(),
      // vehicle: (context) => allVehicle(),
      report: (context) => Report(),

      singleReport: (context) => reportPage(),
      carhistory: (context) => CarHistory(),

      chart: (context) => TripChart(),

      mapTracking: (context) => displaycarlaction(),

      detialvehicle: (context) => vehicleDetial(),
    };
  }
}
