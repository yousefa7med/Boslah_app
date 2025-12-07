import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/widgets/app_button.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class ScheduleForm extends StatelessWidget {
  const ScheduleForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(25.h),

          Text("Schedule Visit", style: AppTextStyle.bold22),

          Gap(20.h),

          const Text("Note (optional)"),
          Gap(8.h),

          TextField(
            controller: controller.noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Leave a note...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.main, width: 2.8),
              ),
            ),
          ),
          Gap(50.h),

          Row(
            children: [
              SizedBox(
                width: (Get.width - 52) / 2,
                child: AppButton(
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white),
                      Gap(10),
                      Text(
                        'Choose the date',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2050),
                    );
                    if (picked != null) {
                      controller.dateController.text =
                          "${picked.year}-${picked.month}-${picked.day}";
                    }
                  },
                ),
              ),
              const Gap(20),
              SizedBox(
                width: (Get.width - 52) / 2,

                child: AppButton(
                  child: const Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      Gap(7),
                      Text(
                        'Choose the time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      print(picked.format(context));
                      controller.timeController.text = picked.format(context);
                    }
                  },
                ),
              ),
            ],
          ),
          const Gap(50),
          AppButton(
            onPressed: () async {
              if (controller.dateController.text.isEmpty ||
                  controller.timeController.text.isEmpty) {
                Get.back();
                showSnackBar(context, 'please fill Data and Time');
                return;
              }
              await controller.addSchdule();
              Get.back();
            },

            child: const Text('confirm', style: TextStyle(color: Colors.white)),
          ),

          const Gap(25),
        ],
      ),
    );
  }
}
