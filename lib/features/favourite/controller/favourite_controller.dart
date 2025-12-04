import 'dart:async';

import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/services/supabase_services/favorite_service.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:depi_graduation_project/models/favorite_supabase.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:get/get.dart';
import '../../../core/database/models/favorites.dart';

class FavouritesController extends GetxController {
  final allFavourits = <PlaceModel>[].obs; //علشان السوبا غير الفلور
  final error = RxnString();
  final List<int> deleted = [];
  final List<RxBool> isFav = [];
  @override
  void onInit() {
    try {
      loadData();
    } on Exception catch (e) {
      error.value = e.toString();
    }

    super.onInit();
  }

  void addToDeletedList(int placeId) {
    deleted.add(placeId);
  }

  void removeFromDeletedList(int placeId) {
    deleted.remove(placeId);
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
        isFav.addAll(List.generate(allFavourits.length, (i) => true.obs));
        print("locaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaal");
        return;
      }
      final remoteList = await FavoritesService().getFavorites();

      allFavourits.value = remoteList;
      if (allFavourits.isNotEmpty) {
        isFav.addAll(List.generate(allFavourits.length, (i) => true.obs));
        print("sopaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      }
      for (var fav in remoteList) {
        await database.favoritedao.insertFavorite(
          Favorite(
            name: fav.name,
            userId: fav.userId,
            placeId: fav.placeId,
            addedAt: fav.addedAt,
            desc: fav.desc,
            image: fav.image,
            lat: fav.lat,
            lng: fav.lng,
          ),
        );
        print(fav.image);
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
  Future<void> removeFavoriteFromDB(int placeId) async {
    final userId = cloud.auth.currentUser!.id;
    allFavourits.removeWhere((f) => f.placeId == placeId);

    await database.favoritedao.deleteFavorite(userId, placeId);

    await FavoritesService().removeFavoriteByPlaceId(placeId, userId);
  }

  Future<void> addToFavoritesToDB(int placeId) async {
    final userId = cloud.auth.currentUser!.id;

    final place = await database.favoritedao.selectOneFavPlace(userId, placeId);
    if (place != null) {
      allFavourits.add(place);

      await database.favoritedao.insertFavorite(place);
      await FavoritesService().addFavorite(
        FavoriteSupabase.fromJson(place.toJson()),
      );
    } else {
      throw AppException(
        msg: "Adding to favorites failed with place id : $placeId",
      );
    }
  }
}
