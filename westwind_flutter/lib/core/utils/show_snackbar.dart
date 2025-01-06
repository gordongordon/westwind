import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration( milliseconds: 6 * 1000 ),
    ),
  );
}