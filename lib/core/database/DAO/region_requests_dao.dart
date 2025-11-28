
import 'package:depi_graduation_project/core/database/models/region_requests.dart';
import 'package:floor/floor.dart';

@dao
abstract class RegionRequestDao{

  @Query('SELECT * FROM region_requests WHERE user_id = :uid ORDER BY timestamp DESC LIMIT 1')
  Future<RegionRequest?> selectLastRequest(int uid);

  @Query('SELECT * FROM region_requests WHERE user_id = :uid ORDER BY region_id DESC')
  Stream<List<RegionRequest>> selectRequests(int uid);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertRegionRequest(RegionRequest rr);


}