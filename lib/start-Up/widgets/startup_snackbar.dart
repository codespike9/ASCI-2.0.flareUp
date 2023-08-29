import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, {Function? callback}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
  if (callback != null) {
    callback();
  }
}
