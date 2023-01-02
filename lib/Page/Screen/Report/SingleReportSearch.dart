import 'dart:ffi';


import 'package:bazralogin/Model/report.dart';
import 'package:bazralogin/widget/Reportfeed.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';

class SearchReport extends StatefulWidget {
  const SearchReport({
    super.key,
  });

  @override
  State<SearchReport> createState() => _SearchReportState();
}

class _SearchReportState extends State<SearchReport> {
  TextEditingController? _searchTextController;
  // ignore: prefer_typing_uninitialized_variables
  var end;
  // ignore: prefer_typing_uninitialized_variables
  String? start;

  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();

    _searchTextController = TextEditingController();
    _searchTextController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController?.dispose();
  }

  List<TravelReport> _searchList = [];
  List<TravelReport> _categoryList = [];
  List<TravelReport> productk = [];
  DateTimeRange? selectDateRange;

  List<TravelReport> currentList = [];

  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<TravelReportinfo>(context);
    final productsList = carData.products;

    // print("${start.toString()}".runtimeType);
    // filterCars(names, names1) {
    //   // Prepare list
    //   List<TravelReport> tmp = [];
    //   currentList.clear();

    //   names;
    //   String name1 = names;
    //   print("filter cars for name " + names);
    //   print(names.runtimeType);

    //   for (TravelReport c in productsList) {
    //     if (c.dateOftravelstart.toLowerCase().startsWith(names)) {
    //       tmp.add(c);
    //     }
    //   }
    //   currentList = tmp;
    //   print(currentList);
    // }

    // print(start);

    Widget buildreport() {
      return (Container());
    }

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
      List<TravelReport> tmp = [];
      currentList.clear();

      // String? name =
      //     ;
      // print("filter cars for name " + name);
      // print(name.runtimeType);

      for (TravelReport c in productsList) {
        if (c.dateOftravelstart.toLowerCase().contains(
                '${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'
                    .toString()) &&
            c.dateOftravelend.toLowerCase().contains(
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

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        height: 45,
                        child: TextField(
                          controller: _searchTextController,
                          minLines: 1,
                          focusNode: _node,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.black!, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            suffixIcon: IconButton(
                              onPressed: _searchTextController!.text.isEmpty
                                  ? null
                                  : () {
                                      _searchTextController!.clear();
                                      _node.unfocus();
                                    },
                              icon: Icon(Icons.close,
                                  color: _searchTextController!.text.isNotEmpty
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            _searchTextController!.text.toLowerCase();
                            setState(() {
                              _searchList = carData.searchQuery(value);
                            });
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 40,
                          ),
                          onPressed: () {
                            _showDate();
                          },
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromRGBO(69, 92, 128, 1),
                  child: Row(
                    children: [
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Trip"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 87),
                        child: Text(" Total hour"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Text(" Total Speed"),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 35),
                          child: const Text(" Date"))
                    ],
                  ),
                ),
              ),
              selectDateRange == null
                  ? Container(
                      height: MediaQuery.of(context).size.height - 282,
                      width: MediaQuery.of(context).size.width - 16,
                      child: _searchTextController!.text.isNotEmpty &&
                              _searchList.isEmpty
                          ? Column(
                              children: const [
                                Icon(
                                  Icons.search,
                                  size: 60,
                                ),
                                Text(
                                  'No results found',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width - 4,
                              child: Container(
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      _searchTextController!.text.isEmpty
                                          ? productsList.length
                                          : _searchList.length, (index) {
                                    return ChangeNotifierProvider.value(
                                      value: _searchTextController!.text.isEmpty
                                          ? productsList[index]
                                          : _searchList[index],
                                      child: SizedBox(
                                        height: 86,
                                        width: 100,
                                        child: Reportfeed(onChange: null),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                                height: 20,
                                margin: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Text("Start"),
                                    Text(start =
                                        '   ${DateFormat('dd/MM/yyy').format(selectDateRange!.start)}'),
                                  ],
                                )),
                            SizedBox(
                                height: 20,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        const Text("End"),
                                        Text(end =
                                            '     ${DateFormat('dd/MM/yyy').format(selectDateRange!.end)}'),
                                      ],
                                    ),
                                  ),
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height - 120,
                              margin: const EdgeInsets.only(top: 30),
                              child: Column(
                                  children: currentList.map((driver) {
                                return Card(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 86,
                                          child: Row(
                                            children: [
                                              Text(
                                                driver.travelPlace,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Text(
                                                      "${driver.totalTraveltime} hr"),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Text(
                                                      "${driver.speedOfcar} km/hr"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()),
                            )
                          ],
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
