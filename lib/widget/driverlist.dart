

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/communication.dart';

class Feeddriver extends StatefulWidget {
  final Function? onChange;
  Feeddriver({super.key, required this.onChange});

  @override
  State<Feeddriver> createState() => _FeeddriverState();
}

class _FeeddriverState extends State<Feeddriver> {
  @override
  Widget build(BuildContext context) {
    Communications carAttributes = Provider.of<Communications>(context);

    return Scaffold(
      body: Card(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                carAttributes.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              // Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 0, 2, 0),
                child: Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      activeColor: Colors.green,
                      value: carAttributes.value,
                      onChanged: (value) => setState(() {
                            carAttributes.value = !carAttributes.value;
                          })),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(carAttributes.Status)],
          ),
        ],
      )),
    );
  }
}