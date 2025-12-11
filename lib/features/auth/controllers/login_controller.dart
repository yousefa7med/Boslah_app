import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';
// import 'package:depi_graduation_project/features/auth/supabase_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/supabase_services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final see = true.obs;
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    if (!await hasInternet()) {
      throw AppException(msg: "Please Check your internet connection");
    }

    try {
      isLoading.value = true;
      await auth.login(email, password);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
