import 'package:depi_graduation_project/core/database/models/region_places.dart';
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:depi_graduation_project/core/services/api_services/geoapify_services.dart';
import 'package:depi_graduation_project/location.dart';
import 'package:depi_graduation_project/models/filter_model.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:depi_graduation_project/main.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final places = <PlaceModel>[].obs;
  final museums = <PlaceModel>[].obs;
  final restaurant = <PlaceModel>[].obs;
  final List<FilterModel> filterList = [
    FilterModel(text: 'All'),
    FilterModel(text: 'Museums', icon: Icons.museum),
    FilterModel(text: 'Restaurants', icon: Icons.restaurant_sharp),
  ];

  final api = Get.find<ApiServices>();
  final geoapify = Get.find<GeoapifyService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAll();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    api.cancelToken;
    super.onClose();
  }

  Future<void> loadAll() async {
    final Position? position = await Location().getPosition();
    final data = await api.getPlacesWithDetails(
      lat: position!.latitude,
      long: position.longitude,
    );

    final geoapifyData = await geoapify.getPlaces(
      lat: position.latitude,
      lon: position.longitude,
    );

    if (data != null && geoapifyData != null) {
      data.addAll(geoapifyData);
      data.shuffle();
    }

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
          name: element.name,
          regionId: regionId,
          placeId: element.placeId,
          lat: element.lat,
          lng: element.lng,
          image: element.image,
          desc: element.desc,
          categories: element.categories,
        ),
      );
    }
    await database.regionplacedao.insertRespPlaces(list);
  }

  Future<void> refreshPlaces() async {
    await loadAll();
  }
}
