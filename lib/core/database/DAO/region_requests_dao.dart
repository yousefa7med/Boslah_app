
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:floor/floor.dart';

@dao
abstract class RegionRequestDao{

  @Query('SELECT * FROM region_requests WHERE user_id = :uid ORDER BY timestamp DESC LIMIT 1')
  Future<RegionRequest?> selectLastRequest(String uid);

  @Query('SELECT * FROM region_requests ORDER BY region_id DESC')
  Future<List<RegionRequest>> selectRequests();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertRegionRequest(RegionRequest rr);


}