import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../models/favorite_supabase.dart';

class FavoritesService {
  Future<String?> addFavorite(FavoriteSupabase fav) async {
    try {
      await cloud.from('favorites').insert(fav.toJson());
      print('added done to supabase');
      return null;
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Failed to add favorite";
    }
  }

  Future<List<FavoriteSupabase>> getFavorites() async {
    final userId = cloud.auth.currentUser!.id;

    final res = await cloud.from('favorites').select().eq('user_id', userId);

    return res
        .map<FavoriteSupabase>((e) => FavoriteSupabase.fromJson(e))
        .toList();
  }

  Future<FavoriteSupabase?> getFavoriteByPlaceId(
    int placeId,
    String userId,
  ) async {
    final res = await cloud
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('place_id', placeId)
        .maybeSingle();
    if (res == null) return null;
    return FavoriteSupabase.fromJson(res);
  }

  Future<String> uploadFavoriteImage(File file) async {
    final fileBytes = await file.readAsBytes();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    // رفع الصورة للبوكت
    await cloud.storage.from('favorites').uploadBinary(fileName, fileBytes);

    // عمل URL عام أو path
    final url = cloud.storage.from('favorites').getPublicUrl(fileName);

    return url; // يتحط فمكان ال image
  }

  Future<String?> removeFavoriteByPlaceId(int placeId, String userId) async {
    try {
      await cloud
          .from('favorites')
          .delete()
          .eq('place_id', placeId)
          .eq('user_id', userId);
      print("removed from supa");

      return null;
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Failed to remove favorite";
    }
  }
}
