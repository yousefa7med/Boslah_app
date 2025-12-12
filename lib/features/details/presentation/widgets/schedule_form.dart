import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/core/widgets/app_button.dart';

import 'package:Boslah/features/details/controllers/details_controller.dart';
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
                      Expanded(
                        child: Text(
                          'Date',
                          style: TextStyle(color: Colors.white),
                        ),
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
                      final today = DateTime.now();
                      final pickedDate = DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                      );
                      final currentDate = DateTime(
                        today.year,
                        today.month,
                        today.day,
                      );

                      if (pickedDate.isBefore(currentDate)) {
                        // Show snackbar for invalid date
                        showSnackBar(
                          "Invalid date You cannot choose a past date. Please select another date.",
                        );
                        // showSnackBar( // i don't know why it's not working
                        //   context,
                        //   "You cannot choose a past date. Please select another date.",
                        // );
                      } else {
                        // Accept the date
                        controller.dateController.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        print(controller.dateController.text);
                      }
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
                      Expanded(
                        child: Text(
                          'time',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    // final picked = await showTimePicker(
                    //   context: context,
                    //   initialTime: TimeOfDay.now(),
                    // );
                    // if (picked != null) {
                    //   print(picked.format(context));
                    //   controller.timeController.text = picked.format(context);
                    // }
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      // Parse the currently picked date from your dateController
                      final dateParts = controller.dateController.text.split(
                        '-',
                      );
                      if (dateParts.length == 3) {
                        final pickedDate = DateTime(
                          int.parse(dateParts[0]),
                          int.parse(dateParts[1]),
                          int.parse(dateParts[2]),
                        );

                        final now = DateTime.now();
                        final currentDate = DateTime(
                          now.year,
                          now.month,
                          now.day,
                        );

                        // Only validate if picked date is today
                        if (pickedDate.isAtSameMomentAs(currentDate)) {
                          // Create DateTime for picked time today
                          final pickedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          if (pickedDateTime.isBefore(now)) {
                   
                            showSnackBar(
                              "You cannot choose a past time for today. Please select another time.",
                            );
                            return; // exit without assigning the time
                          }
                        }
                      }

                      // Assign time if valid
                      controller.timeController.text = pickedTime.format(
                        context,
                      );
                      print("Picked time: ${controller.timeController.text}");
                    }
                  },
                ),
              ),
            ],
          ),
           Gap(50.h),
          AppButton(
            onPressed: () async {
              if (controller.dateController.text.isEmpty ||
                  controller.timeController.text.isEmpty) {
                print(controller.dateController.text);
                print(controller.timeController.text);
                Get.back();
                showSnackBar('please fill Data and Time');
                return;
              }
              try {  Get.back();
                print('11111111111111111111111');
                await controller.addSchdule();
              

                print('2222222222222222222222222');
                showSnackBar('Schedule Added Successfully');
              } catch (e) {
                print('2222222222222222222222222');
                Get.back();

                showSnackBar(e.toString());
              }
            },

            child: const Text('confirm', style: TextStyle(color: Colors.white)),
          ),

           Gap(25.h),
        ],
      ),
    );
  }
}
