import 'package:Boslah/core/database/models/region_places.dart';
import 'package:floor/floor.dart';

@dao
abstract class RegionPlacesDao {
  @Query('SELECT * FROM region_places WHERE regionId = :regionId')
  Future<List<RegionPlace>> selectRegionPlaces(int regionId);

  @Query('SELECT * FROM region_places WHERE placeId = :placeId')
  Future<RegionPlace?> selectPlaceById(int placeId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPlace(RegionPlace place);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRespPlaces(List<RegionPlace> rp);

  @Query('DELETE FROM region_places WHERE regionId = :regionId')
  Future<void> deletePlacesByRegion(int regionId);
}
