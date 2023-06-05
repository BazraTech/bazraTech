import 'dart:math';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';

class ownerReport extends StatefulWidget {
  @override
  State<ownerReport> createState() => _ownerReportState();
}

class _ownerReportState extends State<ownerReport> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.chevron_back),
                    iconSize: 23,
                  )
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
