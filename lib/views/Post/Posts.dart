import 'dart:convert';

import 'package:cargo/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Components/Home_Page.dart';
import '../../shared/custom-form.dart';
import '../../shared/customButton.dart';
import 'package:intl/intl.dart';
import '../../shared/failAlert.dart';
import '../../shared/storage_hepler.dart';
import '../../shared/succussAlert.dart';
import 'package:http/http.dart' as http;

import '../Bottom_Navigation.dart';

class CargoType {
  int id;
  String cargoType;

  CargoType({required this.id, required this.cargoType});

  factory CargoType.fromJson(Map json) {
    return CargoType(id: json['id'], cargoType: json['cargoType']);
  }
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

  // @override
  // void dispose() {
  //   // Clean up the controllers when the widget is disposed
  //   _from.dispose();
  //   _to.dispose();
  //   _date.dispose();
  //   _cargoType.dispose();
  //   _cargoType.dispose();
  //   _weight.dispose();
  //   _isMounted = false;
  //   super.dispose();
  // }
  void _showSweetAlert(BuildContext context, AlertType alertType, String title,
      String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CargoOWnerHomePage()));
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    ).show();
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
    String? accessToken = await storageHelper.getToken();
    print(requestData);

    print("********************************");
    print('accessToken: $accessToken');
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
              "Authorization": "Bearer $accessToken",
            });

        print(response.body);
        print(response.statusCode);
        final Map jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          _showSweetAlert(
              context, AlertType.success, 'Success', jsonResponse['message']);
        } else {
          _showSweetAlert(
              context, AlertType.error, 'Error', jsonResponse['message']);
        }
      }
    } catch (e) {
      _showSweetAlert(context, AlertType.error, 'Error',
          'An error occurred, please check your internet connection.');
    }
  }

  List<CargoType> _cargoTypes = [];
  CargoType? _selectedCargoType;

  @override
  void initState() {
    super.initState();
    _fetchCargoTypes();
  }

  Future<void> _fetchCargoTypes() async {
    StorageHelper storageHelper = StorageHelper();
    String? accessToken = await storageHelper.getToken();
    final response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Admin/All/CargoType'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $accessToken",
        });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _cargoTypes = List.from(data['cargoTypes'])
            .map((e) => CargoType.fromJson(e))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch cargo types');
    }
  }

  List cargoTypesItems = [];
  String? selectedCargoType;
  validateCargoType(CargoType value) {
    return value == null ? 'Please select a cargo type' : null;
  }

  TextEditingController _dateController = TextEditingController();
  String? validateDate(String value) {
    if (value.isEmpty) {
      return 'Please select a date';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController cargoTypeController = TextEditingController();
  var dropdownvalue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 249),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: screenWidth * 0.12),
          height: 40,
          child: const Center(
            child: Text(
              "Post Your Cargo Here",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
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
                  hintTextStyle: const TextStyle(
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
                  hintTextStyle: const TextStyle(
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
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Select a date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a  date';
                    }
                    return null;
                  },
                  // validator: _validateDate,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _cargoType,
                  readOnly: true, // To prevent opening the keyboard
                  onTap: () async {
                    CargoType? selectedValue = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _cargoTypes.map((CargoType cargo) {
                              return ListTile(
                                title: Text(cargo.cargoType),
                                onTap: () {
                                  Navigator.of(context).pop(cargo);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );

                    if (selectedValue != null) {
                      setState(() {
                        _selectedCargoType = selectedValue;
                        _cargoType.text = selectedValue.cargoType;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Select Cargo Type",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.expand_more_rounded),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a cargo type';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFieldForm(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  hintText: "Packaging",
                  textController: _packaging,
                  obscureText: false,
                  hintTextStyle: const TextStyle(
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
                  hintText: "Weight",
                  textController: _weight,
                  hintTextStyle: const TextStyle(
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth,
                  color: Colors.grey.shade500,
                  height: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldForm(
                  hintText: "Price",
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  textController: _price,
                  obscureText: false,
                  hintTextStyle: const TextStyle(
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
                        _dateController.text,
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
