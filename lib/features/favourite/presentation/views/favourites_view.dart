import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/core/utilities/routes.dart';
import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:flutter/foundation.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final allFav = controller.allFavourits;
          if (allFav.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Favourites',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                const Gap(15),
                buildSearch(),
                const Gap(10),
                Expanded(
                  child: ListView.builder(
                    itemCount: allFav.length,
                    itemBuilder: (ctx, index) {
                      final fav = allFav[index];

                      return SizedBox(
                        height: 130,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.details, arguments: allFav[index]);
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
                                        image: NetworkImage(fav.image ?? ''),
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
    );
  }
  Widget buildSearch() {
    return TextField(
      // onChanged: (a){
      //   if(a.isEmpty){
      //     controller.allFavourits.assignAll(controller.allFavouritsCoppy);
      //   }else{
      //     controller.allFavourits.assignAll
      //       (controller.allFavouritsCoppy.where((value)=>
      //     value.name.contains(a.toLowerCase())
      //     ));
      //   }
      // },
      controller: controller.sController,
      style: const TextStyle(color: AppColors.main),
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {
            if (controller.sController.text.isNotEmpty) {
              controller.loadData();
            }
          },
          icon: Icon(
            Icons.search,
            color: AppColors.main.withAlpha(200),
            size: 27,
          ),
        ),
        hintText: 'Search for attractions...',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 17.sp),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.main, width: 2.8),
        ),
      ),
    );
  }
}
