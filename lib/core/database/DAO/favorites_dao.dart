import 'package:depi_graduation_project/core/database/models/favorites.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM favorites WHERE userId = :userId')
  Future<List<Favorite>> selectFavorites(String userId);

  @Query('select * from favorites WHERE userId = :uid AND placeId = :placeId')
  Future<Favorite?> selectOneFavPlace(String uid, int placeId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertFavorite(Favorite favPlace);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertManyFavorite(List<Favorite> favPlace);

  @Query('DELETE FROM favorites WHERE userId = :uid AND placeId = :placeId')
  Future<void> deleteFavorite(String uid, int placeId);

  @Query('DELETE FROM favorites WHERE userId = :uid')
  Future<void> deleteAllFavoritesByUser(String uid);
}
