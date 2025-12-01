class FavoriteSupabase {
  final String userId;
  final int? placeId;
  final String? name;
  final double? lat;
  final double? lng;
  final int? addedAt;
  final String? image;
  final String? desc;

  FavoriteSupabase({
    required this.userId,
    this.placeId,
    this.name,
    this.lat,
    this.lng,
    this.addedAt,
    this.image,
    this.desc,
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
    };
  }
}
