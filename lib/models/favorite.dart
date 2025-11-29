class Favorite {
  final int? favId;
  final String userId;
  final String? placeId;
  final String? name;
  final double? lat;
  final double? lng;
  final int? addedAt;
  final String? image;
  final String? description;

  Favorite({
    this.favId,
    required this.userId,
    this.placeId,
    this.name,
    this.lat,
    this.lng,
    this.addedAt,
    this.image,
    this.description,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favId: json['fav_id'],
      userId: json['user_id'],
      placeId: json['place_id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      addedAt: json['added_at'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fav_id': favId,
      'user_id': userId,
      'place_id': placeId,
      'name': name,
      'lat': lat,
      'lng': lng,
      'added_at': addedAt,
      'image': image,
      'description': description,
    };
  }
}
