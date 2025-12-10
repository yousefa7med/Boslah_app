import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/utilities/routes.dart';
import 'package:depi_graduation_project/core/widgets/filter.dart';
import 'package:depi_graduation_project/features/home/controllers/home_controller.dart';
import 'package:depi_graduation_project/features/home/presentation/widgets/home_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilities/app_colors.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.chatbot);
        },
        backgroundColor: AppColors.main, // أو أي لون تحبه
        child: Icon(
          Icons.smart_toy,
        ), // أيقونة AI، ممكن تغيرها لأي أيقونة تناسبك
        tooltip: 'Chatbot',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.search);
                    },
                    icon: Icon(
                      Icons.search,
                      color: AppColors.main.withAlpha(200),
                      size: 35.r,
                    ),
                  ),
                ],
              ),

              const Gap(15),

              Filter(filterList: controller.filterList),

              const Gap(10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Nearby Attractions', style: AppTextStyle.bold26),
              ),
              const Gap(10),
              Obx(() {
                if (controller.places.isEmpty) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      itemBuilder: (ctx, index) => shimmerItem(),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(10);
                      },
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.places.length,
                    itemBuilder: (ctx, index) => HomePlaceCard(index),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Gap(10);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
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
              child: Container(
                width: double.infinity,
                height: 180.h,
                color: Colors.grey,
              ),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Container(height: 25.h, width: 180.w, color: Colors.grey),
            ),
            Gap(10.h),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(height: 20.h, width: 240.w, color: Colors.grey),
            ),
            Gap(15.h),
          ],
        ),
      ),
    );
  }
}
