import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void showSnackBar(String message) {
  Get.rawSnackbar(
    messageText: Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),

    duration: const Duration(seconds: 1, milliseconds: 800),

    snackPosition: SnackPosition.BOTTOM,

    margin: EdgeInsets.only(
      right: 30,
      left: 30,
      bottom: Get.mediaQuery.viewInsets.bottom + 30,
    ),

    borderRadius: 20,
    animationDuration: const Duration(milliseconds: 300),

    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,

    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),

    snackStyle: SnackStyle.FLOATING,
  ); // Show snackbar for past time
}
