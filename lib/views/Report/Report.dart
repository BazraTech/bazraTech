import 'package:cargo/shared/customAppbar.dart';
import 'package:flutter/material.dart';

import '../../model/bill.dart';
import '../Bill/billDetail.dart';


class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final List<Bill> bill = [
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
    Bill(trip: "Addis Ababa To Djibouti", status: "06-05-2023"),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Report",
        showBackButton: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(children: [
          Column(
              children: bill.map((bill) {
            return Container(
              height: screenHeight * 0.1,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Colors.green.shade800, width: 6))),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Bill_Detail()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(bill.trip), Text(bill.status)],
                    ),
                  ),
                ),
              ),
            );
          }).toList())
        ]),
      ),
    );
  }
}
