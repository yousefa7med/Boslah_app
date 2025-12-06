import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_graduation_project/core/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utilities/app_text_style.dart';
import '../../controllers/search_controller.dart';

class SearchView extends GetView<searchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                SearchField(
                  controller: controller.sController,
                  onPressed: () {
                    if (controller.sController.text.isNotEmpty) {
                      controller.loadData();
                    }
                  },
                ),
                Gap(15.h),
                Align(
                  alignment: const Alignment(-0.9, 1),
                  child: Text('Results', style: AppTextStyle.bold26),
                ),
                Gap(10.h),
                Expanded(
                  child: Obx(() {
                    return controller.searchList.isEmpty
                        ? const Center(child: Text('No place'))
                        : ListView.separated(
                            itemCount: controller.searchList.length,
                            itemBuilder: (ctx, index) => PlaceCard(index),
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return const Gap(10);
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
                  ?    CachedNetworkImage(imageUrl: 
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
