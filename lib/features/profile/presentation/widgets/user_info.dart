
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/profile/controllers/profile_controller.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class UserInfo extends GetView<ProfileController> {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Obx(() {
                return CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.main,
                  child: Text(
                    controller.splitName(controller.fullName.value),
                    style: AppTextStyle.bold24.copyWith(
                      color: Colors.white,
                      fontSize: 28.sp,
                    ),
                  ),
                );
              }),
              const Gap(10),
              Obx(() {
                return Text(
                    controller.fullName.value, style: AppTextStyle.medium26);
              }),
              const Gap(5),
              Text(
                cloud.auth.currentUser!.email ?? "",
                style: AppTextStyle.medium20.copyWith(color: Colors.grey),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
