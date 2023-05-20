import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final BoxDecoration decoration;
  final Alignment alignment;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.padding = const EdgeInsets.all(16.0),
    this.decoration = const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2DBD3A), Color(0xFF0BA502)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: padding,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Align(
            alignment: alignment,
            child: Text(text),
          ),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 20.0),
            padding: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}
