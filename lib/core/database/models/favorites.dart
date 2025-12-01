import 'package:floor/floor.dart';

@Entity(tableName: 'favorites')
class Favorite {
  @PrimaryKey(autoGenerate: true)
  final int? fav_id;
  final int? place_id;
  final int? added_at;

  final String user_id;
  final String name;
  final String? image;
  final String? desc;
  final String? category;

  final double? lat;
  final double? lng;

  Favorite({
    this.fav_id,
    this.place_id,
    this.added_at,
    required this.name,
    required this.user_id,
    this.desc,
    this.image,
    this.category,
    this.lat,
    this.lng,
  });
}
