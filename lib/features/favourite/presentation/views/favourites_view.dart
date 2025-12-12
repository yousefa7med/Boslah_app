import 'package:Boslah/core/errors/app_exception.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/core/utilities/app_text_style.dart';
import 'package:Boslah/core/utilities/routes.dart';
import 'package:Boslah/core/widgets/search_field.dart';
import 'package:Boslah/features/favourite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilities/app_colors.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    ever(controller.error, (msg) {
      if (msg != null) {
        showSnackBar(msg);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
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
                  onPressed: () async {
                    if (controller.sController.text.isNotEmpty) {
                      try {
                        await controller.loadData();
                      } on AppException catch (e) {
                        showSnackBar(e.msg);
                      } catch (e) {
                        showSnackBar(e.toString());
                      }
                    }
                  },
                ),
                const Gap(10),
                Expanded(
                  child: Obx(() {
                    final allFav = controller.filteredFav;

                    if (allFav.isEmpty) {
                      return Center(
                        child: Text(
                          'No favorites yet',
                          style: AppTextStyle.bold26.copyWith(
                            color: const Color.fromARGB(147, 158, 158, 158),
                            fontSize: 30.sp,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  top: 8,
                                  bottom: 8,
                                  right: 22,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 80.w,
                                      height: 80.h,
                                      child:
                                          controller.allFavourits[index]
                                              .isAssetPath(
                                                controller
                                                    .allFavourits[index]
                                                    .image!,
                                              )
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    controller
                                                        .allFavourits[index]
                                                        .image!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: fav.image!,
                                              imageBuilder:
                                                  (
                                                    context,
                                                    imageProvider,
                                                  ) => Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context, url) =>
                                                  shimmerItem(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      shimmerItem(),
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
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
