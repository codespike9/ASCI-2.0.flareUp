import 'package:flutter/material.dart';

import '../config/pallete.dart';

class SigninTextField extends StatelessWidget {
  const SigninTextField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText,
      required this.prefixIcon});
  final String hintText; // Parameter for hint text
  final TextInputType keyboardType; // Parameter for keyboard type
  final bool obscureText; // Parameter for obscuring the text
  final IconData prefixIcon; // Parameter for the prefix icon

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Palette.iconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Palette.textColor1),
      ),
    );
  }
}
