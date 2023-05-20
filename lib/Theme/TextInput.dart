import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Widget? icon1]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      suffix: icon1,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // Specify border radius
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ), // Specify border color and width
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(5, 5)),
      backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
      shadowColor: MaterialStateProperty.all(Colors.lightBlue),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class LoginFormStyle {}
