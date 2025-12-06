import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isDark() {
  print(Get.theme.colorScheme.surface);
  return Get.theme.brightness == Brightness.dark;
}
