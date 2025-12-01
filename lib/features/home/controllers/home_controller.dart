import 'package:depi_graduation_project/core/database/models/region_places.dart';
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/cupertino.dart' hide Page;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final selectedCard = 1.obs;
  final position = Rxn<Position>();

  final places = <PlaceModel>[].obs;
  final museums = <PlaceModel>[].obs;
  final restaurant = <PlaceModel>[].obs;
  // final keywords = [
  //   "sphinx"
  //   "ancient"
  //   "mosque",
  //   "museum",
  //   "park",
  //   "temple",
  //   "pyramid",
  //   "fort",
  //   "castle",
  //   "citadel",
  //   "historical",
  //   "archaeological",
  //   "landmark",
  //   "tourist",
  // ];

  final api = Get.find<ApiServices>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAll();
  }

  void loadAll() async {
    // position.value= await Location().getPosition();
    final data = await api.getPlacesWithDetails(
      lat: 29.979235,
      long: 31.134202,
    );
    places.value =
        data?.where((p) {
          if (p.desc == null || p.desc!.trim().isEmpty) {
            return false;
          }

          return true;
          // final title = p.title.toLowerCase();
          // final desc = p.description!.toLowerCase();
          // return keywords.any((k) {
          //   final key = k.toLowerCase();
          //   return title.toLowerCase().contains(key) || desc.toLowerCase().contains(key);
          // });
        }).toList() ??
        [];

    final regionId = await database.regionrequestdao.insertRegionRequest(
      RegionRequest(lat: 29.979235, lng: 31.134202),
    );

    List<RegionPlace> list = [];
    for (var element in data!) {
      list.add(
        RegionPlace(
          region_id: regionId,
          place_id: element.placeId.toString(),
          lat: element.lat,
          lng: element.lng,
        ),
      );
    }
    await database.regionplacedao.insertRespPlaces(list);
  }
}
