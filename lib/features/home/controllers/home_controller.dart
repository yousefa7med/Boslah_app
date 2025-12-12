import 'dart:math';

import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/get_postion.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/core/widgets/app_dialog.dart';
import 'package:Boslah/models/filter_model.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/database/models/region_places.dart';
import '../../../core/database/models/region_requests.dart';
import '../../../core/services/api_services/api_services.dart';
import '../../../main.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final allPlaces = <PlaceModel>[].obs;
  final viewedPlaces = <PlaceModel>[].obs;

  final List<FilterModel> filterList = [];

  final api = Get.find<ApiServices>();

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    print('init');
    loadAll();

    super.onInit();
    filterList.addAll([
      FilterModel(
        text: 'All',
        onTap: () {
          viewedPlaces.value = allPlaces;
        },
      ),
      FilterModel(
        text: 'Tourism',
        icon: Icons.museum,
        onTap: () {
          viewedPlaces.value = allPlaces.where((p) {
            final isWikipedia = p.categories.contains('Tourism');
            final isTourism = p.categories.contains('entertainment');
            return isWikipedia || isTourism;
          }).toList();
        },
      ),

      FilterModel(
        text: 'Hotels',
        icon: Icons.apartment,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('accommodation'))
              .toList();
        },
      ),
      FilterModel(
        text: 'Restaurants & cafe',
        icon: Icons.restaurant_sharp,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('catering'))
              .toList();
        },
      ),
      FilterModel(
        text: 'Airport',
        icon: Icons.airplanemode_active,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('airport'))
              .toList();
        },
      ),
      FilterModel(
        text: 'Religion',
        icon: Icons.mosque,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('religion'))
              .toList();
        },
      ),
    ]);

    loadAll();
  }

  @override
  void onClose() {
    api.cancelToken;
    super.onClose();
  }

  double distanceInMeters(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;

    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
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
        final placesForReq = await database.regionplacedao.selectRegionPlaces(
          r.region_id!,
        );

        print('Request ${r.region_id} has ${placesForReq.length} places in DB');

        if (placesForReq.isNotEmpty) {
          return r;
        }
      }
    }

    return null;
  }

  Future<void> loadAll() async {
    final Position? position;
    try {
      position = await getPosition();
      isLoading.value = true;

      final nearbyRequest = await getNearbyRequest(
        position.latitude,
        position.longitude,
        500,
      );


      if (nearbyRequest != null) {
        print("Using cached data from request ${nearbyRequest.region_id}");

        viewedPlaces.value = await database.regionplacedao.selectRegionPlaces(
          nearbyRequest.region_id!,
        );

        allPlaces.value = viewedPlaces;

        isLoading.value = false;
        return;
      }

      final data = await api.getPlaces(
        lat:    position.latitude,
       
        long: position.longitude, 
      );
      print("pppppppppppppppppppp");

      allPlaces.value =
          data?.where((p) {
            if (p.desc == null || p.desc!.trim().isEmpty || p.image == null) {
              return false;
            }
            return true;
          }).toList() ??
          [];
      viewedPlaces.value = allPlaces;

      if (viewedPlaces.isEmpty) {
        final lastReq = await database.regionrequestdao.selectLastRequest();

        if (lastReq != null) {
          print("Loading last cached DB request...");

          allPlaces.value = await database.regionplacedao
              .selectRegionPlaces(lastReq.region_id!);

          viewedPlaces.value = List.from(allPlaces);
          return;
        }
      }


      if (viewedPlaces.isEmpty) {
        print("Using fallback: pyramids latitude/longitude");

        final fallbackData = await api.getPlaces(
          lat: 29.979235,
          long: 31.134202,
        );

        allPlaces.value = fallbackData
            ?.where((p) =>
        p.desc != null &&
            p.desc!.trim().isNotEmpty &&
            p.image != null)
            .toList() ??
            [];

        viewedPlaces.value = List.from(allPlaces);
        return;
      }

      final regionId = await database.regionrequestdao.insertRegionRequest(
        RegionRequest(lat: position.latitude, lng: position.longitude),
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

    } on AppException catch (e) {
      showSnackBar(e.msg);
    } on String catch (e) {
      appDialog(msg: e);
      Future.delayed(const Duration(seconds: 10), () async {
        await loadAll();
      });
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPlaces() async {
    await loadAll();
  }
}
