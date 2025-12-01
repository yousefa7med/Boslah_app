
class PlaceModel {
  final int placeId;
  final String title;
  final List<Coordinate>? coordinates; 
  final String? description;
  final String? thumbnail; 

  PlaceModel({
    required this.placeId,
    required this.title,
    this.coordinates,
    this.thumbnail,
    this.description,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    placeId: json["pageid"],
    title: json["title"],
    coordinates: json["coordinates"] != null
        ? List<Coordinate>.from(
            json["coordinates"].map((x) => Coordinate.fromJson(x)),
          )
        : null,
    thumbnail: json["thumbnail"]['source'],

    description: json["description"],
  );
}

class Coordinate {
  final double lat;
  final double lon;

  Coordinate({required this.lat, required this.lon});

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      Coordinate(lat: json["lat"]?.toDouble(), lon: json["lon"]?.toDouble());

  Map<String, dynamic> toJson() => {"lat": lat, "lon": lon};
}
