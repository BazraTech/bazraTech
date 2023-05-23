import 'dart:convert';

import 'package:cargo/shared/constant.dart';
import 'package:flutter/material.dart';

import '../../shared/custom-form.dart';
import '../../shared/customButton.dart';

import '../../shared/failAlert.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import 'package:http/http.dart' as http;

import '../Bottom_Navigation.dart';

class CargoType {
  final int id;
  final String cargoType;

  CargoType(this.id, this.cargoType);
}

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  String? selectedItem = 'Liquid';
  List<String> items = ['Liquid', 'PLC'];
  bool _isMounted = false;
  final _from = TextEditingController();
  final _to = TextEditingController();
  final _date = TextEditingController();
  final _cargoType = TextEditingController();
  final _packaging = TextEditingController();
  final _weight = TextEditingController();
  final _price = TextEditingController();
  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _from.dispose();
    _to.dispose();
    _date.dispose();
    _cargoType.dispose();
    _cargoType.dispose();
    _weight.dispose();
    _isMounted = false;
    super.dispose();
  }

  registerCargo(String from, String to, String date, String cargoType,
      String packaging, String weight, String price) async {
    // Define your request data as a Map
    Map requestData = {
      'from': "${from}",
      'to': "${to}",
      'date': "${date}",
      'cargoType': "${cargoType}",
      'packaging': "${packaging}",
      'weight': "${weight}",
      'price': "${price}",
    };
    String body = json.encode(requestData);

    StorageHelper storageHelper = StorageHelper();
    String? retrievedToken = await storageHelper.getToken();
    print(requestData);

    print("********************************");
    print('Token: $retrievedToken');
    print("********************************");
    try {
      // Make the request and handle the response
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        final response = await http.post(
            Uri.parse('http://64.226.104.50:9090/Api/Cargo/PostCargo'),
            body: body,
            headers: {
              "Content-Type": "application/json",
              'Accept': 'application/json',
              "Authorization": "Bearer $retrievedToken",
            });

        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomNav()),
          );
        } else {
          print(response.statusCode);
          showAlertDialogFail(context);
        }
      }
    } catch (error) {
      throw error;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFieldForm(
                  hintText: "From",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  textController: _from,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "To",
                  textController: _to,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Date",
                  textController: _date,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth,
                  color: kBackgroundColor,
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Cargo Type",
                  textController: _cargoType,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Packaging",
                  textController: _packaging,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Weight",
                  textController: _weight,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ), // ... other styl
                  obscureText: false,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth,
                  color: kBackgroundColor,
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldForm(
                  hintText: "Price",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  textController: _price,
                  obscureText: false,
                  hintTextStyle: TextStyle(
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    // ... other styles
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your departure";
                    }
                  },
                ),
                CustomButton(
                  onPressed: () {
                    registerCargo(
                        _from.text,
                        _to.text,
                        _date.text,
                        _cargoType.text,
                        _packaging.text,
                        _weight.text,
                        _price.text);
                  },
                  text: "Post",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
