import 'package:bazralogin/const/constant.dart';

import '../Model/driversList.dart';
import 'package:flutter/material.dart';

class DriversProfile extends StatefulWidget {
  const DriversProfile({super.key});
  @override
  State<DriversProfile> createState() => _DriversProfileState();
}

class _DriversProfileState extends State<DriversProfile> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  List<ListOfDrivers> find = [];

  List<ListOfDrivers> profiles = [
    ListOfDrivers(
        status: false,
        driversName: "Luel Belay",
        licenseGrade: "One",
        experience: '1 year of experience',
        image: 'assets/images/driversPic.png',
        vehicleName: "Pickup Truck"),
    ListOfDrivers(
        status: false,
        driversName: "Luel Belay",
        licenseGrade: "One",
        experience: "3 years of experience",
        image: 'assets/images/driversPic.png',
        vehicleName: "hilux"),
    ListOfDrivers(
      status: true,
      driversName: " Belay Kebede",
      licenseGrade: "One",
      experience: "7 years of experience",
      image: 'assets/images/driversPic.png',
      vehicleName: 'Rv4',
    ),
    ListOfDrivers(
      status: false,
      driversName: "Musse Hailu",
      licenseGrade: "One",
      experience: "5 years of experience",
      image: 'assets/images/driversProfile.png',
      vehicleName: 'susuki',
    ),
    ListOfDrivers(
      status: true,
      driversName: "Luel Dawit",
      licenseGrade: "Two",
      experience: "4 years of experience",
      image: 'assets/images/driversPic.png',
      vehicleName: 'Pickup Truck',
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
        final name = driver.driversName.toLowerCase();
        final license = driver.licenseGrade.toLowerCase();
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
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: kPrimaryColor,
            title: Container(
              height: 60,
              margin: EdgeInsets.only(top: 10),
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
                  hintText: 'Driver Name or License Grade',
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      children: profiles.map((driver) {
                    return Card(
                      margin: EdgeInsets.zero,
                      elevation: 15,
                      shadowColor: Colors.black,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            padding: EdgeInsets.all(6.0),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
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
                                Text(
                                  " " + driver.driversName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey[500]),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(16, 8, 0, 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 0.1,
                                        width: 0.1,
                                        child: Checkbox(
                                            activeColor: Colors.green,
                                            value: driver.status,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                valuefirst = value!;
                                              });
                                            }),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16),
                                        child: Text(
                                          driver.experience.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    "  License Grade  ",
                                    style: TextStyle(
                                      color: Colors.purple[400],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    driver.licenseGrade,
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Text(
                                    "  Vehicle  ",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    driver.driversName,
                                    style: const TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
