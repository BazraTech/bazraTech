import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:flutter/material.dart';

import '../../shared/customAppbar.dart';
import '../Navigation_Active.dart';

class Active_Work extends StatefulWidget {
  const Active_Work({super.key});
  @override
  State<Active_Work> createState() => _Active_WorkState();
}

class _Active_WorkState extends State<Active_Work> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Available Cars",
        showBackButton: true,
      ),
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              height: screenHeight * 0.5,
              width: screenWidth,
              child: Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.green.shade900, width: 10),
                  )),
                  child: ClipRRect(
                    child: Container(
                      width: 220,
                      height: 80,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Available Car right now is 20",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.5,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BottomNav_Active()),
                        );
                      },
                      child: CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BottomNav_Active()),
                            );
                          },
                          text: "Order")),
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: CustomButton(onPressed: () {}, text: "Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
