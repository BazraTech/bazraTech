import 'package:bazralogin/view/screen/Loging/Login.dart';
import 'package:bazralogin/view/screen/Owner/Alert/Notification.dart';
import 'package:bazralogin/view/screen/Owner/Driver/vehicleOnStock.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../view/screen/Bottom/Bottom.dart';
import '../view/screen/Owner/Driver/UnassignedDrivers.dart';
import '../view/screen/Owner/Driver/driversPage.dart';
import '../view/screen/Owner/Profile/profileEdit/updateOwnerprofile.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/Login';
  static const String signup = '/Signup';
  static const String alert = '/Alert';
  static const String driverpage = '/Driverpage';
  static const String unassigndriver = '/UNassigndriver';
  static const String vehicleonstack = '/Vehicleonstacks';
  static const String updateProfiles = '/Updateprofile';
  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getDriverpageRoute() => driverpage;
  static String getAlertRoute() => alert;
  static String getUnassigndriver() => unassigndriver;
  static String getVehicleonstaock() => vehicleonstack;
  static String getUpdateprofile() => updateProfiles;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => BottomNav()),
    GetPage(name: login, page: () => Login()),
    GetPage(name: driverpage, page: () => communicate_screen()),
    GetPage(name: '/Alert', page: () => notificationPage()),
    GetPage(name: unassigndriver, page: () => UnassignedDrivers()),
    GetPage(name: vehicleonstack, page: () => VehicleOnstock()),
    GetPage(name: updateProfiles, page: () => ownerprofileUpadate()),
  ];
}
