import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

void appDialog({required String msg}) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Enable Location'),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () async {
            Get.back();

            if ("Location Permission Required" == msg) {
              await Geolocator.requestPermission();
            } else if ("Please Open Location" == msg) {
              await Geolocator.openLocationSettings();
            } else if ('Location Permanently Denied' == msg) {
              await Geolocator.openAppSettings();
            }
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}