import 'package:bazralogin/Page/customAppBar.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../Model/Vehicle.dart';

class PlateList extends StatefulWidget {
  const PlateList({super.key});
  @override
  State<PlateList> createState() => _PlateListState();
}

class _PlateListState extends State<PlateList> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  List<ListOfPlate> find = [];

  List<ListOfPlate> profiles = [
    ListOfPlate(
      status: "On Route",
      plateNumber: "AA 34952",
      assignedDriver: "Solomon ",
      vehicleName: 'suzuki',
      image: 'assets/images/car4.png',
    ),
    ListOfPlate(
      plateNumber: 'AA 45699',
      status: "Park",
      vehicleName: "Hilux",
      assignedDriver: "Abdu ",
      image: 'assets/images/car2.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car2.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car1.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car4.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car2.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car1.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car1.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car4.png',
    ),
    ListOfPlate(
      status: "Maintenance",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      vehicleName: 'Truck',
      image: 'assets/images/car3.png',
    ),
    ListOfPlate(
      status: "On Route",
      plateNumber: "AA 45699",
      assignedDriver: "Musse Hailu",
      vehicleName: 'Cino Truck',
      image: 'assets/images/car2.png',
    ),
    ListOfPlate(
      status: "Park",
      plateNumber: "A.A-34952",
      assignedDriver: "Luel Dawit",
      vehicleName: 'Micro Car',
      image: 'assets/images/car1.png',
    ),
  ];
  void checkStatus() {
    valuefirst = !valuefirst;
  }

  void initState() {
    super.initState();
    find = profiles;
  }

  void driversSearch(String enterKeyboard) {
    setState(() {
      this.profiles = find;
    });
    if (enterKeyboard.isEmpty) {
      find = profiles;
    } else {
      final find = profiles.where((driver) {
        final name = driver.assignedDriver.toLowerCase();
        final license = driver.plateNumber.toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || license.contains(inputLicense);
      }).toList();
      setState(() {
        this.profiles = find;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // backgroundColor: kBackgroundColor,
            appBar: AppBar(
              toolbarHeight: 120,
              backgroundColor: kPrimaryColor,
              title: Container(
                margin: EdgeInsets.only(top: 10),
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 243, 243, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  onChanged: driversSearch,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Driver Name or Plate No.',
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                  children: profiles.map((driver) {
                return Container(
                  child: Container(
                    color: kBackgroundColor,
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 15,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black45)),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 0),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 220, 234, 242),
                              border: Border.all(
                                color: Colors.blueGrey,
                                width: 2,
                              ),
                              image: DecorationImage(
                                  image: AssetImage(driver.image),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Vehicle  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            driver.vehicleName,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                " Plate No.     ",
                                                style: TextStyle(
                                                  color: Colors.purple[400],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              driver.plateNumber,
                                              style: TextStyle(
                                                color: Colors.purple[400],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(left: 30),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: kPrimaryColor,
                                              ),
                                              child: SizedBox(
                                                  height: 25,
                                                  width: 100,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        driver.status,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))))
                                        ]),
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    "Driver    ",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    driver.assignedDriver,
                                    style: TextStyle(
                                      color: Colors.purple[400],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
            )),
      ),
    );
  }
}
