import 'package:flutter/material.dart';

class CustomTextFieldForm extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController textController;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextStyle textStyle;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  const CustomTextFieldForm({
    super.key,
    this.validator,
    required this.textStyle,
    required this.hintText,
    this.icon,
    required this.textController,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    required this.obscureText,
    this.isPassword = false,
  });

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  bool obscureText = true;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.textController,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(),
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
      ),
    );
  }
}
