import 'package:cargo/shared/customAppbar.dart';
import 'package:flutter/material.dart';

import '../../model/bill.dart';
import 'billDetail.dart';

class BillStatus extends StatefulWidget {
  const BillStatus({super.key});

  @override
  State<BillStatus> createState() => _BillStatusState();
}

class _BillStatusState extends State<BillStatus> {
  final List<Bill> bill = [
    Bill(trip: "Addis Abbaba To Djibouti", status: "Paid"),
    Bill(trip: "Addis Abbaba To Djibouti", status: "Paid"),
    Bill(trip: "Addis Abbaba To Djibouti", status: "Paid"),
    Bill(trip: "Addis Abbaba To Djibouti", status: "Paid"),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Bill Status",
        showBackButton: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ' Trip ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Status',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
              height: screenHeight * 0.08,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: const BoxDecoration(
                      border: Border(
                    left: BorderSide(color: Colors.green, width: 5),
                  )),
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
