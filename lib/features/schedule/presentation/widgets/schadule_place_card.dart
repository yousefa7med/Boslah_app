import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class SchadulePlaceCard extends GetView<ScheduleController> {
  const SchadulePlaceCard(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------- IMAGE + BADGES --------------------
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: controller.allSchedules[index].image != null
                    ? Image.network(
                        controller.allSchedules[index].image!, // الصورة
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),

              // badge left
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      const Gap(5),
                      Text(
                        "In Progress",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // badge right
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Today",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),

          // -------------------- TITLE --------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              controller.allSchedules[index].name ?? '',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),

          // -------------------- NOTE --------------------
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Text(
              controller.allSchedules[index].note,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
