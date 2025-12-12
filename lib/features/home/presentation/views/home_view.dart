import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/core/utilities/routes.dart';
import 'package:Boslah/core/widgets/filter.dart';
import 'package:Boslah/features/home/controllers/home_controller.dart';
import 'package:Boslah/features/home/presentation/widgets/home_place_card.dart';
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

        backgroundColor:
            AppColors.main, // أيقونة AI، ممكن تغيرها لأي أيقونة تناسبك
        tooltip: 'Chatbot', // أو أي لون تحبه
        child: const Icon(Icons.smart_toy),
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
                if (controller.isLoading.value) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      itemBuilder: (ctx, index) => shimmerItem(),
                      separatorBuilder: (_, __) => const Gap(10),
                    ),
                  );
                }
                if (controller.viewedPlaces.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No data available',
                        style: AppTextStyle.bold26.copyWith(
                          color: const Color.fromARGB(147, 158, 158, 158),
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.refreshPlaces,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.viewedPlaces.length,
                      itemBuilder: (ctx, index) => HomePlaceCard(index),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(10);
                      },
                    ),
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
