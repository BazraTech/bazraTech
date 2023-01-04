import 'package:bazralogin/Model/Tripmanagementmodel.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:bazralogin/widget/Tripmangaefeed.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class SearchTriphistory extends StatefulWidget {
  const SearchTriphistory({
    super.key,
  });

  @override
  State<SearchTriphistory> createState() => _SearchTriphistoryState();
}

class _SearchTriphistoryState extends State<SearchTriphistory> {
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

  List<TripHistory> _searchList = [];
  List<TripHistory> _categoryList = [];
  List<TripHistory> productk = [];
  DateTimeRange? selectDateRange;

  List<TripHistory> currentList = [];

  @override
  Widget build(BuildContext context) {
    final carHistory = Provider.of<TripHistoryinfo>(context);
    final HistoryList = carHistory.products;

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
      );

      if (result != null) {
        // Prepare list

        setState(() {
          selectDateRange = result;
        });
      } else {
        return null;
      }
      List<TripHistory> tmp = [];
      currentList.clear();

      // String? name =
      //     ;
      // print("filter cars for name " + name);
      // print(name.runtimeType);

      for (TripHistory c in HistoryList) {
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
                      SizedBox(
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
                              _searchList = carHistory.searchQuery(value);
                            });
                          },
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                          size: 40,
                        ),
                        onPressed: () {
                          _showDate();
                        },
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: kPrimaryColor,
                  child: Row(
                    children: [
                      Container(
                        // color: const Color.fromRGBO(69, 92, 128, 1),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Trip place",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width - 430),

                        // margin: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width - 350),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width - 400),
                            child: const Text(
                              " Total hour",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Text(" Total Speed",
                            style: TextStyle(color: Colors.white)),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(" Date",
                              style: TextStyle(color: Colors.white)))
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
                          : Container(
                              width: MediaQuery.of(context).size.width - 4,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                    _searchTextController!.text.isEmpty
                                        ? HistoryList.length
                                        : _searchList.length, (index) {
                                  return ChangeNotifierProvider.value(
                                    value: _searchTextController!.text.isEmpty
                                        ? HistoryList[index]
                                        : _searchList[index],
                                    child: Container(
                                      // height: 50,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,

                                      child: TripmangeFeed(onChange: null),
                                    ),
                                  );
                                }),
                              ),
                            ))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Container(
                        // margin: EdgeInsets.zero,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 120,
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.zero,
                                child: Column(
                                    children: currentList.map((driver) {
                                  return Card(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            // height: 86,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      driver.travelPlace,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: SizedBox(
                                                      child: Text(
                                                        "${driver.totalTraveltime} hr",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: SizedBox(
                                                      child: Text(
                                                        "${driver.speedOfcar} km/hr",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: SizedBox(
                                                      child: Text(
                                                        "${driver.dateOftravelstart} ",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
