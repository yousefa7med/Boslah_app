import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/widgets/app_button.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/widgets/app_textFormField.dart';
import 'package:depi_graduation_project/features/auth/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/assets.dart';
import '../../helper/validator.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(50),
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
                        hintText: 'Enter your username',
                        controller: controller.nameController,
                        validator: Validator.signupNameValidator(),
                      ),
                      const Gap(15),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17.sp,
                        ),
                      ),
                      const Gap(4),

                      PasswordTextField(
                        hintText: 'Enter your password',
                        controller: controller.passwordController,
                        validator: Validator.loginPasswordValidator(),
                      ),

                      const Gap(10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(color: AppColors.main, fontSize: 16),
                        ),
                      ),
                      AppButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            // code Auth
                          }
                        },

                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(20),

                      AppButton(
                        onPressed: () {
                          Get.offNamed('/register');
                        },

                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.main,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            side: const BorderSide(
                              color: AppColors.main,
                              width: 2.5,
                            ),
                          ),
                        ),
                        child: Text('Register', style: AppTextStyle.regular20),
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
