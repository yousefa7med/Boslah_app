import 'package:floor/floor.dart';

@Entity(
  tableName: 'favorites',
)
class Favorite {
  @PrimaryKey(autoGenerate: true)
  final int? fav_id;
  final String? user_id;

  final String? place_id;
  final String? name;

  final double? lat;
  final double? lng;

  final int? added_at;
  final String? image;

  Favorite({
    this.fav_id,
    this.place_id,
    this.name,
    this.user_id,
    this.lat,
    this.lng,
    this.added_at,
    this.image
  });
}
