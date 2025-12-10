import 'package:depi_graduation_project/core/database/models/region_places.dart';
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:depi_graduation_project/core/services/api_services/geoapify_services.dart';
import 'package:depi_graduation_project/models/filter_model.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/cupertino.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services1.1.dart';
import 'dart:math';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final position = Rxn<Position>();
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


  double distanceInMeters(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;

    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  double _degToRad(double deg) => deg * pi / 180;


  Future<RegionRequest?> getNearbyRequest(
      double lat,
      double lng,
      double thresholdMeters,
      ) async {
    final all = await database.regionrequestdao.selectRequests();

    print('Found ${all.length} region_requests in DB');

    for (final r in all) {
      final dist = distanceInMeters(lat, lng, r.lat, r.lng);
      print('Request ${r.region_id} distance = $dist');

      if (dist < thresholdMeters) {
        final placesForReq =
        await database.regionplacedao.selectRegionPlaces(r.region_id!);

        print(
            'Request ${r.region_id} has ${placesForReq.length} places in DB');

        if (placesForReq.isNotEmpty) {
          return r;
        }
      }
    }

    return null;
  }



  Future<void> loadAll() async {
    // position.value= await Location().getPosition();
    const currentLat = 29.979235;
    const currentLng = 31.134202;

    final nearbyRequest = await getNearbyRequest(currentLat, currentLng, 500);

    if (nearbyRequest != null) {
      print("Using cached data from request ${nearbyRequest.region_id}");

      places.value = await database.regionplacedao
          .selectRegionPlaces(nearbyRequest.region_id!);

      print('Loaded ${places.value.length} places from cache');

      return;
    }



    final data = await api.getPlacesWithDetails(
      lat: 29.979235,
      long: 31.134202,
    );

    final geoapifyData = await geoapify.getPlaces(
        lat: 29.979235,
        lon: 31.134202,
    );

    if (data != null && geoapifyData != null ) {
      data.addAll(geoapifyData);
      data.shuffle();
    };

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
          desc: element.desc
        ),
      );
    }
    await database.regionplacedao.insertRespPlaces(list);
  }

  Future<void> refreshPlaces() async {
    await loadAll();
  }
}
