import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/utilities/app_colors.dart';
import '../../../core/utilities/app_text_style.dart';
import '../search_controller/search_controller.dart';

class SearchView extends GetView<searchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Column(
          children: [
            buildSearch(),
            Gap(15.h),
            Align(
              alignment: const Alignment(-0.9, 1),
              child: Text('Results', style: AppTextStyle.bold26),
            ),
            Gap(10.h),
            Expanded(
              child: Obx(() {
                return controller.searchList.isEmpty?Center(child: Text('No place')):ListView.builder(
                    itemCount: controller.searchList.length,
                    itemBuilder: (ctx, index) => PlaceCard(index)
                );
              }),
            )
          ],
        ),
      )),
    );
  }


  Widget buildSearch() {
    return TextField(
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
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.8),
        ),
      ),
    );
  }
}


class PlaceCard extends GetView<searchController> {
  const PlaceCard(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/details', arguments: controller.searchList[index]);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: controller.searchList[index].image != null
                  ? Image.network(
                controller.searchList[index].image!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.fill,
              )
                  : Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: Text(
                controller.searchList[index].name,
                style: AppTextStyle.semiBold24,
              ),
            ),
            controller.searchList[index].desc != null
                ? Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Text(
                '${controller.searchList[index].desc}',
                style: AppTextStyle.semiBold18.copyWith(
                  color: Colors.grey,
                ),
              ),
            )
                : const Gap(5),
          ],
        ),
      ),
    );
  }
}