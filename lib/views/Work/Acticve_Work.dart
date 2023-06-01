import 'package:cargo/Components/Home_Page.dart';
import 'package:cargo/shared/constant.dart';
import 'package:cargo/shared/customButton.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../shared/customAppbar.dart';
import '../Navigation_Active.dart';

class Active_Work extends StatefulWidget {
  const Active_Work({super.key});
  @override
  State<Active_Work> createState() => _Active_WorkState();
}

class _Active_WorkState extends State<Active_Work> {
  bool isChecked = false;

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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                margin: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 20),
                child: Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.7),
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                            offset: const Offset(
                              6, // Move to right 7.0 horizontally
                              8, // Move to bottom 8.0 Vertically
                            ))
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "SORRY FOR THE MOMENT",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade500,
                                fontFamily: 'Roboto',
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 8),
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: CircleAvatar(
                                      radius:
                                          40, // Adjust the size of the circle
                                      backgroundColor:
                                          Color.fromARGB(235, 142, 140, 140),
                                      child: Text(
                                        "30",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white.withOpacity(0.7),
                                          fontFamily: 'Roboto',
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(top: 20),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "AVAILABLE CARS",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Checkbox(
                                            value: isChecked,
                                            checkColor: Colors.white,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = value!;
                                              });
                                            }),
                                      ),
                                      const Text(
                                        "I confirm that I have read all the  terms \n of  service and I agree to all of it ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: kPrimaryColor,
                                            fontFamily: 'Roboto',
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 23),
                                alignment: Alignment.center,
                                width: screenWidth * 0.4,
                                child: CustomButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BottomNav_Active()),
                                      );
                                    },
                                    text: "Order"),
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: CustomButton(
                                    onPressed: () {}, text: "Cancel"),
                              ),
                            ],
                          ),
                        ),
                        // Dotted line
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
