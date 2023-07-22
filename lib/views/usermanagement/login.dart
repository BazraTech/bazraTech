import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/views/usermanagement/signup.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/app_localizations.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_event.dart';
import '../../navigate/navigateBloc.dart';
import '../../navigate/navigatestateEvent.dart';
import '../../shared/checkConnection.dart';
import '../../shared/custom-form.dart';
import '../../shared/loading.dart';
import '../../shared/storage_hepler.dart';
import 'package:path_provider/path_provider.dart';
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
  Box<String>? logoBox;
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
    setState(() {
      isLoading = true;
    });

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
        } else if (response.statusCode == 500) {
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
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
      setState(() {
        isLoading = false;
      });
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
              title: const Text('Error'),
              content:
                  const Text('Connection reset by peer. Please try again.'),
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
    initHive();
  }

// Initialize Hive and open the logoBox
  Future<void> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>('logoBox');
    logoBox = Hive.box<String>('logoBox');
  }

// Call initHive before using the fetchImage function

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

  Future<void> storeLogoToHive() async {
    String logo = await fetchImage();

    if (logo.isNotEmpty) {
      logoBox?.put('logo', logo);
      print('Logo stored in Hive: $logo');
    } else {
      print('Failed to store logo in Hive');
    }
  }

  bool isLoading = false;
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
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
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
          underline: null,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 50, left: 240),
                child: buildLanguageDropdown(context)),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  child: FutureBuilder(
                    future: storeLogoToHive(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text("");
                      String? logo = logoBox?.get('logo');
                      if (logo != null) {
                        return Image.network(
                          logo,
                        );
                      } else {
                        return Text('Bazra Technology Group');
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: screenHeight - 30,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: const BorderRadius.only(
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
                        child: Container(
                          margin: const EdgeInsets.only(
                              top:
                                  5.0), // Adjust the top margin of the underline
                          child: Container(
                            margin: EdgeInsets.only(bottom: 40),
                            child: Text(
                              "Login".toUpperCase(),
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Color.fromRGBO(178, 142, 22,
                                    1), // Replace with your desired color
                                decorationThickness:
                                    2.0, // Adjust the thickness of the underline
                              ),
                            ),
                          ),
                        )),
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
                            margin: EdgeInsets.only(right: 25, bottom: 10),
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
                    ElevatedButton(
                      onPressed: () async {
                        isLoading
                            ? null
                            : await loginCargo(_phoneController.text,
                                _passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: 20.0),
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : SizedBox(), // Empty SizedBox if not loading
                          SizedBox(width: 8),
                          Text(
                            isLoading
                                ? AppLocalizations.of(context)
                                        ?.translate('Please Wait') ??
                                    "Please Wait"
                                : AppLocalizations.of(context)
                                        ?.translate('Login')
                                        ?.toUpperCase() ??
                                    "Login".toUpperCase(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
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
                                          TikTokLoadingSpinner()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                        ?.translate("Sign Up") ??
                                    "Sign up",
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
