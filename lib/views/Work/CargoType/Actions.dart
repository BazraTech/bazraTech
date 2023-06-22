import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared/constant.dart';
import '../ActiveCargo.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  bool isPressed = true;
  
  void _showSweetAlert(BuildContext context, AlertType alertType, String title,
      String description) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (alertType == AlertType.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ActiveCargo()),
              );
            } else if (alertType == AlertType.error) {
              Navigator.pop(context);
            }
          },
          width: 120,
        ),
      ],
    ).show();
  }

  ApproveCargoState(String action) async {
    const url = 'http://64.226.104.50:9090/Api/SignUp/Cargo';

    // Define your request data as a Map
    Map requestData = {
      'cargoState': "${action}",
    };
    print(requestData);

    print(requestData);

    print("********************************");
    print('Token: $requestData');
    print("********************************");
    try {
      String body = json.encode(requestData);

      // Make the request and handle the response
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );
      print(response.body);
      print(response.statusCode);
      final Map jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        _showSweetAlert(
            context, AlertType.success, 'Success', jsonResponse['message']);
      } else {
        _showSweetAlert(
            context, AlertType.error, 'Error', jsonResponse['message']);
      }
    } catch (e) {
      _showSweetAlert(context, AlertType.error, 'Error',
          'An error occurred, please check your internet connection.');
    }
  }
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
            //  ApproveCargoState(action)
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
