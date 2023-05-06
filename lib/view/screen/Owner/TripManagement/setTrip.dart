import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'package:http/http.dart' as http;

import '../../../../Bottom/Bottom.dart';
import '../../../../Theme/TextInput.dart';
import '../../../../config/APIService.dart';

class Settrips extends StatefulWidget {
  String? drivername;
  String? platenumber;

  String? startLocation;
  String? destination;
  String? startDate;
  String? tripType;
  Settrips(
      {super.key,
      this.drivername,
      this.platenumber,
      this.startLocation,
      this.destination,
      this.startDate,
      this.tripType});

  @override
  State<Settrips> createState() => _SettripsState();
}

class _SettripsState extends State<Settrips> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController vehicleplate = TextEditingController();
  TextEditingController driver = TextEditingController();
  TextEditingController Startlocation = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController tripType = TextEditingController();

  TextEditingController triptype = TextEditingController();

  String? selectedItem = 'Single Trip';
  String? startPlace;
  String? endPlace;
  List Result = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Vehicle already has a trip! '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    print(selectedItem);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Set Trip Successfully '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            ),
          ],
        );
      },
    );
  }

  activeTrip() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response =
        await http.get(Uri.parse(ApIConfig.allTrip), headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      Result = mapResponse['activeTrips'];
      return Result;
    } else {
      throw Exception('not loaded ');
    }
  }

  setTrips() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "vehicle": "${widget.platenumber}",
        "startLocation": "Addisa Ababa",
        "destination": "jimma",
        "startDate": "2023-05-08",
        "tripType": "SHORT"
      };
      var response = await http.post(
          Uri.parse('http://64.226.104.50:9090/Api/Admin/CreateTrip'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        _showMyDialog();
      } else {
        print('noo');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void initState() {
    // super.initState();
    String apikey = "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc";
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String? selectedItem = 'SHORT';
    List<String> items = ['SHORT', 'LONG'];
    print('${dateStart.text}');
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: const Text(" Create Alert Page"),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.75,
                    margin: EdgeInsets.only(top: screenHeight * 0.04),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        )),
                    child: Column(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.white,

                                    child: Container(
                                      height: screenHeight * 0.08,
                                      child: Image.asset(
                                          'assets/images/R-removebg-preview.png'),
                                    ),
                                    padding: EdgeInsets.all(11),
                                    minWidth: screenWidth * 0.004,
                                    //use this class Circleborder() for circle shape.
                                    shape: const CircleBorder(),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        right: screenWidth * 0.1),
                                    child: Text(
                                      " Set trip",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth - 36,
                                  child: DropdownButtonFormField<String>(
                                    decoration:
                                        ThemeHelper().textInputDecoration(),
                                    value: selectedItem,
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )))
                                        .toList(),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter  Plate Number';
                                      }
                                    },
                                    onChanged: (item) {
                                      setState(() {
                                        selectedItem = item;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth,
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                  '${widget.drivername} ',
                                  ' Enter  Driver Name',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth,
                                child: TextField(
                                  decoration: ThemeHelper().textInputDecoration(
                                    '${widget.platenumber}',
                                    '${widget.platenumber}',
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: screenWidth,
                                child: TextField(
                                  controller: dateStart,
                                  onTap: () async {
                                    DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1980),
                                        lastDate: DateTime(2101));
                                    if (pickDate != null) {
                                      dateStart.text = DateFormat('yyyy-MM-dd')
                                          .format(pickDate);
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Choose Start Date',
                                    suffixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Colors.black,
                                    ),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black45),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    fillColor: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      placesAutoCompleteTextField(),
                      endAutoCompleteTextField(),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(screenWidth * 0.4, 20, 0, 0),
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            setTrips();
                          },
                          child: const Text(
                            "Set Trip",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ThemeHelper().buttonStyle(),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  placesAutoCompleteTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width - 32,
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: startController,
          googleAPIKey: "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
          debounceTime: 800,
          inputDecoration: ThemeHelper().textInputDecoration('Start Location'),
          countries: ["er", "et"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
          },
          itmClick: (Prediction prediction) {
            setState(() {
              startController.text = prediction.description!;

              startController.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length));
              startPlace = startController.text;
            });
          }
          // default 600 ms ,
          ),
    );
  }

  endAutoCompleteTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width - 32,
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: endController,
          googleAPIKey: "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
          debounceTime: 800,
          inputDecoration: ThemeHelper().textInputDecoration('End Location'),
          countries: ["er", "et"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
          },
          itmClick: (Prediction prediction) {
            endController.text = prediction.description!;

            endController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
            endPlace = endController.text;
          }
          // default 600 ms ,
          ),
    );
  }
}
