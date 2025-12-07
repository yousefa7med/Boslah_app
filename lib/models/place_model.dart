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

// import 'dart:convert';
// import 'package:crypto/crypto.dart';
//
// class PlaceModel {
//   final int placeId;
//   final String title;
//   final List<Coordinate>? coordinates;
//   final String? description;
//   final String? thumbnail;         // Wikipedia only
//   final List<String>? categories;  // Geoapify only
//   final int? distance;             // Geoapify only
//
//   PlaceModel({
//     required this.placeId,
//     required this.title,
//     this.coordinates,
//     this.thumbnail,
//     this.description,
//     this.categories,
//     this.distance,
//   });
//
//   /// Generate integer ID from a string for Geoapify
//   static int _stringToIntId(String input) {
//     final hash = md5.convert(utf8.encode(input)).toString().substring(0, 8);
//     return int.parse(hash, radix: 16);
//   }
//
//   factory PlaceModel.fromJson(Map<String, dynamic> json) {
//
//     /// WIKIPEDIA API
//     if (json.containsKey("pageid")) {
//       return PlaceModel(
//         placeId: json["pageid"], // Already int
//         title: json["title"] ?? "Unknown",
//         coordinates: json["coordinates"] != null
//             ? List<Coordinate>.from(
//           json["coordinates"].map((x) => Coordinate.fromJson(x)),
//         )
//             : null,
//         thumbnail: json["thumbnail"]?["source"],
//         description: json["description"],
//       );
//     }
//
//     /// GEOAPIFY API
//     if (json.containsKey("properties")) {
//       final props = json["properties"];
//       final geometry = json["geometry"];
//
//       final coords = geometry?["coordinates"];
//       final double lon = coords?[0]?.toDouble() ?? 0;
//       final double lat = coords?[1]?.toDouble() ?? 0;
//
//       final rawId = props["place_id"]?.toString() ?? "geo_unknown";
//
//       return PlaceModel(
//         placeId: _stringToIntId(rawId),        // convert to int safely
//         title: props["name"] ?? "Unknown",
//         description: props["formatted"] ?? props["address_line2"],
//         categories: props["categories"] != null
//             ? List<String>.from(props["categories"])
//             : null,
//         coordinates: [
//           Coordinate(lat: lat, lon: lon),
//         ],
//         distance: props["distance"],
//       );
//     }
//
//     /// Unknown structure
//     return PlaceModel(
//       placeId: 0,
//       title: "Unknown",
//     );
//   }
// }
//
// class Coordinate {
//   final double lat;
//   final double lon;
//
//   Coordinate({
//     required this.lat,
//     required this.lon,
//   });
//
//   factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
//     lat: (json["lat"] ?? 0).toDouble(),
//     lon: (json["lon"] ?? 0).toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {"lat": lat, "lon": lon};
// }

