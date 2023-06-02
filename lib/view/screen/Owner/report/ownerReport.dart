import 'dart:math';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';

class ownerReport extends StatelessWidget {
  final Function(int)  ? onContainerTap;
ownerReport({this.onContainerTap});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView.builder(
      itemCount: 5, // Number of containers to display
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onContainerTap!(index);
          },
          child: Container(
            height: 100,
            color: Colors.blue,
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Container $index',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      },
    )
    );
  }
}
