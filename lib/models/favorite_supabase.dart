import 'package:depi_graduation_project/models/place_model.dart';

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
    super.desc, required super.categories,
  });

  factory FavoriteSupabase.fromJson(Map<String, dynamic> json) {
    return FavoriteSupabase(
      userId: json['user_id'],
      placeId: json['place_id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      addedAt: json['added_at'],
      image: json['image'],
      desc: json['desc'],
      categories: json['categories']??[],

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
      'categories':categories
    };
  }
}
