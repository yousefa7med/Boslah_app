import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/features/home/controllers/home_controller.dart';
import 'package:Boslah/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/routes.dart';

class HomePlaceCard extends GetView<HomeController> {
  const HomePlaceCard(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    log(controller.viewedPlaces[index].categories[0]);
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.details, arguments: controller.viewedPlaces[index]);
        print(cloud.auth.currentUser!.id);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child:
                  controller.viewedPlaces[index].isAssetPath(
                    controller.viewedPlaces[index].image!,
                  )
                  ? Image.asset(
                      controller.viewedPlaces[index].image!,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.viewedPlaces[index].image!,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.fill,
                    ),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Text(
                controller.viewedPlaces[index].name,
                style: AppTextStyle.semiBold24,
              ),
            ),
            controller.viewedPlaces[index].desc != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      '${controller.viewedPlaces[index].desc}',
                      style: AppTextStyle.semiBold18.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Gap(5),
          ],
        ),
      ),
    );
  }
}
