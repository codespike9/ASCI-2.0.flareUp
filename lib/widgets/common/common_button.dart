import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color.fromARGB(211, 21, 21, 21),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null
              ? const Color.fromARGB(255, 246, 243, 243)
              : const Color.fromARGB(255, 0, 0, 0),
          fontSize: 16,
        ),
      ),
    );
  }
}
