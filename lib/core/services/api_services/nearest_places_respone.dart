// To parse this JSON data, do
//
//     final nearestPlacesResponse = nearestPlacesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NearestPlacesResponse nearestPlacesResponseFromJson(String str) => NearestPlacesResponse.fromJson(json.decode(str));

String nearestPlacesResponseToJson(NearestPlacesResponse data) => json.encode(data.toJson());

class NearestPlacesResponse {
  final String batchcomplete;
  final Continue nearestPlacesResponseContinue;
  final Query query;

  NearestPlacesResponse({
    required this.batchcomplete,
    required this.nearestPlacesResponseContinue,
    required this.query,
  });

  factory NearestPlacesResponse.fromJson(Map<String, dynamic> json) => NearestPlacesResponse(
    batchcomplete: json["batchcomplete"],
    nearestPlacesResponseContinue: Continue.fromJson(json["continue"]),
    query: Query.fromJson(json["query"]),
  );

  Map<String, dynamic> toJson() => {
    "batchcomplete": batchcomplete,
    "continue": nearestPlacesResponseContinue.toJson(),
    "query": query.toJson(),
  };
}

class Continue {
  final String continueContinue;
  final String gscontinue;

  Continue({
    required this.continueContinue,
    required this.gscontinue,
  });

  factory Continue.fromJson(Map<String, dynamic> json) => Continue(
    continueContinue: json["continue"],
    gscontinue: json["gscontinue"],
  );

  Map<String, dynamic> toJson() => {
    "continue": continueContinue,
    "gscontinue": gscontinue,
  };
}

class Query {
  final List<Geosearch> geosearch;

  Query({
    required this.geosearch,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    geosearch: List<Geosearch>.from(json["geosearch"].map((x) => Geosearch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "geosearch": List<dynamic>.from(geosearch.map((x) => x.toJson())),
  };
}

class Geosearch {
  final int pageid;
  final int ns;
  final String title;
  final double lat;
  final double lon;
  final double dist;
  final String primary;

  Geosearch({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.lat,
    required this.lon,
    required this.dist,
    required this.primary,
  });

  factory Geosearch.fromJson(Map<String, dynamic> json) => Geosearch(
    pageid: json["pageid"],
    ns: json["ns"],
    title: json["title"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    dist: json["dist"]?.toDouble(),
    primary: json["primary"],
  );

  Map<String, dynamic> toJson() => {
    "pageid": pageid,
    "ns": ns,
    "title": title,
    "lat": lat,
    "lon": lon,
    "dist": dist,
    "primary": primary,
  };
}
