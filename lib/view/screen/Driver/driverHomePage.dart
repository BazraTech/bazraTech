import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.all(8.0),
              height: screenHeight * 0.45,
              child: Card(
                child: Column(children: [
                  Container(
                    child: Column(children: [
                      ListTile(
                        title: Text("Summary"),
                        subtitle: Text("personal"),
                        trailing: Icon(Icons.date_range),
                      ),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      ListTile(
                        title: Text("Distance"),
                        subtitle: Text("Alex"),
                        trailing: Text("20 Km"),
                      ),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      ListTile(title: Text("Amount"), trailing: Text("0 Br")),
                      Divider(
                        color: kPrimaryColor,
                      ),
                      ListTile(title: Text("Trip"), trailing: Text("1")),
                      Divider(
                        color: kPrimaryColor,
                      ),
                    ]),
                  )
                ]),
              ),
            ),
            Container(
              height: screenHeight * 0.14,
              width: screenWidth,
              padding: EdgeInsets.all(8),
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Trips to review"),
                      Text(
                        "The trips are already included in your summary.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                    ]),
              ),
            )
          ],
        ));
  }
}
