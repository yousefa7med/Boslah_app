import 'package:depi_graduation_project/core/functions/is_dark.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppColors.main),
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintText),
        fillColor: isDark()
            ? const Color(0xff2A2A2A)
            : AppColors.fillTextField,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.main, width: 2),
        ),
      ),
    );
  }
}
