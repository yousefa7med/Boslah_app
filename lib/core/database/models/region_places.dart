import 'package:floor/floor.dart';

@Entity(
  tableName: 'region_places',)
class RegionPlace {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int region_id;
  final int? search_id;

  final String place_id;
  final String? name;
  final String? desc;
  final String? category;
  final String? image;


  final double lat;
  final double lng;



  RegionPlace({
    this.id,
    required this.region_id,
    required this.place_id,
    this.name,
    required this.lat,
    required this.lng,
    this.desc,
    this.category,
    this.image,
    this.search_id,
  });
}
