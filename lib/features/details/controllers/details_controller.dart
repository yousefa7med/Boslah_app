import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/place_details_response.dart';

class DetailsController extends GetxController{

    RxBool favorite = true.obs; // initialize here
    Page? place=null;

    @override
    Future<void> onInit() async {
        // TODO: implement onInit
        favorite.value=await isFavorite();
        super.onInit();
    }

    Future<void> addToFav() async {
        final addFavorite=Favorite(place_id: place!.pageid.toString(),
            user_id: cloud.auth.currentUser.toString(),image: place!.thumbnail.toString(),name: place!.title);
        await database.favoritedao.insertFavorite(addFavorite);
    }

    Future<void> removeFromFav() async {

        await database.favoritedao.deleteFavorite(cloud.auth.currentUser.toString(),
            place!.pageid.toString());
    }

    Future<bool> isFavorite() async {
       final result= await database.favoritedao.selectOneFavPlace(place!.pageid.toString(),cloud.auth.currentUser.toString());
        return result!=null;
    }



}


