import 'package:depi_graduation_project/core/widgets/filter.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:depi_graduation_project/features/schedule/presentation/widgets/schadule_place_card.dart';
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
        showSnackBar(context, msg);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.allSchedules.isEmpty) {
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
                const Gap(20),
                Filter(filterList: controller.filterList),
                const Gap(20),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.allSchedules.length,
                    itemBuilder: (_, index) =>
                        Column(children: [SchadulePlaceCard(index)]),
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
