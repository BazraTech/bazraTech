import 'package:bazralogin/Model/Vehicle.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../const/constant.dart';

class Feedlist extends StatelessWidget {
  Feedlist({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.height;
    (context);

    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.19,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color.fromRGBO(240, 240, 244, 1),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Text(' hello'),
            ],
          ),
        ));
  }
}
