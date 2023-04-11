import 'dart:convert';
import 'package:bazralogin/Model/DriverResponse.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../Bottom/Bottom.dart';
import '../../../Theme/TextInput.dart';
import '../../../config/APIService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'TotalVehicles.dart';

class ModifyVehileStatus extends StatefulWidget {
  String? plateNumber;

  ModifyVehileStatus({super.key, this.plateNumber});

  @override
  State<ModifyVehileStatus> createState() => _ModifyVehileStatusState();
}

class _ModifyVehileStatusState extends State<ModifyVehileStatus> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<String> location = ['INSTOCK', 'MAINTAINING ', 'ONROUTE', 'PARKED'];
  TextEditingController statusController = TextEditingController();
  String? vehiclestatus;
  String? selectedItem = "INSTOCK";
  String? plateNum;
  String? loc;
  final storage = new FlutterSecureStorage();

  UpdateStatus() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "status": "$selectedItem",
      "plateNumber": "${widget.plateNumber}",
    };
    var response = await http.post(Uri.parse(ApIConfig.changeVehicleStatus),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      _showMyDialog();
    }
    print(response.statusCode.toString());
  }

  Future<void> _showMyDialog() async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.07,
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child: Center(
                child: Container(
                  height: 20,
                  child: const Text(
                    "Alert",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Updated Successfully ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnersVehicle()));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.plateNumber}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
        title: const Text(
          "Modify Vehicle Status",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.1),
                  width: screenWidth,
                  height: screenHeight * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      )),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: screenWidth * 0.5,
                    child: Column(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.07),
                              width: double.infinity,
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                  ' ${widget.plateNumber}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth - 60,
                              child: DropdownButtonFormField<String>(
                                decoration: ThemeHelper().textInputDecoration(),
                                value: selectedItem,
                                items: location
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
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedItem = newValue;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                screenWidth * 0.4, 20, 0, 0),
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              onPressed: () {
                                UpdateStatus();
                              },
                              child: const Text(
                                "Update Status",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ThemeHelper().buttonStyle(),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
