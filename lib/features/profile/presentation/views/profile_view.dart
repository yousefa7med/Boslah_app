import 'package:depi_graduation_project/core/services/supabase_services/auth_service.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/features/profile/controllers/profile_controller.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../../../core/utilities/app_text_style.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () {
                  //themes code
                  controller.themesICon.toggle();
                },
                icon: controller.themesICon.value
                    ? const Icon(Icons.sunny, color: Colors.amber)
                    : const Icon(Icons.dark_mode, color: Colors.blueAccent),
              );
            }),
            Gap(5.w),
          ],
          iconTheme: IconThemeData(color: Colors.white, size: 40.h),
          title: FittedBox(
            child: Text(
              'Profile',
              style: AppTextStyle.bold24.copyWith(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: AppColors.main,
                                child: Text(
                                  controller.splitName(
                                    controller.fullName.value,
                                  ),
                                  style: AppTextStyle.bold24.copyWith(
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Text(
                                controller.fullName.value,
                                style: AppTextStyle.medium18.copyWith(
                                  fontSize: 25,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                cloud.auth.currentUser!.email ?? "",
                                style: AppTextStyle.medium18.copyWith(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              const Gap(15),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: Get.width,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                color: AppColors.main,
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Account Information',
                                  style: AppTextStyle.bold24.copyWith(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            buildRow(
                              Icons.person,
                              massage: 'Full Name',
                              des: controller.fullName.value,
                            ),
                            const Gap(10),
                            const Divider(),
                            buildRow(
                              Icons.email_outlined,
                              massage: 'Email Address',
                              des: cloud.auth.currentUser!.email,
                            ),
                            const Gap(25),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                SizedBox(
                  width: 200,
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthService().logout();
                      Get.offNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.main,
                    ),
                    child: Text(
                      'Logout',
                      style: AppTextStyle.semiBold20.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Row buildRow(IconData icon, {String? massage, String? des}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.main, size: 30),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              massage!,
              style: AppTextStyle.regular20.copyWith(color: Colors.grey),
            ),
            Text(des!, style: AppTextStyle.regular18),
          ],
        ),
      ],
    );
  }
}
