import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/core/widgets/app_button.dart';
import 'package:Boslah/features/details/controllers/details_controller.dart';
import 'package:Boslah/features/details/presentation/widgets/schedule_form.dart';
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
                      child:
                          controller.place.isAssetPath(controller.place.image!)
                          ? Image.asset(
                              controller.place.image!,
                              width: double.infinity,
                              height: 350.h,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: controller.place.image!,
                              width: double.infinity,
                              height: 350.h,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 9,
                      child: Container(
                        width: 65.r,
                        height: 65.r,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() {
                          return IconButton(
                            onPressed: () async {
                              try {
                                controller.favorite.toggle();
                                if (!controller.favorite.value) {
                                  await controller.removeFromFav();
                                } else {
                                  await controller.addToFav();
                                }
                              } on AppException catch (e) {
                                showSnackBar(e.msg);
                              } catch (e) {
                                showSnackBar(e.toString());
                              }
                            },
                            icon: controller.favorite.value
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30.r,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 30.r,
                                  ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      left: 6,
                      top: 6,
                      child: Container(
                        width: 65.r,
                        height: 65.r,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 34.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(56.h),
                Text(
                  controller.place.name,
                  style: AppTextStyle.bold26.copyWith(fontSize: 30.sp),
                ),
                Gap(20.h),
                controller.place.desc != null
                    ? Text(
                        ' ${controller.place.desc}. ',
                        style: AppTextStyle.semiBold22.copyWith(
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox.shrink(),
                Gap(100.h),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 250.w,
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
                      Gap(8.h),

                      SizedBox(
                        height: 50.h,
                        width: 70.w,
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
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 25.r,
                          ),
                        ),
                      ),
                    ],
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
