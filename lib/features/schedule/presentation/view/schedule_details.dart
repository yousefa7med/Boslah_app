import 'package:cached_network_image/cached_network_image.dart';
import 'package:Boslah/core/functions/is_dark.dart';
import 'package:Boslah/features/schedule/controllers/schedule_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_text_style.dart';
import '../../../../core/widgets/app_button.dart';

class ScheduleDetails extends GetView<ScheduleDetailsController> {
  const ScheduleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final place = controller.scheduleplace;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ IMAGE ------------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: 
                     place.isAssetPath(place.image!)
                  ?
                 Image.asset(place.image!,
                    height: 260.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                 : CachedNetworkImage(
                    height: 260.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: place.image!,
                  ),
                ),

                Gap(20.h),

                // ------------------ NAME ------------------
                Text(
                  place.name!,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(10.h),

                // ------------------ DATE + TIME ------------------
                Row(
                  children: [
                    const Spacer(flex: 2),
                    Icon(Icons.calendar_today, color: Colors.grey.shade600),
                    Gap(8.w),
                    Text(
                      place.date,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(flex: 2),
                    Icon(Icons.access_time, color: Colors.grey.shade600),
                    Gap(10.w),
                    Text(
                      place.hour,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),

                Gap(35.h),

                // ------------------ NOTE TITLE ------------------

                // ------------------ NOTE VIEW / EDIT ------------------
                // ------------------ NOTES CARD ------------------
                Obx(() {
                  final isEditing = controller.editorIndicator.value;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ----------- Title + Edit Button ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Notes",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            if (!isEditing)
                              InkWell(
                                onTap: () {
                                  controller.noteCont.text = place.note;
                                  controller.editorIndicator.value = true;
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: Color(0xffDE7254),
                                      size: 18,
                                    ),
                                    Gap(4.w),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: const Color(0xffDE7254),
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        Gap(12.h),

                        if (!isEditing)
                          Text(
                            controller.note.trim().isEmpty
                                ? "No notes yet. Tap Edit to add your thoughts about this place."
                                : place.note,
                            style: TextStyle(
                              fontSize: 16.sp,
                              height: 1.4,
                              color: Colors.grey.shade700,
                              fontStyle: controller.note.trim().isEmpty
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),

                        if (isEditing) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: controller.noteCont,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: "Add your notes about this place...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Gap(16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (Get.width - 32 - 24 - 24) / 2,

                                child: AppButton(
                                  child: Text(
                                    "Save Note",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.updateNote(
                                      place.scheduleId!,
                                      controller.noteCont.text,
                                    );
                                    controller.editorIndicator.toggle();
                                  },
                                ),
                              ),

                              SizedBox(
                                width: (Get.width - 32 - 24 - 24) / 2,

                                child: AppButton(
                                  onPressed: () {
                                    controller.editorIndicator.value = false;
                                  },

                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.main,
                                    backgroundColor: isDark()
                                        ? const Color(0xff2A2A2A)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                      side: const BorderSide(
                                        color: AppColors.main,
                                        width: 2.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }),

                Gap(25.h),
                AppButton(
                  child: Text(
                    'Go to Location',
                    style: AppTextStyle.regular18.copyWith(color: Colors.white),
                  ),

                  onPressed: () async {
                    // final scheduledPlace = await database.regionplacedao.selectPlaceById(place.placeId!);
                    // Get.toNamed('/details', arguments: scheduledPlace);
                    await launchUrl(
                      mode: LaunchMode.externalApplication,
                      Uri.parse(
                        "https://www.google.com/maps/search/?api=1&query=${controller.scheduleplace.lat},${controller.scheduleplace.lng}",
                      ),
                    );
                  },
                ),
                Gap(10.h),

                // ------------------ REMOVE FROM SCHEDULE ------------------
                AppButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text('Remove Schedule'),
                        content: const Text(
                          "Are you sure you want to remove \nthis from your schedule?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              await controller.deleteSchedule(
                                place.scheduleId!,
                              );
                              Get.back();
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.main,
                    backgroundColor: isDark()
                        ? const Color(0xff2A2A2A)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      side: const BorderSide(color: AppColors.main, width: 2.5),
                    ),
                  ),
                  child: Text(
                    "Remove From Schedule",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
