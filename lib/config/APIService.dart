class ApIConfig {
  static const String urlAPI = "198.199.67.201:9090";
  static String assignDriverApi =
      "http://198.199.67.201:9090/Api/Vehicle/AssignDriver";
  static String changeDriverStatus =
      "http://198.199.67.201:9090/Api/Vehicle/ChangeDriverStatus";
  static String changeVehicleStatus =
      "http://198.199.67.201:9090/Api/Vehicle/SetStatus";
  static const String alert = "/Api/SignIn/Owner";
  static const String vehicleApi = "/Api/Vehicle/Owner/All";
  static const String driverApi = "/Api/Vehicle/Owner/Drivers/All";
  static const String logIn = "/Api/SignIn/Owner";
  static const String vehiclebystatus =
      "http://198.199.67.201:9090/Api/Vehicle/Owner/Status";
  static const String tripOptions = "/Api/Admin/TripType/All";
  static const String setTrip =
      "http://198.199.67.201:9090/Api/Admin/CreateTrip";

  static const String allTrip = "http://198.199.67.201:9090/Api/Admin/Trip/All";
}
