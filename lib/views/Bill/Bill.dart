import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customAppbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/Home_Page.dart';
import '../../model/bill.dart';
import 'billDetail.dart';

class BillStatus extends StatefulWidget {
  const BillStatus({super.key});

  @override
  State<BillStatus> createState() => _BillStatusState();
}

class _BillStatusState extends State<BillStatus> {
  final List<Bill> bill = [
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Paid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Paid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Unpaid"),
    Bill(startTrip: "Addis Abbaba", endTrip: "Djibouti", status: "Unpaid"),
  ];
  bool isPressed = false;
  bool isPaid = false;

  void _togglePaymentStatus() {
    setState(() {
      isPaid = !isPaid;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CargoOWnerHomePage()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: screenWidth * 0.12),
          height: 40,
          color: Colors.white,
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Driver Name or Plate No.',
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
              top: 30,
            ),
            child: Column(
                children: bill.map((bill) {
              return Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Card(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200.withOpacity(0.7),
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                            offset: const Offset(
                              6, // Move to right 7.0 horizontally
                              8, // Move to bottom 8.0 Vertically
                            ))
                      ],
                    ),
                    height: screenHeight * 0.17,
                    child: ListTile(
                      title: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    bill.startTrip,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Icon(Icons.trip_origin,
                                        size: 15, color: Colors.grey.shade300),
                                  ),
                                  Container(
                                    width: screenWidth * 0.25,
                                    child: const Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        DottedLine(
                                          lineThickness: 1.0,
                                          dashLength: 4.0,
                                          dashColor: Colors.grey,
                                          dashGapRadius: 2.0,
                                        ),
                                        Icon(
                                          Icons.local_shipping,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.location_on,
                                        size: 15, color: Colors.grey.shade300),
                                  ),
                                  Text(
                                    bill.endTrip,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: const Expanded(
                                child: DottedLine(
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: Colors.grey,
                                  dashGapRadius: 2.0,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Bill Status",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                bill.status,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: bill.status == "Paid"
                                      ? Colors.green
                                      : Colors.red,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));
            }).toList())),
      ),
    );
  }
}
