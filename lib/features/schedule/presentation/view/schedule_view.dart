import 'package:Boslah/core/widgets/filter.dart';
import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:Boslah/features/schedule/presentation/widgets/schedule_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
        child: Obx(() {
          if (controller.viewedSchedules.isEmpty) {
            return const Center(child: Text('No schedules yet'));
          }

          return Padding(
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

                const Gap(12),

                const Gap(20),
                Filter(filterList: controller.filterList),
                const Gap(20),

                Expanded(
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
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
