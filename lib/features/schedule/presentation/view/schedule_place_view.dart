import 'package:depi_graduation_project/features/schedule/controllers/schedule_place_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../../core/utilities/app_text_style.dart';
import '../../../../core/widgets/app_button.dart';

class SchedulePlaceView
    extends GetView<SchedulePlaceController> {
  const SchedulePlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final place = controller.scheduleplace;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ IMAGE ------------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: place.image != null
                      ? Image.network(
                          place.image!,
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 260,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                          ),
                        ),
                ),

                Gap(20.h),

                // ------------------ NAME ------------------
                Text(
                  place.name ?? 'Unknown Place',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(10.h),

                // ------------------ DATE + TIME ------------------
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey.shade600,
                    ),
                    Gap(8.w),
                    Text(
                      place.date,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Gap(20.w),
                    Icon(
                      Icons.access_time,
                      color: Colors.grey.shade600,
                    ),
                    Gap(8.w),
                    Text(
                      place.hour,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),

                Gap(25.h),

                // ------------------ NOTE TITLE ------------------
                Gap(10.h),

                // ------------------ NOTE VIEW / EDIT ------------------
                // ------------------ NOTES CARD ------------------
                Obx(() {
                  final isEditing = controller.editorIndicator.value;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                    const Icon(Icons.edit, color: Color(0xffDE7254), size: 18),
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
                              fontStyle: controller.note.trim().isEmpty ? FontStyle.italic : FontStyle.normal,
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
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: "Add your notes about this place...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Gap(16.h),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.updateNote(place.scheduleId!, controller.noteCont.text);
                                    controller.editorIndicator.toggle();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffDE7254),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Save Note",
                                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                  ),
                                ),
                              ),

                              Gap(12.w),

                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    controller.editorIndicator.value = false;
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    side: BorderSide(color: Colors.grey.shade400),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ],
                    ),
                  );
                }),

                Gap(25.h),
                AppButton(
                  child: Text(
                    'Go to Location',
                    style: AppTextStyle.regular18.copyWith(
                      color: Colors.white,
                    ),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [


                                  const Text(
                                    "Remove Schedule",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                   Gap(12.h),

                                  const Text(
                                    "Are you sure you want to remove this\nfrom your schedule?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15, color: Colors.black87),
                                  ),

                                  Gap(22.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () => Get.back(),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            side: BorderSide(color: Colors.red.shade300, width: 2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.red.shade400,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Gap(12.w),

                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                             await controller.deleteSchedule(place.scheduleId!);
                                            Get.back();
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text(
                                            "Remove",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },


                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Remove from Schedule",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.red,
                    ),
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
