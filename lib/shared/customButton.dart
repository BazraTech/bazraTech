import 'package:cargo/shared/constant.dart';
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
        colors: [kPrimaryColor],
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
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 20.0),
            padding: EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Align(
            alignment: alignment,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 1,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
