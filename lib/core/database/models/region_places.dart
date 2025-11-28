import 'package:floor/floor.dart';

@Entity(
  tableName: 'region_places',)
class RegionPlace {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int region_id;

  final String place_id;
  final String? name;
  final double lat;
  final double lng;
  final String? desc;
  final bool? isFav;
  final String? category;
  final String? image;
  final String? googleLink;


  RegionPlace({
    this.id,
    required this.region_id,
    required this.place_id,
    this.name,
    required this.lat,
    required this.lng,
    this.desc,
    this.isFav,
    this.category,
    this.image,
    this.googleLink,
  });
}
