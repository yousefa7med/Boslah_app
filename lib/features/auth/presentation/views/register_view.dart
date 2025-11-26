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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(70.h),
                SvgPicture.asset(Assets.imagesAppIcon, height: 90.h),
                const Gap(10),
                Text(
                  'Create an Account!',
                  style: TextStyle(
                    color: Colors.black,
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
                      Text(
                        'UserName',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      const Gap(4),

                      AppTextFormField(
                        controller: controller.nameController,
                        hintText: 'Enter your username',
                        validator: Validator.signupNameValidator(),
                      ),
                      const Gap(20),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      const Gap(4),

                      AppTextFormField(
                        controller: controller.gmailController,
                        hintText: 'Enter your email',
                        validator: Validator.emailValidator(),
                      ),
                      const Gap(20),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      const Gap(4),

                      PasswordTextField(
                        controller: controller.passwordController,
                        hintText: 'Enter your password',
                        validator: Validator.signupPasswordValidator(),
                      ),
                      const Gap(30),
                      AppButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            // code Auth
                          }
                        },

                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                              Get.offNamed('/login');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.sp,
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
    );
  }
}
