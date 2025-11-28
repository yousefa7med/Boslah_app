import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';

import '../../../core/database/models/favorites.dart';

class FavouritesController extends GetxController{

  final allFavourits=<Favorite>[].obs;
  final isFavourite = <RxBool>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    allFavourits.value= await database.favoritedao.selectFavorites(cloud.auth.currentUser as String);
    if(allFavourits.isNotEmpty){
      isFavourite.addAll(List.generate(allFavourits.length, (_) => true.obs));
    }
  }

}