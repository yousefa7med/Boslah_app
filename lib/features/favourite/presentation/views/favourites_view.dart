import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/utilities/routes.dart';
import 'package:depi_graduation_project/core/widgets/search_field.dart';
import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    ever(controller.error, (msg) {
      if (msg != null) {
        showSnackBar(context, msg);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            final allFav = controller.allFavourits;
            if (allFav.isEmpty) {
              return const Center(child: Text('No favorites yet'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favourites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  const Gap(15),
                  SearchField(
                    controller: controller.sController,
                    onPressed: () {
                      if (controller.sController.text.isNotEmpty) {
                        controller.loadData();
                      }
                    },
                  ),
                  const Gap(10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allFav.length,
                      itemBuilder: (ctx, index) {
                        final fav = allFav[index];

                        return SizedBox(
                          height: 130.h,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.details,
                                arguments: allFav[index],
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  top: 8,
                                  bottom: 8,
                                  right: 22,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(fav.image ?? ''),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          fav.name,
                                          style: AppTextStyle.bold20,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          if (controller.isFav[index].value) {
                                            controller.addToDeletedList(
                                              allFav[index].placeId,
                                            );
                                          } else {
                                            controller.removeFromDeletedList(
                                              allFav[index].placeId,
                                            );
                                          }
                                          controller.isFav[index].toggle();
                                          print(controller.deleted);
                                        },
                                        icon: controller.isFav[index].value
                                            ? const Icon(
                                                Icons.favorite,
                                                color: AppColors.main,
                                                size: 32,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_outlined,
                                                color: AppColors.main,
                                                size: 32,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
