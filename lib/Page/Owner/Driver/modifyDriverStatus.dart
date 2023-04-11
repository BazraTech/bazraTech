import 'dart:convert';
import 'package:bazralogin/Model/DriverResponse.dart';
import 'package:bazralogin/Theme/TextInput.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../Bottom/Bottom.dart';
import '../../../config/APIService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ModifyDriverStatus extends StatefulWidget {
  String? driverLicense;

  ModifyDriverStatus({super.key, required this.driverLicense});

  @override
  State<ModifyDriverStatus> createState() => _ModifyDriverStatusState();
}

class _ModifyDriverStatusState extends State<ModifyDriverStatus> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  List<String> location = ['ASSIGNED', 'UNASSIGNED ', 'ONROUTE', 'PERMIT'];
  String? selectedItem = 'ASSIGNED';
  TextEditingController statusController = TextEditingController();
  String? driverStatus;

  String? plateNum;
  String? loc;
  final storage = new FlutterSecureStorage();

  UpdateStatus() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "driverStatus": "$selectedItem",
      "driverLicense": "${widget.driverLicense}",
    };
    var response = await http.put(Uri.parse(ApIConfig.changeDriverStatus),
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
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child: Container(
                height: 40,
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
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNav()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print('$selectedItem');

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
        title: const Text("Modify Driver Status"),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
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
                      // Container(
                      //     margin: EdgeInsets.only(top: 20),
                      //     child: Text(
                      //       " Assign Driver",
                      //       style: TextStyle(
                      //           fontSize: 20, fontWeight: FontWeight.bold),
                      //     )),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.07),
                              width: double.infinity,
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                  ' ${widget.driverLicense}',
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
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(screenWidth * 0.4, 20, 0, 0),
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
                    ]),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
