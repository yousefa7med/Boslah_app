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
  final allPlaces = <PlaceModel>[].obs;
  final viewedPlaces=<PlaceModel>[].obs;
  final museums = <PlaceModel>[].obs;
  final restaurant = <PlaceModel>[].obs;
  final List<FilterModel> filterList = [];

  final api = Get.find<ApiServices>();
  final geoapify = Get.find<GeoapifyService>();

  RxBool isLoading = true.obs;

  // final tourismKeywords = [
  //   // Ancient & Historic
  //   "historic", "ancient", "archaeolog", "ruins",
  //   "heritage", "monument", "site", "memorial",
  //
  //   // Museums
  //   "museum", "gallery", "heritage center",
  //
  //   // Religious places (global)
  //   "temple", "church", "mosque", "synagogue", "cathedral",
  //   "shrine", "basilica", "chapel", "monastery", "pagoda",
  //   "stupa",
  //
  //   // Castles & Forts
  //   "castle", "fortress", "citadel", "palace",
  //
  //   // Landmarks
  //   "landmark", "tower", "square", "plaza",
  //
  //   // Parks & Nature
  //   "park", "national park", "forest", "canyon", "mountain",
  //   "waterfall", "lake", "valley", "beach", "cliff",
  //
  //   // Statues & Structures
  //   "statue", "sculpture", "bridge", "gate",
  //
  //   // Tourism general
  //   "tourist", "attraction", "landmark", "point of interest",
  // ];
  //
  //
  // final blacklist = [
  //   // People
  //   "born", "died", "actor", "singer",
  //   "politician", "writer", "footballer",
  //
  //   // Organizations
  //   "company", "organization", "association",
  //   "foundation", "club",
  //
  //   // Events & Time
  //   "war", "treaty", "agreement", "festival",
  //   "event", "election",
  //
  //   // Education
  //   "school", "university", "college", "faculty", "academy",
  //
  //   // Geography non-tourism
  //   "village", "district", "province", "governorate",
  //   "suburb", "neighborhood", "administrative division",
  //
  //   // Media
  //   "film", "song", "album", "book", "novel", "series",
  // ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    filterList.addAll(
    [
        FilterModel(
            text: 'All',
            onTap: (){
              viewedPlaces.value=allPlaces;
            }
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
        onTap: (){
          viewedPlaces.value=allPlaces.where(
              (p)=>p.categories.contains('accommodation')
            ).toList();
          }
        ),
        FilterModel(
        text: 'Restaurants&cafe',
        icon: Icons.restaurant_sharp,
        onTap: (){
          viewedPlaces.value=allPlaces.where(
              (p)=>p.categories.contains('catering')
            ).toList();
          }
        ),
        FilterModel(
            text: 'AirPort',
            icon: Icons.airplanemode_active,
            onTap: (){
              viewedPlaces.value=allPlaces.where(
                      (p)=>p.categories.contains('airport')
              ).toList();
            }
        ),
        FilterModel(
            text: 'religion',
            icon: Icons.mosque,
            onTap: (){
              viewedPlaces.value=allPlaces.where(
                      (p)=>p.categories.contains('religion')
              ).toList();
            }
        ),
    ]
    );

    loadAll();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    api.cancelToken;
    super.onClose();
  }

  Future<void> loadAll() async {
    // final Position? position = await Location().getPosition();
    try {
      isLoading.value = true;
      final data = await api.getPlacesWithDetails(
            lat: 24.0889,
            long: 32.8998,
          );

      final geoapifyData = await geoapify.getPlaces(
            lat: 24.0889,
            lon: 32.8998,
          );

      if (data != null && geoapifyData != null) {
            data.addAll(geoapifyData);
          }

      allPlaces.value = data?.where((p) {
            // 1) لازم Description وصورة
            if (p.desc == null || p.desc!.trim().isEmpty || p.image == null) {
              return false;
            }
              return true;
            // final title = p.name.toLowerCase();
            // final desc = p.desc!.toLowerCase();
            //
            // // 2) Blacklist (يمنع الأماكن اللي مش سياحية)
            // bool isBlacklisted = blacklist.any((bad) =>
            // title.contains(bad) || desc.contains(bad));
            //
            // if (isBlacklisted) return false;
            //
            // // 3) Keyword check (أي كلمة سياحية)
            // bool isTouristic = tourismKeywords.any((k) =>
            // title.contains(k) || desc.contains(k));
            //
            // return isTouristic;
          }).toList() ?? [];
      viewedPlaces.value=allPlaces;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPlaces() async {
    await loadAll();
  }


}
