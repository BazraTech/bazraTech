import 'package:shared_preferences/shared_preferences.dart';

class CargoInfo{
  Future<String?> getCargoInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('name');
  print('Hello $name');
  return name;
}
}