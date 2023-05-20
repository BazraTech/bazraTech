import 'package:cargo/shared/constant.dart';

import 'package:cargo/shared/customButton.dart';

import 'package:flutter/material.dart';
import '../../model/post.dart';

class ActiveWorkDetail extends StatelessWidget {
  const ActiveWorkDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text("List Of Vehicles"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: const List_Vehicles(),
    ));
  }
}

class List_Vehicles extends StatefulWidget {
  const List_Vehicles({super.key});

  @override
  State<List_Vehicles> createState() => _List_VehiclesState();
}

class _List_VehiclesState extends State<List_Vehicles> {
  final List<ListItem> items = [
    ListItem(
        driverName: 'Putin',
        plateNumber: ' 003221',
        Date: "09-05-2023",
        isExpanded: false,
        status: "start"),
    ListItem(
        driverName: 'Victor',
        plateNumber: '03323',
        Date: "08-05-2023",
        isExpanded: false,
        status: "start"),
    ListItem(
        driverName: 'John ',
        plateNumber: '09932',
        isExpanded: false,
        Date: "07-05-2023",
        status: "start"),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: kBackgroundColor,
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: CustomScrollView(
        slivers: items.map((item) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  elevation: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      left: BorderSide(color: Colors.green, width: 5),
                    )),
                    child: ListTile(
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            item.isExpanded = !item.isExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.driverName),
                            Text(item.plateNumber),
                          ],
                        ),
                      ),
                      trailing: SizedBox(
                        width: screenWidth * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.grey,
                              height: screenHeight * 0.05,
                              width: screenWidth * 0.01,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "+2",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  height: item.isExpanded ? screenHeight * 0.3 : 0,
                  color: Colors.grey[300],
                  child: item.isExpanded
                      ? Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: screenHeight * 0.3,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: screenWidth * 0.42,
                                              child: CustomButton(
                                                  text: "Load",
                                                  onPressed: () {})),
                                          SizedBox(
                                              width: screenWidth * 0.42,
                                              child: CustomButton(
                                                  text: "UnLoad",
                                                  onPressed: () {}))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: screenWidth * 0.42,
                                              child: CustomButton(
                                                  text: "Load",
                                                  onPressed: () {})),
                                          SizedBox(
                                              width: screenWidth * 0.42,
                                              child: CustomButton(
                                                  text: "UnLoad",
                                                  onPressed: () {}))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: screenWidth,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print("Button Pressed");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[300],
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    side: const BorderSide(color: Colors.black54),
                                    elevation: 1,
                                  ),
                                  child: const Text(
                                    "Track",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : null,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
