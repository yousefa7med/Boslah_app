// // To parse this JSON data, do
//
// //
// //     final placeDetailsResponse = placeDetailsResponseFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// SearchByTitleResponse placeDetailsResponseFromJson(String str) => SearchByTitleResponse.fromJson(json.decode(str));
//
// String placeDetailsResponseToJson(SearchByTitleResponse data) => json.encode(data.toJson());
//
// class SearchByTitleResponse {
//   final String batchcomplete;
//   final Query query;
//
//   SearchByTitleResponse({
//     required this.batchcomplete,
//     required this.query,
//   });
//
//   factory SearchByTitleResponse.fromJson(Map<String, dynamic> json) => SearchByTitleResponse(
//     batchcomplete: json["batchcomplete"],
//     query: Query.fromJson(json["query"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "batchcomplete": batchcomplete,
//     "query": query.toJson(),
//   };
// }
//
// class Query {
//   final Pages pages;
//
//   Query({
//     required this.pages,
//   });
//
//   factory Query.fromJson(Map<String, dynamic> json) => Query(
//     pages: Pages.fromJson(json["pages"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pages": pages.toJson(),
//   };
// }
//
// class Pages {
//   final The12345 the12345;
//
//   Pages({
//     required this.the12345,
//   });
//
//   factory Pages.fromJson(Map<String, dynamic> json) => Pages(
//     the12345: The12345.fromJson(json["12345"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "12345": the12345.toJson(),
//   };
// }
//
// class The12345 {
//   final int pageid;
//   final int ns;
//   final String title;
//   final List<Coordinate> coordinates;
//   final Thumbnail thumbnail;
//   final String extract;
//
//   The12345({
//     required this.pageid,
//     required this.ns,
//     required this.title,
//     required this.coordinates,
//     required this.thumbnail,
//     required this.extract,
//   });
//
//   factory The12345.fromJson(Map<String, dynamic> json) => The12345(
//     pageid: json["pageid"],
//     ns: json["ns"],
//     title: json["title"],
//     coordinates: List<Coordinate>.from(json["coordinates"].map((x) => Coordinate.fromJson(x))),
//     thumbnail: Thumbnail.fromJson(json["thumbnail"]),
//     extract: json["extract"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pageid": pageid,
//     "ns": ns,
//     "title": title,
//     "coordinates": List<dynamic>.from(coordinates.map((x) => x.toJson())),
//     "thumbnail": thumbnail.toJson(),
//     "extract": extract,
//   };
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
//     lat: json["lat"]?.toDouble(),
//     lon: json["lon"]?.toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lon": lon,
//   };
// }
//
// class Thumbnail {
//   final String source;
//   final int width;
//   final int height;
//
//   Thumbnail({
//     required this.source,
//     required this.width,
//     required this.height,
//   });
//
//   factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
//     source: json["source"],
//     width: json["width"],
//     height: json["height"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "source": source,
//     "width": width,
//     "height": height,
//   };
// }