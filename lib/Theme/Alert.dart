import 'package:bazralogin/Route/Routes.dart';
import 'package:bazralogin/screen/Driver/driverBottomnav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/constant.dart';
import '../screen/Bottom/Bottom.dart';

class AlertDialoug {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  height: 20,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    message,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    ),
                  ),
                  height: 30,
                  child: TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog

                      // Navigator.of(context).pop(true);
                      // Get.offAllNamed('/home');
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} // comman alert

class alertutils {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  height: 20,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    message,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => BottomNav()),
                      (route) => false,
                    ); //

                    // Navigator.of(context).pop(true);
                    // Get.offAllNamed('/home');
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// alert dialoug for driver
class alertutilsfordriver {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  height: 20,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    message,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => driverBottomn()),
                      (route) => false,
                    ); //

                    // Navigator.of(context).pop(true);
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
