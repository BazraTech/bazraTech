import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class categoryItem extends StatelessWidget {
  final Color color;
  final String title;
  final IconData iconMenu;
  categoryItem(this.color, this.title, this.iconMenu);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top:20),
            decoration: BoxDecoration(),
            child: Icon(
              iconMenu,
              color: Colors.white,
              size: 70,
            ),
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: TextStyle(color: Colors.white,
              fontSize: 17),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
