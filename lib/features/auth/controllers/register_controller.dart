import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';
import 'package:depi_graduation_project/core/services/supabase_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utilities/routes.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();

  final gmailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final see = true.obs;
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();
  Future<void> registerUser(
{  required  String fullName,
  required  String email,
  required  String password,}
  ) async {
    if (await hasInternet()) {
      await auth.register(fullName, email, password);
      Get.offNamed(Routes.login);
    } else {
      throw AppException(msg: "Please Check your internet connection");
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
