import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final list = controller.allFavourits;
          if (list.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              final fav = list[index];

              return SizedBox(
                height: 130,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              fav.name ?? '',
                              style: AppTextStyle.bold20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.removeFavorite(index),
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.main,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
