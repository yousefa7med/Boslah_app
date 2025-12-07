
import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/home/controllers/home_controller.dart';
import 'package:depi_graduation_project/main.dart';
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
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.details, arguments: controller.places[index]);
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
              child: controller.places[index].image != null?

              CachedNetworkImage(imageUrl:  controller.places[index].image!,  
                       width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.fill,)
         
                  : Container(
                      width: double.infinity,
                      height: 180.h,
                      color: Colors.grey[300],
                      child:  Icon(
                        Icons.image_not_supported,
                        size: 50.r,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Text(
                controller.places[index].name,
                style: AppTextStyle.semiBold24,
              ),
            ),
            controller.places[index].desc != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      '${controller.places[index].desc}',
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
