import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/widgets/app_button.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/widgets/app_textFormField.dart';
import 'package:depi_graduation_project/features/auth/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/assets.dart';
import '../../helper/validator.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(70.h),
                  SvgPicture.asset(Assets.logo, height: 90.r),
                  const Gap(10),
                  Text(
                    'Create an Account!',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(50.h),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UserName', style: AppTextStyle.regular18),
                        const Gap(4),

                        AppTextFormField(
                          controller: controller.nameController,
                          hintText: 'Enter your username',
                          validator: Validator.signupNameValidator(),
                        ),
                        const Gap(15),
                        Text('Email', style: AppTextStyle.regular18),
                        const Gap(4),

                        AppTextFormField(
                          controller: controller.gmailController,
                          hintText: 'Enter your email',
                          validator: Validator.emailValidator(),
                        ),
                        const Gap(15),
                        Text('Password', style: AppTextStyle.regular18),
                        const Gap(4),

                        PasswordTextField(
                          controller: controller.passwordController,
                          hintText: 'Enter your password',
                          validator: Validator.signupPasswordValidator(),
                        ),
                        const Gap(15),
                        Text('Password', style: AppTextStyle.regular18),
                        const Gap(4),

                        PasswordTextField(
                          controller: controller.confirmPasswordController,
                          hintText: 'Confirm your password',
                          validator: Validator.confirmPasswordValidator(
                            orgPasswordGetter: () =>
                                controller.passwordController.text,
                          ),
                        ),
                        const Gap(30),
                        Obx(() {
                          return AppButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                              if (controller.formKey.currentState!.validate()) {
                                try {
                                  await controller.registerUser(
                                    fullName: controller.nameController.text,
                                    email: controller.gmailController.text,
                                    password: controller.passwordController.text,
                                  );

                                  Get.back();

                                  showSnackBar(context, "Account created successfully!");
                                } on AppException catch (e) {
                                  showSnackBar(context, e.msg);
                                }
                              }
                            },
                            child: controller.isLoading.value
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: AppTextStyle.regular16,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Login',
                                style: AppTextStyle.medium16.copyWith(
                                  color: AppColors.main,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
