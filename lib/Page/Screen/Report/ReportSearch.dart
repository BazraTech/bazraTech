import 'dart:ffi';

import 'package:bazralogin/Model/Reportmodel.dart';
import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Model/communica.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/widget/Reportfeed.dart';
import 'package:bazralogin/widget/testwidget.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

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
  var start;

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

    filterCars(String names, String names1) {
      // Prepare lists
      List<TravelReport> tmp = [];
      currentList.clear();

      String name = names.toString();
      String name1 = names.toString();
      print("filter cars for name " + name);

      for (TravelReport c in productsList) {
        if (c.dateOftravelstart.toLowerCase().startsWith(name.toString()) &&
            c.dateOftravelstart.toLowerCase().startsWith(name1.toString())) {
          tmp.add(c);
        }
      }
      currentList = tmp;
      print(currentList);
    }

    print(start);
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
      if (result != null) {
        setState(() {
          selectDateRange = result;
        });
      } else {
        return null;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                            prefixIcon: Icon(
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
                          icon: Icon(
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
              selectDateRange == null
                  ? Container(
                      height: MediaQuery.of(context).size.height - 282,
                      width: MediaQuery.of(context).size.width - 16,
                      child: _searchTextController!.text.isNotEmpty &&
                              _searchList.isEmpty
                          ? Column(
                              children: [
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
                          : Container(
                              width: MediaQuery.of(context).size.width - 4,
                              child: Container(
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      _searchTextController!.text.isEmpty
                                          ? productsList.length
                                          : _searchList.length, (index) {
                                    return ChangeNotifierProvider.value(
                                      value: _searchTextController!.text.isEmpty
                                          ? productsList[index]
                                          : _searchList[index],
                                      child: Container(
                                        height: 86,
                                        width: 100,
                                        child: Reportfeed(onChange: null),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ))
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              child: ElevatedButton(
                                child: Text("Report"),
                                onPressed: (() {
                                  filterCars("12/01/2023", "12/08/2023");
                                }),
                              ),
                            ),
                            Container(
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
                            SizedBox(
                                height: 20,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Text("End"),
                                        Text(end =
                                            '     ${DateFormat('dd/MM/yyy').format(selectDateRange!.end)}'
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                  children: currentList.map((driver) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 86,
                                        child: Row(
                                          children: [
                                            Text(
                                              driver.travelPlace,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
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
