import 'package:cargo/views/Bill/Bill.dart';
import 'package:flutter/material.dart';
import '../../model/bill_details.dart';
import '../../shared/customAppbar.dart';
import '../Bottom_Navigation.dart';

class Report_Detail extends StatefulWidget {
  const Report_Detail({super.key});

  @override
  State<Report_Detail> createState() => _Report_DetailState();
}

List<BillDetails> billDetail = [
  BillDetails(
      cargoType: "Stell Bars",
      packaging: "Bulk",
      paidDate: "2023-05-10",
      price: 20000,
      weight: "40 Kg",
      paymentDueDate: "2024-05-10"),
];

class _Report_DetailState extends State<Report_Detail> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
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
          child: const Center(
            child: Text(
              "Cargo Report Detail",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: billDetail.map((detail) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 85,
              ),
              child: Column(
                children: [
                  Card(
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                width: 8.0, color: Colors.green.shade900),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text("Cargo Type"),
                              trailing: Text(detail.cargoType),
                            ),
                            Container(
                              margin: EdgeInsets.zero,
                              width:
                                  screenWidth, // Change this value to increase or decrease the thickness of the vertical line.
                              height:
                                  1, // Change this value to increase or decrease the height of the vertical line.
                              color: Colors.grey.shade600,
                            ),
                            ListTile(
                              title: const Text("Packaging"),
                              trailing: Text(detail.packaging),
                            ),
                            ListTile(
                              title: const Text("Weight"),
                              trailing: Text(detail.weight),
                            ),
                            ListTile(
                              title: const Text("price"),
                              trailing: Text(detail.price.toString()),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              print("Share button pressed");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.print,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              print("Share button pressed");
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
