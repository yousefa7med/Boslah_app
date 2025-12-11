import 'package:Boslah/models/place_model.dart';

class FavoriteSupabase extends PlaceModel {
  final String userId;

  final int? addedAt;
  @override
  FavoriteSupabase({
    required this.userId,
    this.addedAt,
    required super.placeId,
    required super.name,
    super.lat,
    super.lng,
    super.image,
    super.desc,
    required super.categories,
  });
  factory FavoriteSupabase.fromJson(Map<String, dynamic> json) {
    return FavoriteSupabase(
      userId: json['user_id'] ?? '',
      placeId: json['place_id'] as int,

      name: json['name'] ?? '',
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      addedAt: json['added_at'] is int
          ? json['added_at']
          : int.tryParse(json['added_at']?.toString() ?? ''),
      image: json['image'],
      desc: json['desc'],
      categories: json['categories'] is List
          ? List<String>.from(json['categories'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'place_id': placeId,
      'name': name,
      'lat': lat,
      'lng': lng,
      'added_at': addedAt,
      'image': image,
      'desc': desc,
      'categories': categories,
    };
  }
}
