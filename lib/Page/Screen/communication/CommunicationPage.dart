import 'package:bazralogin/Model/communication.dart';
import 'package:bazralogin/Page/Screen/communication/Communication.dart';
import 'package:bazralogin/const/color.dart';
import 'package:flutter/material.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  TextEditingController _searchController = TextEditingController();

  List<Communicationlist> find = [];

  List<Communicationlist> profiles = [
    Communicationlist(
      value: false,
      name: " Belay",
      Status: "Assigned",
    ),
    Communicationlist(Status: "Assigned", name: "Luel ", value: false),
    Communicationlist(Status: "Assigned", name: "Luel Belay", value: false),
    Communicationlist(Status: "Assigned", name: "Luel Belay", value: false),
  ];

  final allchecked = Communicationlist(value: false, name: '', Status: "");
  void initState() {
    super.initState();
    find = profiles;
  }

  OnclickedAll(Communicationlist item) {
    setState(() {
      item.value = !item.value;
    });
  }

  Onclicked(Communicationlist item) {
    final newvalue = !item.value;
    setState(() {
      item.value = !item.value;
      profiles.forEach((element) {
        element.value = newvalue;
      });
    });
  }

  void driversSearch(String enterKeyboard) {
    setState(() {
      this.profiles = find;
    });
    if (enterKeyboard.isEmpty) {
      find = profiles;
    } else {
      final find = profiles.where((driver) {
        final name = driver.name.toLowerCase();

        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName);
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 220,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            onChanged: driversSearch,
                            controller: _searchController,
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
                    ),
                    Spacer(),
                    Container(
                      width: 100,
                      margin: EdgeInsets.fromLTRB(100.0, 0, 2, 0),
                      child: ElevatedButton(
                        onPressed: (() {
                          Onclicked(allchecked);
                        }),
                        child: Text('selectall'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return ColorsConsts.backgroundColor;
                              }
                              return const Color.fromRGBO(69, 92, 128, 1);
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(162, 184, 212, 1)),
                                    borderRadius: BorderRadius.circular(22)))),
                      ),
                    ),
                  ],
                ),
                Column(
                    children: profiles.map((driver) {
                  return Card(
                    // elevation: 10,
                    shadowColor: Colors.black,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          // margin: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 20,
                                        child: Text(
                                          " " + driver.name,
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, top: 8),
                                      child: SizedBox(
                                        width: 17,
                                        height: 10,
                                        child: Transform.scale(
                                          scale: 0.8,
                                          child: InkWell(
                                            onTap: () {
                                              OnclickedAll(driver);
                                            },
                                            child: Checkbox(
                                                activeColor: Colors.green,
                                                value: driver.value,
                                                onChanged: (value) =>
                                                    OnclickedAll(driver)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width - 30,
                                  child: Text(
                                    " ${driver.Status}",
                                    style: const TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
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
    );
  }
}
