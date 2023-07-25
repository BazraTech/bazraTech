import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../../const/constant.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  bool _isLoading = true;
  List Result = [];
  List existingData = [];
  List results = [];
  List Temp = [];
  List dataList = [];
  List<Color> colors = [
    Colors.white,
    Color.fromRGBO(195, 215, 233, 1),
  ];

  List<dynamic> addBoolValueToList(List<dynamic> Result) {
    return Result.map((item) {
      return {
        ...item,
        'isFlagged': false, // Add the boolean value to each item
      };
    }).toList();
  }

  void updateDataInHive(int index) async {
    final box = await Hive.openBox('datalist'); // Open the Hive box

    final dataList = box.get('datalist'); // Retrieve the data list from Hive

    if (dataList != null) {
      setState(() {
        dataList[index]['isFlagged'] =
            true; // Set the isFlagged value to true for the desired item

        box.put('datalist', dataList);
      });
    }
  }

  Future<List<dynamic>> fetchDataFromApiAndStoreInHive() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://164.90.174.113:9090/Api/Vehicle/Alerts/ByStatus'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);

      results = mapResponse['activeAlerts'];
      final Box<dynamic> box = await Hive.openBox<dynamic>('listdata');

      if (!box.containsKey('listdata')) {
        // Data doesn't exist, store it in Hive
        final modifiedDataList = addBoolValueToList(results);
        setState(() {
          box.put('dataList', modifiedDataList);
          dataList = modifiedDataList;
        });
        return dataList; // Store the data in Hive
      } else {
        // Data already exists in Hive, retrieve it

        setState(() {
          dataList = box.get('listdata');
        });

        // Compare the existing data with the new data
        if (_isDataEqual(dataList, results)) {
          // New data is the same as existing data, return the existing data
          return dataList;
        } else {
          // New data is different, update the data in Hive
          // Store the new data in Hive
          final modifiedDataList = addBoolValueToList(results);
          setState(() {
            box.put('dataList', modifiedDataList);
            dataList = modifiedDataList;
            box.put('listdata', modifiedDataList);
          });
          return dataList;
        }
      }
    } else {
      throw Exception('Failed to fetch data from API');
    }

    // setState(() {
    //   final int lastIndex = box.isEmpty ? 0 : box.length;
    //   for (var i = 0; i < results.length; i++) {
    //     final item = results[i];

    //     final existingData = box.values.contains(
    //       (data) => data["alertstart"] == item["alertstart"],
    //     );

    //     if (existingData == null) {

    //     }
    //   }
    // });
  }

  // Future<void> fetchDataFromHive() async {
  //   final box = await Hive.openBox('dataBox'); // Open the Hive box

  //   final dataListFromHive =
  //       box.get('dataList'); // Retrieve the data list from Hive

  //   setState(() {
  //     dataList =
  //         dataListFromHive != null ? List<dynamic>.from(dataListFromHive) : [];
  //   });
  // }

  bool _isDataEqual(List<dynamic> existingData, List<dynamic> newData) {
    return existingData.length == newData.length;
  }

  void initState() {
    super.initState();
    fetchDataFromApiAndStoreInHive();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(dataList);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Alerts",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: AppFonts.smallFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            Container(

                // margin: EdgeInsets.only(bottom: 200),
                child: Column(
              children: [
                if (dataList == null || dataList.isEmpty)
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.2,
                      ),
                      width: 300,
                      height: 300,
                      child: Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          'assets/images/noapidatas.json', // Replace with your animation file path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: screenHeight,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          bool doesNotExist =
                              dataList.contains(dataList[index]['isFlagged']) ==
                                  false;
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    print(doesNotExist);
                                    if (doesNotExist == true) {
                                      // Set the isFlagged value to true for the desired item
                                      updateDataInHive(index);
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      if (dataList[index]['isFlagged'] == false)
                                        Container(
                                          height: screenHeight * 0.1,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                212, 233, 253, 1),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade400
                                                    .withOpacity(0.3),
                                                spreadRadius: -1,
                                                blurRadius: 1,
                                                offset: Offset(0,
                                                    -4), // horizontal, vertical offset
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: SizedBox(
                                                    height: screenHeight * 0.08,
                                                    width: screenWidth * 0.1,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: SizedBox(
                                                          height: screenHeight *
                                                              0.06,
                                                          child: Center(
                                                            child: Text(
                                                              dataList[index]
                                                                      ["driver"]
                                                                  .substring(
                                                                      0, 1),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.4,
                                                margin: EdgeInsets.only(
                                                  top: screenHeight * 0.03,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            dataList[index][
                                                                'alertocation'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenWidth *
                                                                      0.07),
                                                          child: Text(
                                                            dataList[index]
                                                                ['alertType'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.22,
                                                margin: EdgeInsets.only(
                                                    left: screenWidth * 0.15),
                                                child: Text(
                                                  dataList[index]['alertstart'],
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Container(
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle),
                                              )
                                            ],
                                          )),
                                        )
                                      else if (dataList[index]['isFlagged'] ==
                                          true)
                                        Container(
                                          height: screenHeight * 0.1,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade400
                                                    .withOpacity(0.3),
                                                spreadRadius: -1,
                                                blurRadius: 1,
                                                offset: Offset(0,
                                                    -4), // horizontal, vertical offset
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: SizedBox(
                                                    height: screenHeight * 0.08,
                                                    width: screenWidth * 0.1,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: SizedBox(
                                                          height: screenHeight *
                                                              0.06,
                                                          child: Center(
                                                            child: Text(
                                                              dataList[index]
                                                                      ["driver"]
                                                                  .substring(
                                                                      0, 1),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.4,
                                                margin: EdgeInsets.only(
                                                  top: screenHeight * 0.03,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            dataList[index][
                                                                'alertocation'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenWidth *
                                                                      0.07),
                                                          child: Text(
                                                            dataList[index]
                                                                ['alertType'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.22,
                                                margin: EdgeInsets.only(
                                                    left: screenWidth * 0.15),
                                                child: Text(
                                                  dataList[index]['alertstart'],
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              )
                                            ],
                                          )),
                                        )
                                    ],
                                  )),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
