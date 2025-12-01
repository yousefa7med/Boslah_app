
import 'package:depi_graduation_project/core/database/models/region_places.dart';
import 'package:floor/floor.dart';

@dao
abstract class RegionPlacesDao{
  @Query('SELECT * FROM region_places WHERE region_id = :regionId')
  Future<List<RegionPlace>> selectRegionPlaces(int regionId);

  @Query('SELECT * FROM region_places WHERE place_id = :placeId')
  Future<RegionPlace?> selectPlaceById(int placeId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPlace(RegionPlace place);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRespPlaces(List<RegionPlace> rp);

  @Query('DELETE FROM region_places WHERE region_id = :regionId')
  Future<void> deletePlacesByRegion(int regionId);

}