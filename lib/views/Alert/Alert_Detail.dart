import 'package:flutter/material.dart';
import '../../model/alert.dart';
import '../../shared/customAppbar.dart';

class Alert_Detail extends StatefulWidget {
  const Alert_Detail({super.key});

  @override
  State<Alert_Detail> createState() => _Alert_DetailState();
}

final List<Alert> alert = [
  Alert(
      driverName: "Alex",
      plateNumber: "08231",
      alertLocation: "Dire Dawa",
      alertType: "Off Road"),
];

class _Alert_DetailState extends State<Alert_Detail> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail About Bill Status",
        showBackButton: true,
      ),
      body: Column(
        children: alert.map((detail) {
          return SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 50, left: 10, right: 10),
                child: Card(
                  child: Container(
                    height: screenHeight * 0.4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom:
                          BorderSide(color: Colors.green.shade500, width: 16),
                    )),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Plate Number"),
                          trailing: Text(detail.plateNumber),
                        ),
                        ListTile(
                          title: Text("Alert Type"),
                          trailing: Text(detail.alertType),
                        ),
                        ListTile(
                          title: Text("Alert Location"),
                          trailing: Text(detail.alertLocation),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        }).toList(),
      ),
    );
  }
}
