import 'dart:async';

import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/services/supabase_services/favorite_service.dart';
import 'package:Boslah/main.dart';
import 'package:Boslah/models/favorite_supabase.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/database/models/favorites.dart';

class FavouritesController extends GetxController {
  final allFavourits = <PlaceModel>[].obs; //علشان السوبا غير الفلور
  final filteredFav = <PlaceModel>[].obs;
  final error = RxnString();
  final List<int> deleted = [];
  final List<RxBool> isFav = [];
  var sController = TextEditingController();

  @override
  void onInit() {
    sController.addListener(() {
      filterFavorites(sController.text);
    });
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

  Future<void> loadData() async {
    try {
      final userId = cloud.auth.currentUser!.id;
      print("++++++++++++++++++++++++++$userId");
      final localList = await database.favoritedao.selectFavorites(userId);

      if (localList.isNotEmpty) {
        allFavourits.value = localList;
        filteredFav.value = allFavourits;
        isFav.addAll(List.generate(allFavourits.length, (i) => true.obs));
        print("locaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaal");
        return;
      }
      final remoteList = await FavoritesService().getFavorites();

      allFavourits.value = remoteList;
      filteredFav.value = allFavourits;
      if (allFavourits.isNotEmpty) {
        filteredFav.value = allFavourits;
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
            categories: fav.categories,
          ),
        );
        print(fav.image);
      }
    } catch (e) {
      throw AppException(msg: "Failed to load favorites");
    }
  }

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

  void filterFavorites(String query) {
    if (query.isEmpty) {
      filteredFav.value = allFavourits;
      return;
    }
    final lowerQuery = query.toLowerCase();

    filteredFav.value = allFavourits.where((fav) {
      return fav.name.toLowerCase().contains(lowerQuery) ||
          (fav.desc?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }
}
