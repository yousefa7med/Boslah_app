import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';
import 'package:depi_graduation_project/core/services/supabase_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();

  final gmailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final see = true.obs;
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  Future<void> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (!await hasInternet()) {
      throw AppException(msg: "Please Check your internet connection");
    }
    try {
      isLoading.value = true;
      await auth.register(fullName, email, password);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    gmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}

// import 'package:debounce_throttle/debounce_throttle.dart';
// import 'package:depi_graduation_project/core/errors/app_exception.dart';
// import 'package:depi_graduation_project/core/functions/has_internet.dart';
// import 'package:depi_graduation_project/core/services/supabase_services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class RegisterController extends GetxController {
//   final nameController = TextEditingController();
//   final gmailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   /// ثروتل يمنع السبام — يسمح بضغطة واحدة كل ثانية
//   final Throttle<void> buttonThrottle = Throttle(
//     Duration(seconds: 1),
//     initialValue: null,
//   );
//
//   /// عشان تفتح/تقفل الباسورد
//   final see = true.obs;
//
//   final auth = AuthService();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     /// أي مرة اليوزر يضغط فيها → safeRegisterAction هتتنفذ مرة كل ثانية فقط
//     buttonThrottle.values.listen((_) {
//       _safeRegisterAction();
//     });
//   }
//
//   /// دي اللي هتتحط مكان registerUser
//   void onRegisterButtonPressed() {
//     /// دي بت-trigger الثروتل
//     buttonThrottle.setValue(null);
//   }
//
//   /// الفنكشن اللي فعلاً بتنفّذ التسجيل
//   Future<void> _safeRegisterAction() async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }
//
//     if (await hasInternet()) {
//       await auth.register(
//         nameController.text.trim(),
//         gmailController.text.trim(),
//         passwordController.text.trim(),
//       );
//     } else {
//       throw AppException(msg: "Please Check your internet connection");
//     }
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     gmailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }
// }
