
import 'package:flutter/material.dart';
import '../../model/bill_details.dart';
import '../../shared/customAppbar.dart';
import '../Bottom_Navigation.dart';
import 'BillCargo.dart';

class Bill_Detail extends StatefulWidget {
  const Bill_Detail({super.key});

  @override
  State<Bill_Detail> createState() => _Bill_DetailState();
}

List<BillDetails> billDetail = [
  BillDetails(
      cargoType: "Stell Bars",
      packaging: "Bulk",
      paidDate: "2023-05-10",
      price: 20000,
      weight: "40 Kg",
      paymentDueDate: "2024-05-10",
      billStatus: "Unpaid"),
];

class _Bill_DetailState extends State<Bill_Detail> {
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
                context, MaterialPageRoute(builder: (context) => CargoBill()));
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
              "Bill History Detail",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: billDetail.map((detail) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 15),
                  child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5))),
                            child: ListTile(
                              title: const Text(
                                "Bill Status",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                detail.billStatus,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                          ListTile(
                            title: const Text("Payment Due Date"),
                            trailing: Text(detail.paymentDueDate),
                          ),
                          ListTile(
                            title: const Text("Cargo Type"),
                            trailing: Text(
                              detail.cargoType,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: 1,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                      ),
                ),
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 50),
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
                  child: Text(
                    "10",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: const Text(
              "Day's left",
              style: TextStyle(
                fontSize: 25,
                color: Colors.amber,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
