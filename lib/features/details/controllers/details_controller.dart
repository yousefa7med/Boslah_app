import 'dart:async';

import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:depi_graduation_project/core/services/supabase_services/favorite_service.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:depi_graduation_project/models/favorite_supabase.dart';
import 'package:get/get.dart';

import '../../../models/place_model.dart';
import '../../favourite/controller/favourite_controller.dart';

class DetailsController extends GetxController {
  RxBool favorite = false.obs; // initialize here
  late PlaceModel place;

  @override
  Future<void> onInit() async {
    super.onInit();
    place = Get.arguments;
    favorite.value = await isFavorite();
  }

  Future<void> addToFav() async {
    final addFavorite = Favorite(
      place_id: place.placeId,
      user_id: cloud.auth.currentUser!.id,
      image: place.thumbnail,
      name: place.title,
      desc: place.description,
    );
    final favoriteSupa = FavoriteSupabase(
      userId: cloud.auth.currentUser!.id,
      placeId: place.placeId,
      name: place.title,
      desc: place.description,
      image: place.thumbnail,
      lat: place.coordinates?[0].lat,
      lng: place.coordinates?[0].lon,
    );
    await FavoritesService().addFavorite(favoriteSupa);
    await database.favoritedao.insertFavorite(addFavorite);

    try {
      final favController = Get.find<FavouritesController>();
      await favController.loadData();
    } catch (_) {}
  }

  Future<void> removeFromFav() async {
    await FavoritesService().removeFavoriteByPlaceId(
      place.placeId,
      cloud.auth.currentUser!.id,
    );
    await database.favoritedao.deleteFavorite(
      cloud.auth.currentUser!.id,
      place.placeId,
    );

    try {
      final favController = Get.find<FavouritesController>();
      await favController.loadData();
    } catch (_) {}
  }

  // Future<bool> isFavorite() async {
  //   final result = await database.favoritedao.selectOneFavPlace(
  //     cloud.auth.currentUser!.id,
  //     place.pageid,
  //   );
  //   return result != null;
  // }
  Future<bool> isFavorite() async {
    final userId = cloud.auth.currentUser!.id;

    // 1) دور في قاعدة البيانات المحلية (Floor)
    final localResult = await database.favoritedao.selectOneFavPlace(
      userId,
      place.placeId,
    );

    if (localResult != null) {
      return true; // لقاها محليًا
    }

    // 2) لو مش موجودة محليًا → دور في Supabase
    final supabaseResult = await FavoritesService().getFavoriteByPlaceId(
      place.placeId,
      userId,
    );

    // لو لقاها في السوبا بيز → خزنها محليًا عشان المرة الجاية
    if (supabaseResult != null) {
      await database.favoritedao.insertFavorite(
        Favorite(
          name: supabaseResult.name!,
          user_id: supabaseResult.userId,
          place_id: supabaseResult.placeId,
          added_at: supabaseResult.addedAt,
          desc: supabaseResult.desc,
          image: supabaseResult.image,
          lat: supabaseResult.lat,
          lng: supabaseResult.lng,
        ),
      );
      return true;
    }

    // لو ملقاش في الاتنين
    return false;
  }
}
