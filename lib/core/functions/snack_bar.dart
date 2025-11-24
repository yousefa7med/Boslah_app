import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1, milliseconds: 500),
      content: Center(child: Text(message)),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      margin: EdgeInsets.only(
        right: 30,
        left: 30,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
      ),
      elevation: 6,
    ),
  );
}
