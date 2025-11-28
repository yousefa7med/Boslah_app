import 'package:depi_graduation_project/core/services/api_services/place_details_response.dart';
import 'package:depi_graduation_project/location.dart';
import 'package:flutter/cupertino.dart' hide Page;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';

class HomeController extends GetxController{

  final searchController=TextEditingController();
  final selectedCard=1.obs;
  final position=Rxn<Position>();

  final places=<Page>[].obs;
  final museums=<Page>[].obs;
  final restaurant=<Page>[].obs;
  final keywords = [
    "mosque",
    "museum",
    "park",
    "temple",
    "pyramid",
    "fort",
    "castle",
    "citadel",
    "historical",
    "archaeological",
    "landmark",
    "tourist"
  ];


  final api=Get.find<ApiServices>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAll();
  }

  void loadAll() async{
    // position.value= await Location().getPosition();
    final data=await api.getPlacesWithDetails(lat: 29.979235, long: 31.134202);
    places.value = data
        ?.where((p) {
      if (p == null) return false;
      final title = p.title.toLowerCase() ?? "";
      final desc  = p.description?.toLowerCase() ?? "";
      return keywords.any((k) {
        final key = k.toLowerCase();
        return title.contains(key) || desc.contains(key);
      });
    }).toList()  ?? [];

  }

}