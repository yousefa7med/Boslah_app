import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/widgets/app_button.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        //  controller.place.thumbnail != null
                        //     ? Image.network(
                        //         controller.place.thumbnail!,
                        //         width: double.infinity,
                        //         height: 350,
                        //         fit: BoxFit.cover,
                        //       )
                        //     :
                        Container(
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
                controller.place.title,
                style: AppTextStyle.bold26.copyWith(fontSize: 30),
              ),
              const Gap(20),
              controller.place.description != null
                  ? Text(
                      ' ${controller.place.description}. ',
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
                child: SizedBox(
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
                          "https://www.google.com/maps/search/?api=1&query=${controller.place.coordinates![0].lat},${controller.place.coordinates![0].lon}",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
