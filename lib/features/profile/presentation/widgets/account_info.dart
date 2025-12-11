
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/profile/controllers/profile_controller.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class AccountInfo extends GetView<ProfileController> {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 70,
              width: Get.width,
              decoration: const BoxDecoration(
                color: AppColors.main,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Account Information',
                  style: AppTextStyle.bold26.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Gap(15),
            Obx(() {
              return buildRow(
                Icons.person,
                massage: 'Full Name',
                des: controller.fullName.value,
              );
            }),
            const Gap(10),
            const Divider(color: Colors.grey),
            buildRow(
              Icons.email_outlined,
              massage: 'Email Address',
              des: cloud.auth.currentUser!.email,
            ),
            const Gap(25),
          ],
        ),
      ),
    );
  }

  Row buildRow(IconData icon, {String? massage, String? des}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.main, size: 30),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                massage!,
                style: AppTextStyle.regular20.copyWith(color: Colors.grey),
              ),
              Text(des!, style: AppTextStyle.regular18,),
            ],
          ),
        ),
      ],
    );
  }
}
