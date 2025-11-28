import 'package:depi_graduation_project/core/utilities/app_text_style.dart';
import 'package:depi_graduation_project/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // profile code
                      },
                      icon: const Icon(
                        Icons.person_outline,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Card(
                elevation: 1,
                shadowColor: Colors.white,
                child: buildSearch(),
              ),
              const Gap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCardFilttring(1, 'All'),
                    buildCardFilttring(2, 'Museums', IconData: Icons.museum),
                    buildCardFilttring(
                      3,
                      'Restaurants',
                      IconData: Icons.restaurant_sharp,
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Align(
                  alignment: const Alignment(-0.9, 1)
                  ,
                  child: Text('Nearby Attractions', style: AppTextStyle.bold26,)
              ),
              const Gap(10),
              Obx(() {
                return Expanded(
                  child: ListView.builder(
                      itemCount: controller.places.length,
                      itemBuilder: (ctx, index) =>
                          Column(
                            children: [
                              InkWell(
                                onTap:() {
                                  Get.toNamed('/details',arguments: controller.places[index]);
                                }
                                ,child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: controller.places[index].thumbnail != null
                                            ? Image.network(
                                          controller.places[index].thumbnail!.source,
                                          width: double.infinity,
                                          height: 180,
                                          fit: BoxFit.fill,
                                        )
                                            : Container(
                                          width: double.infinity,
                                          height: 180,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                        ),
                                      ),
                                      const Gap(10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 5),
                                        child: Text(controller.places[index].title,style: AppTextStyle.semiBold24,),
                                      ),
                                      controller.places[index].description!=null?Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                                        child: Text('${controller.places[index].description}'
                                          ,style: AppTextStyle.semiBold18.copyWith(color: Colors.grey),),
                                      ):const Gap(5),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(15)
                            ],
                          ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }


  Widget buildSearch() {
    return TextField(
      controller: controller.searchController,
      style: const TextStyle(color: AppColors.main),
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: () {
            //search code
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
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.8),
        ),
      ),
    );
  }

  Widget buildCardFilttring(int index, String label, {IconData}) {
    return Obx(() {
      bool isSelected = controller.selectedCard.value == index;
      return InkWell(
        onTap: () {
          controller.selectedCard.value = index;
          // calling the api
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: isSelected ? AppColors.main : Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  IconData != null
                      ? Row(
                    children: [
                      Icon(
                        IconData,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      const Gap(10),
                    ],
                  )
                      : const SizedBox.shrink(),
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }


}
