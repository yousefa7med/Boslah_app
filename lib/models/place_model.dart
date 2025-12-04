class PlaceModel {
  final int placeId;
  final String name;
  final String? desc;
  final String? image;
  final double? lat;
  final double? lng;
  PlaceModel({
    this.lat,
    this.lng,
    required this.placeId,
    required this.name,
    this.image,
    this.desc,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeId: json["pageid"],
      name: json["title"],

      lat: json["coordinates"] != null
          ? json["coordinates"][0]["lat"]?.toDouble()
          : null,
      lng: json["coordinates"] != null
          ? json["coordinates"][0]["lon"]?.toDouble()
          : null,

      image: json["thumbnail"] != null ? json["thumbnail"]['source'] : null,

      desc: json["description"],
    );
  }
}
