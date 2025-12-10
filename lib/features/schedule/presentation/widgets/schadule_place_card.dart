import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class SchadulePlaceCard extends GetView<ScheduleController> {
  const SchadulePlaceCard(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------- IMAGE + BADGES --------------------
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: controller.viewedSchedules[index].image != null
                    ? CachedNetworkImage(
                        imageUrl:
                            controller.viewedSchedules[index].image!, // الصورة
                        height: 150.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        height: 180.h,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50.r,
                          color: Colors.grey,
                        ),
                      ),
              ),

              // badge left
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      const Gap(5),
                      Text(
                        "In Progress",
                        style: AppTextStyle.regular14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // badge right
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Today",
                    style: AppTextStyle.regular14.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          // -------------------- TITLE --------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              controller.viewedSchedules[index].name ?? '',
              style: AppTextStyle.semiBold20,
            ),
          ),

          // -------------------- NOTE --------------------
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),

            child: 
                Text(
                    controller.allSchedules[index].note,
                    style: AppTextStyle.regular14.copyWith(
                      height: 1.4,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
          ),
        ],
      ),
    );
  }
}
