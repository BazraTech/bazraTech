import 'package:bazralogin/Page/Loging/Login.dart';
import 'package:bazralogin/Page/Screen/Avaiablemarket/setTrip.dart';
import 'package:bazralogin/Page/Screen/Profile.dart';
import 'package:bazralogin/Page/Screen/Report/SingleTripReport.dart';
import 'package:bazralogin/Page/Screen/Tracking/CarlocationTacking.dart';
// import 'package:bazralogin/Page/Screen/Tracking/CarHistory.dart';
import 'package:bazralogin/Page/Screen/tripManagement.dart';
import '../Bottom/Bottom.dart';
import '../Page/Register/Signup.dart';

import 'package:bazralogin/Page/Screen/Search.dart';
import 'package:flutter/cupertino.dart';

import '../Page/Screen/Report/CarReport.dart';
import '../Page/Screen/Tripmanegemnet/TripHistory.dart';
import '../Page/Screen/itemsscreen.dart';
import '../Page/Screen/vehicle.dart';
import '../Page/driversPage.dart';
import '../Page/driversProfile.dart';
import '../Page/driversRegistrationForm.dart';

class AppRoutes {
  AppRoutes._();
  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String driversProfile = '/auth-profile';
  static const String driverRegistration = '/auth-drivers';
  static const String driversCommunicate = '/auth-communicate';
  static const String itemScreen = '/auth-itemScreen';
  static const String home = '/auth-home';
  static const String bottom = '/auth-bottom';
  static const String mapTracking = '/auth-tracking';
  static const String mapSearch = '/auth-search';
  static const String driver = '/auth-driver';
  static const String vehicle = '/vehicle';
  static const String report = '/report';
  static const String trip = '/trip';
  static const String singlereport = '/auth-report';
  static const String carreport = '/auth-carreport';
  static const String carhistory = '/auth-history';
  static const String trippage = '/auth-trip';
  static const String market = '/auth-market';
  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => const Login(),
      authRegister: (context) => RegistrationForm(),
      driversProfile: (context) => DriversProfile(),
      driverRegistration: (context) => DriversForm(),
      vehicle: (context) => PlateList(),
      trip: (context) => Trip(),
      driversCommunicate: (context) => communicate_screen(),
      bottom: (context) => BottomNavBar(),
      mapTracking: (context) => displaycarlaction(),
      mapSearch: (context) => Searchscreen(),
      singlereport: (context) => TripReport(),
      carreport: (context) => Report(),
      trippage: (context) => TripHistorys(),
      market: (context) => SetTrip(),
    };
  }
}
