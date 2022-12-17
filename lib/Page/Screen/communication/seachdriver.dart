import 'dart:ffi';

import 'package:bazralogin/Model/car.dart';
import 'package:bazralogin/Model/communica.dart';
import 'package:bazralogin/Page/Screen/communication/Communication.dart';
import 'package:bazralogin/const/color.dart';
import 'package:bazralogin/widget/carlist.dart';
import 'package:bazralogin/widget/driverlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Seardriver extends StatefulWidget {
  final Function? onChangeman;
  const Seardriver({super.key, required this.onChangeman});

  @override
  State<Seardriver> createState() => _SeardriverState();
}

class _SeardriverState extends State<Seardriver> {
  TextEditingController? _searchTextController;

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

  List<Communications> _searchList = [];
  List<Communications> productk = [];
  @override
  Widget build(BuildContext context) {
    final carData = Provider.of<Commuicationprovider>(context);
    final productsList = carData.products;

    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 35,
                    child: TextField(
                      controller: _searchTextController,
                      minLines: 1,
                      focusNode: _node,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
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
                  ElevatedButton(
                    onPressed: onChangeman(),
                    child: Text("Select all"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return ColorsConsts.backgroundColor;
                          }
                          return const Color.fromRGBO(69, 92, 128, 1);
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(162, 184, 212, 1)),
                                    borderRadius: BorderRadius.circular(12)))),
                  ),
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.height - 280,
              width: MediaQuery.of(context).size.width - 16,
              child:
                  _searchTextController!.text.isNotEmpty && _searchList.isEmpty
                      ? Column(
                          children: [
                            Icon(
                              Icons.search,
                              size: 60,
                            ),
                            Text(
                              'No results found',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width - 10,
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
                                      child: Feeddriver(
                                        onChange: null,
                                      )),
                                );
                              }),
                            ),
                          ),
                        )),
        ],
      ),
    );
  }
  
  onChangeman() {}
}
