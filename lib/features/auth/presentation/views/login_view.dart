import 'package:Boslah/core/database/models/profile.dart';
import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/is_dark.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/core/utilities/app_colors.dart';
import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/core/widgets/app_button.dart';
import 'package:Boslah/features/auth/controllers/login_controller.dart';
import 'package:Boslah/features/auth/presentation/widgets/app_textFormField.dart';
import 'package:Boslah/features/auth/presentation/widgets/password_text_field.dart';
import 'package:Boslah/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/assets.dart';
import '../../../../core/utilities/routes.dart';
import '../../helper/validator.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                  SvgPicture.asset(Assets.logo, height: 90.h),
                  const Gap(10),
                  Text(
                    'Welcome Back!',
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
                        Text('Email', style: AppTextStyle.regular18),
                        const Gap(4),
                        AppTextFormField(
                          hintText: 'Enter your email',
                          controller: controller.emailController,
                          validator: Validator.emailValidator(),
                        ),
                        const Gap(15),
                        Text('Password', style: AppTextStyle.regular18),
                        const Gap(4),

                        PasswordTextField(
                          hintText: 'Enter your password',
                          controller: controller.passwordController,
                          validator: Validator.loginPasswordValidator(),
                        ),

                        const Gap(10),
                        // TextButton(
                        //   onPressed: () {
                        //     //!forget password func
                        //   },
                        //   child: Text(
                        //     'Forget Password?',
                        //     style: AppTextStyle.regular16.copyWith(
                        //       color: AppColors.main,
                        //     ),
                        //   ),
                        // ),
                        Obx(() {
                          return AppButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      try {
                                        await controller.loginUser(
                                          email:
                                              controller.emailController.text,
                                          password: controller
                                              .passwordController
                                              .text,
                                        );

                                        Get.offNamed(Routes.main);

                                        await database.profiledao.insertUser(
                                          Profile(
                                            userId: cloud.auth.currentUser!.id,
                                          ),
                                        );

                                        showSnackBar("Logged in successfully!");
                                      } on AppException catch (e) {
                                        showSnackBar(e.msg);
                                      } catch (e) {
                                        showSnackBar(e.toString());
                                      }

                                      print(cloud.auth.currentUser);
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
                                    'Login',
                                    style: AppTextStyle.regular20.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        }),
                        Gap(20.h),

                        AppButton(
                          onPressed: () {
                            Get.toNamed(Routes.register);
                          },

                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.main,
                            backgroundColor: isDark()
                                ? const Color(0xff2A2A2A)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              side: const BorderSide(
                                color: AppColors.main,
                                width: 2.5,
                              ),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: AppTextStyle.regular20,
                          ),
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
