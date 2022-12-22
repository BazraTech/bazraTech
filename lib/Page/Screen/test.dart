import 'package:bazralogin/Model/driverlist.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class Searchdriverc extends StatefulWidget {
  const Searchdriverc({super.key});
  @override
  State<Searchdriverc> createState() => _SearchdrivercState();
}

class _SearchdrivercState extends State<Searchdriverc> {
  TextEditingController _searchController = TextEditingController();
  bool isWidget = true;
  var start;
  bool value = false;
  List<ListOfDrivers> find = [];
  List newRe = [];
  List multipleSelected = [];
  int? num;
  static final profiles = [
    new ListOfDrivers(
        status: false, driversName: "Luel Belay", date: "12/1/2022"),
    new ListOfDrivers(
      date: "12/1/2022",
      status: false,
      driversName: "Robel",
    ),
    new ListOfDrivers(
      date: "12/1/2023",
      status: false,
      driversName: " Alex",
    ),
    new ListOfDrivers(
      date: "12/1/2024",
      status: false,
      driversName: "tola",
    ),
    new ListOfDrivers(
      date: "12/1/2022",
      status: false,
      driversName: "Man",
    ),
    new ListOfDrivers(
      date: "12/1/2022",
      status: false,
      driversName: "yared",
    ),
    new ListOfDrivers(
      date: "12/12/2022",
      status: false,
      driversName: "Luel ",
    ),
  ];
  // void checkStatus() {
  //   valuefirst = !valuefirst;
  // }

  void initState() {
    super.initState();
    find = profiles;
  }

  List<ListOfDrivers> currentList = [];
  filterCars(String names) {
    // Prepare lists
    List<ListOfDrivers> tmp = [];
    currentList.clear();

    String name = names;
    print("filter cars for name " + name);

    for (ListOfDrivers c in profiles) {
      if (c.date.toLowerCase().startsWith(name.toLowerCase())) {
        tmp.add(c);
      }
    }
    currentList = tmp;
    print(currentList);
  }

  DateTimeRange? selectDateRange;
  _showDate() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 10, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );
    if (result != null) {
      setState(() {
        selectDateRange = result;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 33),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search_rounded),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Colors.black!, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Search'),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.calendar_month,
                            size: 40,
                          ),
                          onPressed: () {
                            _showDate();
                          },
                        ),
                      ),
                     
                      selectDateRange == null
                          ? Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                  children: currentList.map((driver) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            driver.driversName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        Text(
                                          "  Vehicle  ",
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                );
                              }).toList()),
                            )
                            
                          : Container(
                              height: 20,
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Text("Start"),
                                  Text(start =
                                      '   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
                                          .toString()),
                                ],
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
