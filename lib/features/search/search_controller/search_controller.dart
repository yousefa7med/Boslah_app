import 'package:depi_graduation_project/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';

class searchController extends GetxController{

  final searchList=<PlaceModel>[].obs;
  var sController=TextEditingController();
  final api = Get.find<ApiServices>();


  Future<void> loadData() async {
    final data=await api.searchPlacesWithImages(sController.text);
    searchList.value = data?.where((p) {
          if (p.image == null ) {
            return false;
          }

          return true;
          // final title = p.title.toLowerCase();
          // final desc = p.description!.toLowerCase();
          // return keywords.any((k) {
          //   final key = k.toLowerCase();
          //   return title.toLowerCase().contains(key) || desc.toLowerCase().contains(key);
          // });
        }).toList() ?? [];

  }
}