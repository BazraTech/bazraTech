import 'package:cargo/shared/constant.dart';
import 'package:flutter/material.dart';

import '../model/bill.dart';
import '../views/Bill/billDetail.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final List<Bill> bill = [
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Paid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Paid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Unpaid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Unpaid"),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                "Hello ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              margin: EdgeInsets.only(top: 80),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 246, 247, 249),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        ' Trip ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth,
                  height: 5,
                  color: Colors.grey,
                  margin: EdgeInsets.only(bottom: 10, left: 18, right: 18),
                ),
                Column(
                    children: bill.map((bill) {
                  return Container(
                    height: screenHeight * 0.12,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: Offset(
                                  -6, // Move to right 7.0 horizontally
                                  8, // Move to bottom 8.0 Vertically
                                ))
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Bill_Detail()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(bill.startTrip),
                              Text(bill.endTrip),
                              Text(bill.status),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList())
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
