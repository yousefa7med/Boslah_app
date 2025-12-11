import 'package:Boslah/core/widgets/filter.dart';
import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:Boslah/features/schedule/presentation/widgets/schedule_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/functions/snack_bar.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    ever(controller.error, (msg) {
      if (msg != null) {
        showSnackBar(msg);
      }
    });

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Scheduling',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                const Gap(32),
                Filter(filterList: controller.filterList),
                const Gap(20),
                Obx(() {
                  if(controller.isLoading.value){
                    return Expanded(
                      child: ListView.separated(
                          itemCount: 5,
                          itemBuilder: (_, index) =>shimmerItem(),
                          separatorBuilder: (BuildContext context, int index) => const Gap(10)
                      ),
                    );
                  }
                  return Expanded(
                    child: controller.viewedSchedules.isEmpty
                        ? const Center(
                      child: Text('No schedules for this filter'),
                    )
                        : ListView.separated(
                      itemCount: controller.viewedSchedules.length,
                      itemBuilder: (_, index) =>
                          Column(children: [SchedulePlaceCard(index)]),
                      separatorBuilder: (BuildContext context, int index) =>
                      const Gap(10),
                    ),
                  );
                }),
              ],
            ),
          )
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
