// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:get/get.dart';
//
// import '../../features/details/presentation/widgets/schedule_form.dart';
//
// Future<void> checkExactAlarmAndOpenForm(BuildContext context) async {
//   // Only needed on Android
//   if (Platform.isAndroid) {
//     final intent = AndroidIntent(
//       action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
//     );
//
//     try {
//       await intent.launch();
//     } catch (e) {
//       print("Cannot open exact alarm settings: $e");
//       // optionally show a snackbar or alert to the user
//       Get.snackbar(
//         "Permission required",
//         "Please allow exact alarms in system settings to get reminders on time.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   // After permission check/opening settings, show the ScheduleForm
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (_) => Padding(
//       padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
//       child: const ScheduleForm(),
//     ),
//   );
// }
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:get/get.dart';
import '../../features/details/presentation/widgets/schedule_form.dart';

Future<void> checkExactAlarmAndOpenForm(BuildContext context) async {
  // Only check for Android 12+ (API 31)
  bool openSettings = false;
  if (Platform.isAndroid) {
    // You can use Platform.version to check API level
    final version = int.tryParse(Platform.version.split(" ")[0]) ?? 0;
    if (version >= 31) {
      // We don't have a way to know exact alarm status, so assume user may need to enable it
      openSettings = true;
    }
  }

  if (openSettings) {
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );

    try {
      await intent.launch();
    } catch (e) {
      print("Cannot open exact alarm settings: $e");
      Get.snackbar(
        "Permission required",
        "Please allow exact alarms in system settings to get reminders on time.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Open ScheduleForm bottom sheet after checking/asking for permission
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
      child: const ScheduleForm(),
    ),
  );
}
