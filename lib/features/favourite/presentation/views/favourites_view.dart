import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: controller.allFavourits.length,
            itemBuilder: (ctx, index) =>
                SizedBox(
                  height: 130,
                  child: Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, top: 8, bottom: 8, right: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      controller.allFavourits[index].image!,),
                                    fit: BoxFit.cover),
                              ),
                            ),

                            Text(controller.allFavourits[index].name!,
                              style: AppTextStyle.bold20,),
                            Obx(() {
                              return IconButton(onPressed: () {
                                   controller.isFavourite[index].toggle();
                              }, icon:controller.isFavourite[index].value
                                  ?  Icon( Icons.favorite
                                   , color: Colors.red,
                                  size: 32,):Icon(Icons.favorite_border,color: Colors.red,size: 32,)
                              );
                            }),
                          ],
                        ),
                      )
                  ),
                )
        ),
      ),
    );
  }
}
