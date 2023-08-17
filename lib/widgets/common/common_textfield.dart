import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Set the border radius
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 2.0, // Set the border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0), // Set the border radius
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 2.0, // Set the border width
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
