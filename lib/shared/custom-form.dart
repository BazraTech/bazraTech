import 'package:flutter/material.dart';

class CustomTextFieldForm extends StatefulWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextStyle textStyle;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool showSuffixIcon;
  final TextStyle hintTextStyle;
  final Function(bool)? onFocusChange;
   // added onFocusChange callback
  const CustomTextFieldForm({
    super.key,
    this.isPassword = false,
    this.showSuffixIcon = false,
    this.validator,
    required this.hintTextStyle,
    required this.textStyle,
    required this.hintText,
    required this.textController,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    required this.obscureText,
    this.onFocusChange, 

  });

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  bool obscureText = true;
  EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(10, 20, 10, 10);

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void setPadding(bool isFocused) {
    setState(() {
      contentPadding = isFocused
          ? const EdgeInsets.fromLTRB(0, 80, 0, 0)
          : const EdgeInsets.all(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.textController,
      validator: widget.validator,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        labelText: widget.hintText,
        fillColor: Colors.white,
        filled: true,
        // contentPadding: contentPadding,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 20),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(),
        suffixIcon: widget.isPassword && widget.showSuffixIcon
            ? IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: showPassword,
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
