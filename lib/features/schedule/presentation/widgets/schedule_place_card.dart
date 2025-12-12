import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/utilities/app_colors.dart';

class SchedulePlaceCard extends GetView<ScheduleController> {
  const SchedulePlaceCard(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    final item = controller.viewedSchedules[index];

    final status = controller.getStatus(item.date);
    final color = controller.getStatusColor(status);
    final bool isToday = status == "In Progress";

    return InkWell(
      onTap: () {
        Get.toNamed('/schedule_place', arguments: item);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- IMAGE ----------------
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: item.isAssetPath(item.image!)
                      ? Image.asset(
                          item.image!,
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          imageUrl: item.image!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                ),

                // ---------------- LEFT BADGE ----------------
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: color),
                        const Gap(6),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ---------------- RIGHT BADGE ----------------
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.main : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isToday ? "Today" : item.date,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),

            // ---------------- TITLE ----------------
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                item.name ?? '',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // ---------------- NOTE ----------------
            if (item.note.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  item.note,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // ---------------- DATE & TIME ----------------
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8, top: 6),
              child: Row(
                children: [
                  Icon(Icons.date_range_sharp, color: Colors.grey.shade500),
                  const SizedBox(width: 6),
                  Text(
                    '${item.date}  ${item.hour}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
