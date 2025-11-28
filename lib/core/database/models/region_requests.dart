import 'package:floor/floor.dart';

@Entity(tableName: 'region_requests')
class RegionRequest {
  @PrimaryKey(autoGenerate: true)
  final int? region_id;

  final double lat;
  final double lng;
  final int timestamp;

  RegionRequest({
    this.region_id,
    required this.lat,
    required this.lng,
    required this.timestamp,
  });
}
