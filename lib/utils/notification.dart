import 'package:flutter/material.dart';

class Notify {
  static void showMessage(BuildContext context, String alertMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(alertMessage)),
      duration: const Duration(milliseconds: 900),
      width: 150.0,
      padding: const EdgeInsets.all(10.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }
}
