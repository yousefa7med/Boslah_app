// class GeoapifyPlaceModel {
//   final String id;
//   final String name;
//   final double lat;
//   final double lon;
//   final String? description;
//   final List<String>? categories;
//   final int? distance;
//
//   GeoapifyPlaceModel({
//     required this.id,
//     required this.name,
//     required this.lat,
//     required this.lon,
//     this.description,
//     this.categories,
//     this.distance,
//   });
//
//   factory GeoapifyPlaceModel.fromJson(Map<String, dynamic> json) {
//     final props = json['properties'];
//
//     return GeoapifyPlaceModel(
//       id: props["place_id"],
//       name: props["name"] ?? "Unknown",
//       lat: props["lat"]?.toDouble(),
//       lon: props["lon"]?.toDouble(),
//       description: props["description"],
//       categories: props["categories"] != null
//           ? List<String>.from(props["categories"])
//           : null,
//       distance: props["distance"],
//     );
//   }
// }