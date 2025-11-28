import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:depi_graduation_project/core/services/api_services/place_details_response.dart';

class DetailsView extends GetView<DetailsController> {
  DetailsView({super.key});

  final Page page = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(right: 4, left: 4, top: 24, bottom: 8),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: page.thumbnail != null
                            ? Image.network(
                          page.thumbnail!.source,
                          width: double.infinity,
                          height: 350,
                          fit: BoxFit.fill,
                        )
                            : Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50,
                              color: Colors.grey),
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
                              shape: BoxShape.circle
                          ),
                          child: Obx(() {
                            return IconButton(
                              onPressed: () {
                                controller.favorite.toggle();
                                //Saving Code here 
                              },
                              icon: controller.favorite.value ?
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 30,
                              ):
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(page.title,style: AppTextStyle.bold26.copyWith(fontSize: 30),)
                      ,const Gap(20),
                      page.description !=null?
                      Text('" ${page.description}. "',
                          style: AppTextStyle.semiBold22.copyWith(color: Colors.grey)):SizedBox.shrink(),
                      const Gap(20),
                      const Divider(),
                      const Gap(20),
                      Row(
                        children: [
                          Text('OpeningHours',style: AppTextStyle.regular20.copyWith(color: AppColors.main)),
                          const SizedBox(width: 20,),
                          Text('9:00AM-11:00PM',style: AppTextStyle.regular18),
                        ],
                      ),
                      const Gap(18),
                      const Divider(),
                      const Gap(50),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 250,
                          child: ElevatedButton(onPressed: (){
                            //opening map code
                          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.main,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              )
                            )
                            ,child: Text('Open Location',style:AppTextStyle.regular18.copyWith(color: Colors.white),)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )

      ),
    );
  }
}
