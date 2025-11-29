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
    place = Get.arguments;
    if (pendingFavorite != null) {
      favorite.value = pendingFavorite!;
    } else {
      // غير كده، جيب القيمة الحقيقية من الداتا بيز
      favorite.value = await isFavorite();
    }
    super.onInit();
  }

  Future<void> addToFav() async {
    final addFavorite = Favorite(
      place_id: place.pageid.toString(),
      user_id: cloud.auth.currentUser!.id,
      image: place.thumbnail?.source,
      name: place.title,
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
      place.pageid.toString(),
    );

    try {
      final favController = Get.find<FavouritesController>();
      await favController.loadData();
    } catch (_) {}
  }

  Future<bool> isFavorite() async {
    final result = await database.favoritedao.selectOneFavPlace(
      cloud.auth.currentUser!.id,
      place.pageid.toString(),
    );
    return result != null;

  }


  Timer? t;
  bool? pendingFavorite; // القيمة المنتظرة

  void onFavPressed(bool isFav) {
    // احفظ القيمة المؤقتة
    pendingFavorite = isFav;

    // غيّر UI فورًا
    favorite.value = isFav;

    // الغي أي تايمر شغال
    t?.cancel();

    // عمل تايمر جديد
    t = Timer(Duration(seconds: 1), () async {
      if (pendingFavorite == true) {
        await addToFav();
      } else {
        await removeFromFav();
      }
      pendingFavorite = null;
    });
  }
}
