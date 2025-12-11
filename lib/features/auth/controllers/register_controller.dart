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
