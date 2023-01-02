// ignore_for_file: sort_child_properties_last

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../../const/constant.dart';

class categoryItem extends StatelessWidget {
  final Color color;
  final String title;
  final IconData iconMenu;
  static bool isPressed = true;
  Offset distance = isPressed ? const Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  final bkc = const Color(0xFFE7ECEF);
  categoryItem(this.color, this.title, this.iconMenu);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 20),
            child: Icon(
              iconMenu,
              color: kPrimaryColor,
              size: 70,
            ),
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: const TextStyle(color: kPrimaryColor, fontSize: 17),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFE7ECEF),
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade300,
              Colors.grey.shade400,
              Colors.grey.shade500,
            ],
            stops: [
              0.1,
              0.3,
              0.6,
              1
            ]),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA7A9AF),
            offset: distance,
            blurRadius: 30,
            spreadRadius: 0.0,
          ),
          BoxShadow(color: Colors.white, offset: -distance, blurRadius: blur),
        ],
      ),
    );
  }
}
