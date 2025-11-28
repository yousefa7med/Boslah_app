import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/place_details_response.dart';

class DetailsController extends GetxController {
  RxBool favorite = true.obs; // initialize here
  late Page place;

  @override
  Future<void> onInit() async {
    place = Get.arguments;
    favorite.value = await isFavorite();
    super.onInit();
  }

  Future<void> addToFav() async {
    final addFavorite = Favorite(
      place_id: place.pageid.toString(),
      user_id: cloud.auth.currentUser!.id,
      image: place.thumbnail!.source,
      name: place.title,
    );
    await database.favoritedao.insertFavorite(addFavorite);
  }

  Future<void> removeFromFav() async {
    await database.favoritedao.deleteFavorite(
      cloud.auth.currentUser!.id,
      place.pageid.toString(),
    );
  }

  Future<bool> isFavorite() async {
    final result = await database.favoritedao.selectOneFavPlace(
      cloud.auth.currentUser!.id,
      place.pageid.toString(),
    );
    return result != null;
  }
}
