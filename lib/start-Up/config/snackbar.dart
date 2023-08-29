import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {required Null Function() callback}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
