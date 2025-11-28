import 'package:floor/floor.dart';

@Entity(
  tableName: 'favorites',
)
class Favorite {
  @PrimaryKey(autoGenerate: true)
  final int? fav_id;
  final int? user_id;

  final String? place_id;
  final String? name;

  final double lat;
  final double lng;

  final int added_at;

  Favorite({
    this.fav_id,
    this.place_id,
    this.name,
    this.user_id,
    required this.lat,
    required this.lng,
    required this.added_at,
  });
}
