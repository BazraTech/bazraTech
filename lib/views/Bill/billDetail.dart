import 'package:flutter/material.dart';
import '../../model/bill_details.dart';
import '../../shared/customAppbar.dart';



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
      paymentDueDate: "2024-05-10"),
];

class _Bill_DetailState extends State<Bill_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail About Bill Status",
        showBackButton: true,
      ),
      body: Column(
        children: billDetail.map((detail) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 16.0, color: Colors.green.shade900),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text("Cargo Type"),
                          trailing: Text(detail.cargoType),
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
                          title: const Text("Paid Date"),
                          trailing: Text(detail.paymentDueDate),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }).toList(),
      ),
    );
  }
}
