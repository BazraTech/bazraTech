import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/config/APIConfig.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:cargo/shared/logoStorage.dart';
import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/usermanagement/signup.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/app_localizations.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_event.dart';
import '../../navigate/navigateBloc.dart';
import '../../navigate/navigatestateEvent.dart';
import '../../shared/ImageHelper.dart';
import '../../shared/checkConnection.dart';
import '../../shared/custom-form.dart';
import '../../shared/failAlert.dart';
import '../../shared/logo.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import 'forgetPassword.dart';

class Cargo_login extends StatefulWidget {
  const Cargo_login({super.key});

  @override
  State<Cargo_login> createState() => _Cargo_loginState();
}

class _Cargo_loginState extends State<Cargo_login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? ownerPic;
  bool _isLoading = true;
  List<String> _data = [];
  String? phoneNumber;
  bool _isFocused = false;
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed

    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  loginCargo(String phone, String pass) async {
    const url = 'http://64.226.104.50:9090/Api/SignIn/Cargo';
    StorageHelper storageHelper = StorageHelper();
    String? retrievedToken = await storageHelper.getToken();
    // Define your request data as a Map
    Map requestData = {
      'username': "${phone}",
      'password': "${pass}",
    };

    print(requestData);

    print("********************************");
    print('Token: $retrievedToken');
    print("********************************");
    bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      // Show an error message
      print(
          'No internet connection found, please check your internet settings.');
      // Define this function to show an alert
      Fluttertoast.showToast(
          msg:
              'No internet connection found, please check your internet settings.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }
    try {
      String body = json.encode(requestData);

      // Make the request and handle the response
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        final response = await http.post(
          Uri.parse(url),
          body: body,
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
          },
        );
        print(response.body);
        print(response.statusCode);
        final storage = FlutterSecureStorage();
        if (response.statusCode == 200) {
          // Parse the response
          var jsonResponse = json.decode(response.body);
          //Get the token from the response
          String? newToken = jsonResponse['jwt'];
          var name = jsonResponse['user']['name'];
          var phoneNumber = jsonResponse['user']['PhoneNumber'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', name);
          await prefs.setString('phoneNumber', phoneNumber);
          // Save the token to storage
          if (newToken != null) {
            await storageHelper.setToken(newToken);
          }
          // Save the phone number using FlutterSecureStorage
          await storage.write(key: 'phoneNumber', value: phoneNumber);
          print(newToken);
          context.read<NavigationBloc>().add(NavigateTo('/bottomNav'));
        } else {
          Fluttertoast.showToast(
              msg: "Invaild Phone Number or User Name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      }
    } catch (error) {
      if (error is http.ClientException &&
          error.message.contains('Connection reset by peer')) {
        Fluttertoast.showToast(
          msg: "Connection reset by peer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        // Display an error message to the user or retry the operation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Connection reset by peer. Please try again.'),
              actions: [
                ElevatedButton(
                  child: Text('Retry'),
                  onPressed: () {
                    // Retry the operation
                    loginCargo(phone, pass);
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      Fluttertoast.showToast(
          msg: "Check your internet Connection and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
    getPhoneNumberSync().then((value) {
      setState(() {
        phoneNumber = value;
        _phoneController.text = phoneNumber ?? '';
      });
    });
  }

  Future<String> fetchImage() async {
    var client = http.Client();
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();

    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(
          Uri.parse('http://64.226.104.50:9090/Api/Admin/LogoandAvatar'),
          headers: requestHeaders);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        Map<String, dynamic> data = json.decode(response.body);
        return data["logo"];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load image'),
          ),
        );
        return '';
      }
    } on Exception catch (e) {
      if (e is ArgumentError) {
        Fluttertoast.showToast(
            msg: "Check your internet Connection and try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0);
      }
      print('Error occurred: $e');
      return '';
    }
  }

  Future<void> storeImageInHive() async {
    await Hive.openBox<String>('imageBox');
    final imageBox = Hive.box<String>('imageBox');
    final imageUrl = await fetchImage();
    imageBox.put('imageUrl', imageUrl);
  }

  Widget buildLanguageDropdown(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final localeBloc = context.read<LocaleBloc>();
    bool isPressed = true;

    return Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 25,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: DropdownButton2<Locale>(
          hint: Text(
            AppLocalizations.of(context)?.translate('Select Language') ?? '',
          ),
          value: localeBloc.state.locale,
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              localeBloc.add(ChangeLocale(newLocale));
            }
          },
          items: [
            DropdownMenuItem(
              child: Text(
                AppLocalizations.of(context)?.translate('English') ?? 'English',
              ),
              value: Locale('en', ''),
            ),
            DropdownMenuItem(
              child: Text(
                AppLocalizations.of(context)?.translate('Amharic') ?? 'Amharic',
              ),
              value: Locale('am', ''),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> getPhoneNumberSync() async {
    // Retrieve the phone number asynchronously
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 80),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: FutureBuilder(
                    future: fetchImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text("");
                      return Image.network(
                        snapshot.data.toString(),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: screenHeight - 30,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                ),
              ),
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 30),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10, bottom: 40),
                      child: Text(
                        AppLocalizations.of(context)?.translate(" Login ") ??
                            "Login",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(AppLocalizations.of(context)
                              ?.translate("Mobile Number") ??
                          "Mobile Number"),
                    ),
                    CustomTextFieldForm(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Roboto"),
                      hintText: '',
                      textController: _phoneController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)
                                  ?.translate('Password') ??
                              "Please enter your phone number";
                        }
                      },
                      obscureText: false,
                      hintTextStyle: TextStyle(
                        letterSpacing: 1.0,
                        wordSpacing: 2.0,
                        color: _isFocused ? Colors.green.shade700 : Colors.grey,
                        // ... other styles
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                          AppLocalizations.of(context)?.translate("Password") ??
                              "Password"),
                    ),
                    CustomTextFieldForm(
                      hintText: '',
                      textController: _passwordController,
                      isPassword: true,
                      textStyle: TextStyle(fontSize: 16),
                      onChanged: (value) {
                        print("password changed: $value");
                      },
                      obscureText: true,
                      showSuffixIcon: true,
                      hintTextStyle: TextStyle(
                        letterSpacing: 1.0,
                        wordSpacing: 2.0,
                        color: _isFocused ? Colors.red : Colors.grey,
                        // ... other styles
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)
                                  ?.translate('Please enter a company name') ??
                              "Please enter a company name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Forget()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 25),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Forgot Password?") ??
                                  "Forgot Password",
                              style: const TextStyle(
                                fontSize: 15,
                                color: kPrimaryColor,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                    CustomButton(
                        onPressed: () async {
                          await loginCargo(
                              _phoneController.text, _passwordController.text);
                        },
                        text:
                            AppLocalizations.of(context)?.translate("Login") ??
                                "Login"),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 40, right: 10),
                              child: Text(
                                AppLocalizations.of(context)
                                        ?.translate("Don't have an account?") ??
                                    "Don't have an account",
                                style: const TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5,
                                  wordSpacing: 1.0,
                                  color: Colors.black54,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const Signup()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                        ?.translate("Sign Up") ??
                                    "Sigun up",
                                style: const TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5,
                                  color: kPrimaryColor,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
