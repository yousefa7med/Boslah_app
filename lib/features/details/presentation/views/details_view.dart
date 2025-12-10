import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/widgets/app_button.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:depi_graduation_project/features/details/presentation/widgets/schedule_form.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: controller.place.image != null
                          ? CachedNetworkImage(
                              imageUrl: controller.place.image!,
                              width: double.infinity,
                              height: 350,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: double.infinity,
                              height: 300,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 9,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() {
                          return IconButton(
                            onPressed: () async {
                              // if (controller.favorite.value) {
                              //   controller.removeFromFav();
                              // } else {
                              //   controller.addToFav();
                              // }
                              // controller.favorite.toggle();
                              try {
                                if (controller.favorite.value) {
                                  await controller.removeFromFav();
                                } else {
                                  await controller.addToFav();
                                }

                                controller.favorite.toggle();
                              } catch (e) {
                                showSnackBar(context, e.toString());
                              }
                            },
                            icon: controller.favorite.value
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Gap(56.h),
                Text(
                  controller.place.name,
                  style: AppTextStyle.bold26.copyWith(fontSize: 30),
                ),
                const Gap(20),
                controller.place.desc != null
                    ? Text(
                        ' ${controller.place.desc}. ',
                        style: AppTextStyle.semiBold22.copyWith(
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox.shrink(),
                const Gap(20),
                const Divider(),
                const Gap(20),
                Row(
                  children: [
                    Text(
                      'OpeningHours',
                      style: AppTextStyle.regular20.copyWith(
                        color: AppColors.main,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text('9:00AM-11:00PM', style: AppTextStyle.regular18),
                  ],
                ),
                const Gap(18),
                const Divider(),
                const Gap(50),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: AppButton(
                          child: Text(
                            'Open Location',
                            style: AppTextStyle.regular18.copyWith(
                              color: Colors.white,
                            ),
                          ),

                          onPressed: () async {
                            await launchUrl(
                              mode: LaunchMode.externalApplication,
                              Uri.parse(
                                "https://www.google.com/maps/search/?api=1&query=${controller.place.lat},${controller.place.lng}",
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(8),

                      SizedBox(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,

                              context: context,
                              // backgroundColor: Colors.transparent,
                              builder: (_) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: Get.mediaQuery.viewInsets.bottom,
                                ),
                                child: const ScheduleForm(),
                              ),
                            );
                            // checkExactAlarmAndOpenForm(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // const Gap(20),

                // Center(
                //   child: SizedBox(
                //     height: 50,
                //     width: 250,
                //     child: AppButton(
                //       child: Text(
                //         'Schedule Visit',
                //         style: AppTextStyle.regular18.copyWith(
                //           color: Colors.white,
                //         ),
                //       ),
                //         onPressed: () {
                //
                //           showModalBottomSheet(
                //             context: context,
                //             isScrollControlled: true,
                //             backgroundColor: Colors.transparent,
                //             builder: (_) => const ScheduleBottomSheet(),
                //           );
                //         }
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
