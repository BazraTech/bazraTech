
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
TextEditingController dateStart = TextEditingController();
TextEditingController vehicleplate = TextEditingController();
TextEditingController driver = TextEditingController();
TextEditingController Startlocation = TextEditingController();
TextEditingController Endlocation = TextEditingController();
TextEditingController triptype = TextEditingController();

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
                                    value: item, child: Text(item)))
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
                            controller: vehicleplate,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
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
                            controller: driver,
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
                            keyboardType: TextInputType.text,
                            controller: Startlocation,
                            decoration: InputDecoration(
                              hintText: ' Strat location',
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
                            keyboardType: TextInputType.text,
                            controller: Endlocation,
                            decoration: InputDecoration(
                              hintText: 'End location',
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
                        child: TextFormField(
                            // onChanged: driversSearch,
                            // controller: _searchController,
                            keyboardType: TextInputType.text,
                            controller: dateStart,
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2101));
                              if (pickDate != null) {
                                dateStart.text =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Strat Date',
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
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
                ElevatedButton(
                  onPressed: (() {
                    List<String> trip = [
                      dateStart.text,
                      Endlocation.text,
                      Startlocation.text,
                      vehicleplate.text,
                      driver.text,
                      selectedItem.toString()
                    ];
                    print(trip);
                  }),
                  child: Text('Set Trip'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return ColorsConsts.backgroundColor;
                        }
                        return const Color.fromRGBO(69, 92, 128, 1);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromRGBO(162, 184, 212, 1)),
                              borderRadius: BorderRadius.circular(22)))),
                ),
              ],
            )),
      ),
    );
  }
}
