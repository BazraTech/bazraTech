import 'package:flutter/material.dart';

import '../const/constant.dart';
import '../view/screen/Bottom/Bottom.dart';

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color.fromARGB(255, 168, 123, 7)),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Error",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
    ),
    content: const Text(
      "Invalid User Name Or Passowrd",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class AlertDialoug {
  showAlertDilougs(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              titlePadding: EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.all(10),
                color: kPrimaryColor,
                child: Container(
                  height: 40,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text(
                      'Updated Successfully ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
