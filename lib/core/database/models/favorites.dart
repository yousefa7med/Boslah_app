import 'package:Boslah/models/place_model.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'favorites')
class Favorite extends PlaceModel {
  @PrimaryKey(autoGenerate: true)
  final int? favId;

  final int? addedAt;

  final String userId;

  Favorite({
    this.favId,
    this.addedAt,
    required this.userId,
    required super.placeId,
    required super.name,
    super.desc,
    super.image,
    super.lat,
    super.lng,
    required super.categories,
  });
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'place_id': placeId,
    'name': name,
    'lat': lat,
    'lng': lng,
    'added_at': addedAt,
    'image': image,
    'desc': desc,
  };
}
