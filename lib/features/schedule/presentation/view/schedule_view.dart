import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:depi_graduation_project/features/schedule/presentation/widgets/schadule_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/functions/snack_bar.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_text_style.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Scheduling',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                Gap(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCardFilttring(1, 'All'),
                      buildCardFilttring(
                        2,
                        'Upcoming',
                        IconData: Icons.pending_outlined,
                      ),
                      buildCardFilttring(
                        3,
                        'Completed',
                        IconData: Icons.done_all,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.allSchedules.length,
                    itemBuilder: (_, index) =>
                        Column(children: [SchadulePlaceCard(index)]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Gap(20),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildCardFilttring(int index, String label, {IconData}) {
    return Obx(() {
      bool isSelected = controller.selectedCard.value == index;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: () {
            controller.selectedCard.value = index;
            // calling the api
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: isSelected ? AppColors.main : Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  IconData != null
                      ? Row(
                          children: [
                            Icon(
                              IconData,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            const Gap(10),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
