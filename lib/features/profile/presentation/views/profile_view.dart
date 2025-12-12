import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/core/helper/theme_manager.dart';
import 'package:Boslah/core/services/supabase_services/auth_service.dart';
import 'package:Boslah/core/widgets/app_button.dart';
import 'package:Boslah/features/profile/controllers/profile_controller.dart';
import 'package:Boslah/features/profile/presentation/widgets/account_info.dart';
import 'package:Boslah/features/profile/presentation/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_text_style.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.lightTheme.value);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () async {
                  controller.lightTheme.toggle();
                  if (!controller.lightTheme.value) {
                    Get.changeThemeMode(ThemeMode.dark);
                    await ThemeManager().setTheme(ThemeModeState.dark);
                  } else {
                    Get.changeThemeMode(ThemeMode.light);
                    await ThemeManager().setTheme(ThemeModeState.light);
                  }
                },
                icon: !controller.lightTheme.value
                    ? const Icon(Icons.sunny, color: Colors.amber)
                    : const Icon(Icons.dark_mode, color: Colors.blueAccent),
              );
            }),
            Gap(8.w),
          ],
          iconTheme: IconThemeData(color: Colors.white, size: 40.h),
          title: FittedBox(
            child: Text(
              'Profile',
              style: AppTextStyle.bold24.copyWith(fontSize: 30.r),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Gap(20.h),
              const Column(children: [UserInfo(), Gap(10), AccountInfo()]),
              Gap(30.h),

              AppButton(
                child: Obx(() {
                  return controller.isLoading.value
                      ? SizedBox(
                          height: 22.r,
                          width: 22.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Logout',
                          style: AppTextStyle.regular20.copyWith(
                            color: Colors.white,
                          ),
                        );
                }),
                onPressed: () async {
                  try {
                    controller.isLoading.value = true;
                    await AuthService().logout();
                    Get.offNamed('/login');
                  } catch (e) {
                    showSnackBar("Something went wrong while logging out");
                  } finally {
                    controller.isLoading.value = false;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
