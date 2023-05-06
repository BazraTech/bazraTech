import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class vehicledetialBystatus extends StatefulWidget {
  final int? id;
  final String? route;
  vehicledetialBystatus({super.key, this.id, this.route});

  @override
  State<vehicledetialBystatus> createState() => _vehicledetialBystatusState();
}

class _vehicledetialBystatusState extends State<vehicledetialBystatus> {
  Map<String, dynamic>? results;

  static final storage = FlutterSecureStorage();

  _getvehiclebyid() async {
    var value = await storage.read(key: 'jwt');
    try {
      var response = await http.get(
          Uri.parse(
              'http://198.199.67.201:9090/Api/Vehicle/Owner/Status/${widget.route}/${widget.id}'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        print(widget.id);
        setState(() {
          results = result;
        });
        return results;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void initState() {
    super.initState();
    _getvehiclebyid();
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            toolbarHeight: 100,
            backgroundColor: kPrimaryColor),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
            child: SizedBox(
          child: results == null
              ? Container(
                  margin: EdgeInsets.only(top: 130),
                  child: Center(child: CircularProgressIndicator()))
              : Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 10),
                  //height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    //  physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: ListTile(
                          trailing: Text(
                            results!['vehicleCatagory'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          title: const Text(
                            "VehicleCatagory",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            MdiIcons.carBack,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "vehicleName",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['vehicleName'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            MdiIcons.carBack,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "vehicleCondition",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['vehicleCondition'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "plateNumber",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['plateNumber'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.numbers,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text("ManufactureDate",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['manufactureDate'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text("Company Info",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['companyInfo'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text("Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['status'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "Driver",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['driver'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.person_pin,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        )));
  }
}
