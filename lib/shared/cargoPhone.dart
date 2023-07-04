import 'package:shared_preferences/shared_preferences.dart';

class CargoPhoneNumber {
  Future<String?> getCargoPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('PhoneNumber');
    print('Hello $phoneNumber');
    return phoneNumber;
  }
}
