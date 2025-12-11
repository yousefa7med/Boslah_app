import 'package:Boslah/core/functions/get_postion.dart';
import 'package:Boslah/core/widgets/app_dialog.dart';
import 'package:Boslah/models/filter_model.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final allPlaces = <PlaceModel>[].obs;
  final viewedPlaces = <PlaceModel>[].obs;
  final museums = <PlaceModel>[].obs;
  final restaurant = <PlaceModel>[].obs;
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
        text: 'Restaurants&cafe',
        icon: Icons.restaurant_sharp,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('catering'))
              .toList();
        },
      ),
      FilterModel(
        text: 'AirPort',
        icon: Icons.airplanemode_active,
        onTap: () {
          viewedPlaces.value = allPlaces
              .where((p) => p.categories.contains('airport'))
              .toList();
        },
      ),
      FilterModel(
        text: 'religion',
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

  Future<void> loadAll() async {
    final Position? position;
    try {
      position = await getPosition();
      isLoading.value = true;

      final data = await api.getPlaces(
        lat: position.latitude,
        long: position.longitude,
      );
      print("pppppppppppppppppppp");

      allPlaces.value =
          data?.where((p) {
            // 1) لازم Description وصورة
            if (p.desc == null || p.desc!.trim().isEmpty || p.image == null) {
              return false;
            }
            return true;
          }).toList() ??
          [];
      viewedPlaces.value = allPlaces;
    } on String catch (e) {
      appDialog(msg: e);
      Future.delayed(const Duration(seconds: 10), () async {
        await loadAll();
      });
    } finally {
      isLoading.value = false;
    } // final regionId = await database.regionrequestdao.insertRegionRequest(
    //       RegionRequest(lat: 29.979235, lng: 31.134202),
    //     );

    // List<RegionPlace> list = [];
    // for (var element in data!) {
    //       list.add(
    //         RegionPlace(
    //           name: element.name,
    //           regionId: regionId,
    //           placeId: element.placeId,
    //           lat: element.lat,
    //           lng: element.lng,
    //           image: element.image,
    //           desc: element.desc,
    //           categories: element.categories,
    //         ),
    //       );
    //     }
    // await database.regionplacedao.insertRespPlaces(list);
  }

  Future<void> refreshPlaces() async {
    await loadAll();
  }
}
