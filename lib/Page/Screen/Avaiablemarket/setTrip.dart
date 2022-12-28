import 'package:bazralogin/Model/Avaiablemarkemodel.dart';
import 'package:flutter/material.dart';

class SetTrip extends StatefulWidget {
  const SetTrip({super.key});

  @override
  State<SetTrip> createState() => _SetTripState();
}
// List<Communicationlist> find = [];

// List<TypeTrip> profiles = [
//   TypeTrip(
//    triptype: 'Long'
//   ),
//   TypeTrip(triptype: 'short'),
//   TypeTrip(),
// TypeTrip(),
// ];
List<String> items = ['short', 'long'];

String? selectedItem = 'short';

class _SetTripState extends State<SetTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: 'Vehicle Plate Number',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.black!, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            value: selectedItem,
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    )))
                                .toList(),
                            onChanged: (item) {
                              setState(() => selectedItem = item);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Vehicle Plate Number',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.black!, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Driver',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.black!, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Search driver',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.black!, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Search driver',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.black!, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            decoration: InputDecoration(
                          hintText: 'Search driver',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.black!, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
