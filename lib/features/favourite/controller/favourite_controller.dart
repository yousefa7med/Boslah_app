import 'dart:async';

import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';
import '../../../core/database/models/favorites.dart';

class FavouritesController extends GetxController {
  final allFavourits = <Favorite>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final list = await database.favoritedao.selectFavorites(
      cloud.auth.currentUser!.id,
    );
    // replace whole list so Obx detects change
    allFavourits.value = list;
  }

  Future<void> removeFavorite(int index) async {
    if (index < 0 || index >= allFavourits.length) return;

    final fav = allFavourits[index];
    await database.favoritedao.deleteFavorite(
      fav.user_id!,
      fav.place_id!,
    );
    allFavourits.removeAt(index);
  }
}
