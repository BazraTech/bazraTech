
import 'package:bazralogin/Model/CarReportmodel.dart';
import 'package:bazralogin/Route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class Report extends StatefulWidget {
  const Report({super.key});
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController _searchController = TextEditingController();
  // final DateRangePickerController _controller = DateRangePickerController();
  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  // void selectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   SchedulerBinding.instance!.addPostFrameCallback((duration) {
  //     setState(() {
  //       _date = DateFormat('dd, MMMM yyyy').format(args.value).toString();
  //     });
  //   });
  // }

  bool valuefirst = false;
  List<ListOfPlate> find = [];

  List<ListOfPlate> profiles = [
    ListOfPlate(
      status: "accident",
      plateNumber: "AA 34952",
      assignedDriver: "Solomon ",
      location: 'Addis Ababa',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      plateNumber: 'AA 45699',
      status: "Off Road",
      assignedDriver: "Abdu ",
      location: 'Bahir Dar',
      startDate: '12/01/2023',
      endDate: '18/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Adama',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Gondar',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Driver",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Deber Markos',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Dire Dawa',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Driver",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Hawassa',
      startDate: '12/01/2023',
      endDate: '12/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "ET 94529",
      assignedDriver: "Luel Belay",
      location: 'Arba Minch',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      status: "accident",
      plateNumber: "AA 45699",
      assignedDriver: "Musse Hailu",
      location: 'Jijiga',
      startDate: '12/01/2023',
      endDate: '19/01/2023',
    ),
    ListOfPlate(
      status: "Off Road",
      plateNumber: "A.A-34952",
      assignedDriver: "Luel Dawit",
      location: 'Asosa',
      startDate: '12/01/2023',
      endDate: '18/01/2023',
    ),
  ];
  void checkStatus() {
    valuefirst = !valuefirst;
  }

  void initState() {
    super.initState();
    find = profiles;
  }

  TextEditingController dateBirth = TextEditingController();
  DateTimeRange? selectDateRange;

  List<ListOfPlate> currentList = [];
  _showDate() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 10, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: "Confirm",

      // builder: (context, child) {
      //   return (Container(
      //     child: filterCars(),
      //   ));
      // },
    );
    // filterCars('   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}',
    //     '   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}');
    if (result != null) {
      // Prepare list

      setState(() {
        selectDateRange = result;
      });
    } else {
      return null;
    }
    List<ListOfPlate> tmp = [];
    currentList.clear();

    // String? name =
    //     ;
    // print("filter cars for name " + name);
    // print(name.runtimeType);

    for (ListOfPlate c in profiles) {
      if (c.startDate.toString().contains(
              '${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
                  .toString()) &&
          c.endDate.toString().toLowerCase().contains(
              '${DateFormat('dd/MM/yyy').format(selectDateRange!.end)}'
                  .toString())) {
        tmp.add(c);
      }
    }
    currentList = tmp;
    print('   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
        .toString());
    print(currentList);
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
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(244, 243, 243, 1),
            automaticallyImplyLeading: false,
            elevation: 0,
            // leading: IconButton(
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //     color: Colors.black,
            //   ),
            //   onPressed: () => Navigator.pop(context),
            // ),
            title: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // margin: EdgeInsets.only(left: 60),
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      _showDate();
                    },
                    icon: Icon(Icons.calendar_month),
                    color: Colors.black45,
                    iconSize: 35,
                  ),
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: [
                //Container(child: Text('SelectedDate:' '$dateBirth')),
                selectDateRange == null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.singlereport);
                        },
                        child: Column(
                            children: profiles.map((driver) {
                          return Container(
                            margin: const EdgeInsets.only(top: 15, left: 15),
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 15,
                              shadowColor: Colors.black45,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 80,
                                        child: Text(driver.assignedDriver)),
                                    SizedBox(
                                        height: 20,
                                        width: 80,
                                        child: Text(driver.plateNumber)),
                                    SizedBox(
                                        height: 20,
                                        width: 90,
                                        child: Text(driver.location)),
                                    if (driver.status == 'accident')
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.red,
                                          ),
                                          child: SizedBox(
                                              height: 20,
                                              width: 80,
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(driver.status))))
                                    else if (driver.status == 'Off Road')
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.amber,
                                          ),
                                          child: SizedBox(
                                            height: 20,
                                            width: 80,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                driver.status,
                                              ),
                                            ),
                                          ))
                                    else if (driver.status == "Driver")
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.greenAccent,
                                          ),
                                          child: SizedBox(
                                            height: 20,
                                            width: 80,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                driver.status,
                                              ),
                                            ),
                                          )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                      )
                    : Column(
                        children: currentList.map((driver) {
                        return Container(
                          margin: const EdgeInsets.only(top: 15, left: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 15,
                            shadowColor: Colors.black45,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 20,
                                      width: 80,
                                      child: Text(driver.assignedDriver)),
                                  SizedBox(
                                      height: 20,
                                      width: 80,
                                      child: Text(driver.plateNumber)),
                                  SizedBox(
                                      height: 20,
                                      width: 90,
                                      child: Text(driver.location)),
                                  if (driver.status == 'accident')
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.red,
                                        ),
                                        child: SizedBox(
                                            height: 20,
                                            width: 80,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(driver.status))))
                                  else if (driver.status == 'Off Road')
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.amber,
                                        ),
                                        child: SizedBox(
                                          height: 20,
                                          width: 80,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              driver.status,
                                            ),
                                          ),
                                        ))
                                  else if (driver.status == "Driver")
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.greenAccent,
                                        ),
                                        child: SizedBox(
                                          height: 20,
                                          width: 80,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              driver.status,
                                            ),
                                          ),
                                        )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
              ],
            ),
          ))),
    );
  }
}
