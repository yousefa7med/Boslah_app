import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../models/favorite.dart';

class FavoritesService {
  Future<String?> addFavorite(Favorite fav) async {
    try {
      await cloud.from('favorites').insert(fav.toJson());
      return null;
    } on PostgrestException catch (e) {
      return e.message;
    } catch (e) {
      return "Failed to add favorite";
    }
  }

  Future<List<Favorite>> getFavorites() async {
    final userId = cloud.auth.currentUser!.id;

    final res = await cloud.from('favorites').select().eq('user_id', userId);

    return res.map<Favorite>((e) => Favorite.fromJson(e)).toList();
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
}
