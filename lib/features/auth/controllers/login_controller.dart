import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/services/supabase_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utilities/routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final see = true.obs;
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();
  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    final error = await auth.login(email, password);
    if (error != null) {
      showSnackBar(context, error);
    } else {
      showSnackBar(context, "Logged in successfully!");
      Get.offNamed(Routes.home);
    }
  }
}
