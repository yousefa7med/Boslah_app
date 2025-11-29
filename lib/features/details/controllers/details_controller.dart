import 'dart:async';

import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/place_details_response.dart';
import '../../favourite/controller/favourite_controller.dart';

class DetailsController extends GetxController {
  RxBool favorite = true.obs; // initialize here
  late Page place;

  @override
  Future<void> onInit() async {
    super.onInit();
    place = Get.arguments;
    favorite.value = await isFavorite();
  }

  Future<void> addToFav() async {
    final addFavorite = Favorite(
      place_id: place.pageid,
      user_id: cloud.auth.currentUser!.id,
      image: place.thumbnail?.source,
      name: place.title, desc: '',
    );
    await database.favoritedao.insertFavorite(addFavorite);

    try {
      final favController = Get.find<FavouritesController>();
      await favController.loadData();
    } catch (_) {}
  }


  Future<void> removeFromFav() async {
    await database.favoritedao.deleteFavorite(
      cloud.auth.currentUser!.id,
      place.pageid,
    );

    try {
      final favController = Get.find<FavouritesController>();
      await favController.loadData();
    } catch (_) {}
  }

  Future<bool> isFavorite() async {
    final result = await database.favoritedao.selectOneFavPlace(
      cloud.auth.currentUser!.id,
      place.pageid,
    );
    return result != null;

  }

}