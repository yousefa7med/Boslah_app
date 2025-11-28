
import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavoriteDao{

  @Query('SELECT * FROM favorites WHERE user_id = :userId')
  Future<List<Favorite>> selectFavorites(int userId);


  @Query('select * from favorites where fav_id = :placeid')
  Future<Favorite?> selectOneFavPlace(int placeid);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertFavorite(Favorite favPlace);


  @Query('DELETE FROM favorites WHERE user_id = :uid AND place_id = :placeId')
  Future<void> deleteFavorite(int uid, String placeId);


  @Query('DELETE FROM favorites WHERE user_id = :uid')
  Future<void> deleteAllFavoritesByUser(int uid);

}