import 'package:Boslah/core/errors/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../models/favorite_supabase.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  FavoritesService._internal();
  factory FavoritesService() => _instance;
  Future<void> addFavorite(FavoriteSupabase fav) async {
    try {
      await cloud.from('favorites').insert(fav.toJson());
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to add favorite");
    }
  }

  Future<List<FavoriteSupabase>> getFavorites() async {
    final userId = cloud.auth.currentUser!.id;

    final res = await cloud.from('favorites').select().eq('user_id', userId);

    return res
        .map<FavoriteSupabase>((e) => FavoriteSupabase.fromJson(e))
        .toList();
  }

  Future<void> removeFavoriteByPlaceId(int placeId, String userId) async {
    try {
      await cloud
          .from('favorites')
          .delete()
          .eq('place_id', placeId)
          .eq('user_id', userId);
      print("removed from supa");
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to remove favorite");
    }
  }
}
