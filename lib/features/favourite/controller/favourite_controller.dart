import 'dart:async';

import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/services/supabase_services/favorite_service.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';
import '../../../core/database/models/favorites.dart';

class FavouritesController extends GetxController {
  final allFavourits = [].obs; //علشان السوبا غير الفلور
  final error = RxnString();
  @override
  void onInit() {
    try {
      loadData();
    } on Exception catch (e) {
      error.value = e.toString();
    }

    super.onInit();
  }

  // Future<void> loadData() async {
  //   final list = await database.favoritedao.selectFavorites(
  //     cloud.auth.currentUser!.id,
  //   );
  //   // replace whole list so Obx detects change
  //   if (list.isNotEmpty) {
  //     allFavourits.value = list;
  //   } else {
  //     allFavourits.value = await FavoritesService().getFavorites();
  //     // ولو عايز تحفظ اللي جالك محليًا بعد ما تسحب من السوبا بيز
  //     for (var fav in allFavourits.value) {
  //       await database.favoritedao.insertFavorite(fav);
  //     }
  //   }
  // }
  Future<void> loadData() async {
    try {
      final userId = cloud.auth.currentUser!.id;

      final localList = await database.favoritedao.selectFavorites(userId);

      if (localList.isNotEmpty) {
        allFavourits.value = localList;
        return;
      }
      final remoteList = await FavoritesService().getFavorites();

      allFavourits.value = remoteList;
      for (var fav in remoteList) {
        await database.favoritedao.insertFavorite(
          Favorite(
            name: fav.name!,
            user_id: fav.userId,
            place_id: fav.placeId,
            added_at: fav.addedAt,
            desc: fav.desc,
            image: fav.image,
            lat: fav.lat,
            lng: fav.lng,
          ),
        );
      }
    } catch (e) {
      throw AppException(msg: "Failed to load favorites");
    }
  }

  // Future<void> removeFavorite(int index) async {
  //   if (index < 0 || index >= allFavourits.length) return;
  //
  //   final fav = allFavourits[index];
  //   await database.favoritedao.deleteFavorite(
  //     fav.user_id!,
  //     fav.place_id!,
  //   );
  //   allFavourits.removeAt(index);
  // }
  // Future<void> removeFavorite(int placeId) async {
  //   await database.favoritedao.deleteFavorite(
  //     cloud.auth.currentUser!.id,
  //     placeId,
  //   );
  //   await FavoritesService().removeFavoriteByPlaceId(
  //     placeId,
  //     cloud.auth.currentUser!.id,
  //   );
  //
  //   allFavourits.removeWhere((f) => f.place_id == placeId);
  // }
  Future<void> removeFavorite(int placeId) async {
    final userId = cloud.auth.currentUser!.id;

    await database.favoritedao.deleteFavorite(userId, placeId);

    await FavoritesService().removeFavoriteByPlaceId(placeId, userId);

    allFavourits.removeWhere((f) => f.place_id == placeId);
  }
}
