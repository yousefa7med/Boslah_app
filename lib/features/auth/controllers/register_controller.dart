import 'package:depi_graduation_project/core/functions/snack_bar.dart';
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
    String fullName,
    String email,
    String password,
    BuildContext context,
  ) async {
    String? error = await auth.register(fullName, email, password);

    if (error != null) {
      showSnackBar(context, error);
    } else {
      showSnackBar(context, "Account created successfully!");

      Get.offNamed(Routes.login);
    }
  }
}
