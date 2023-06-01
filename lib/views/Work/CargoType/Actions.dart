import 'package:flutter/material.dart';

import '../../../shared/constant.dart';
import '../Acticve_Work.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    return GridView(
      // ignore: sort_child_properties_last
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Active_Work()));
            }),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 254, 250),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isPressed
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ]
                        : null),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Load",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Active_Work()));
            }),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 254, 250),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isPressed
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 25,
                              spreadRadius: 1,
                            ),
                          ]
                        : null),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "UnLoad",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Active_Work()));
            }),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 254, 250),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isPressed
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ]
                        : null),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "DepArrived",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Active_Work()));
            }),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 254, 250),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isPressed
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(4, 4),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                          ]
                        : null),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "DestArrived",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          child: InkResponse(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Active_Work()));
            }),
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isPressed
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(3, 3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Departure",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Roboto',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4.5),
        maxCrossAxisExtent: 200,
      ),
    );
  }
}
