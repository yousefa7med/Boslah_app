// To parse this JSON data, do
//
//     final placeDetailsResponse = placeDetailsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlaceDetailsResponse placeDetailsResponseFromJson(String str) => PlaceDetailsResponse.fromJson(json.decode(str));

String placeDetailsResponseToJson(PlaceDetailsResponse data) => json.encode(data.toJson());

class PlaceDetailsResponse {
  final String batchcomplete;
  final Query query;

  PlaceDetailsResponse({
    required this.batchcomplete,
    required this.query,
  });

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) => PlaceDetailsResponse(
    batchcomplete: json["batchcomplete"],
    query: Query.fromJson(json["query"]),
  );

  Map<String, dynamic> toJson() => {
    "batchcomplete": batchcomplete,
    "query": query.toJson(),
  };
}

class Query {
  final Map<String, Page> pages;

  Query({
    required this.pages,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    pages: Map.from(json["pages"]).map((k, v) => MapEntry<String, Page>(k, Page.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "pages": Map.from(pages).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Page {
  final int pageid;
  final int ns;
  final String title;
  final int? index; // ممكن تكون null
  final List<Coordinate>? coordinates; // ممكن تكون null
  final String? description;
  final String? descriptionsource;
  final Thumbnail? thumbnail; // ممكن تكون null
  final String contentmodel;
  final String pagelanguage;
  final String pagelanguagehtmlcode;
  final String pagelanguagedir;
  final DateTime touched;
  final int lastrevid;
  final int length;
  final String fullurl;
  final String editurl;
  final String canonicalurl;

  Page({
    required this.pageid,
    required this.ns,
    required this.title,
    this.index,
    this.coordinates,
    this.thumbnail,
    this.description,
    this.descriptionsource,
    required this.contentmodel,
    required this.pagelanguage,
    required this.pagelanguagehtmlcode,
    required this.pagelanguagedir,
    required this.touched,
    required this.lastrevid,
    required this.length,
    required this.fullurl,
    required this.editurl,
    required this.canonicalurl,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    pageid: json["pageid"],
    ns: json["ns"],
    title: json["title"],
    index: json["index"],
    coordinates: json["coordinates"] != null
        ? List<Coordinate>.from(
        json["coordinates"].map((x) => Coordinate.fromJson(x)))
        : null,
    thumbnail: json["thumbnail"] != null
        ? Thumbnail.fromJson(json["thumbnail"])
        : null,
    description: json["description"],
    descriptionsource: json["descriptionsource"],
    contentmodel: json["contentmodel"] ?? '',
    pagelanguage: json["pagelanguage"] ?? '',
    pagelanguagehtmlcode: json["pagelanguagehtmlcode"] ?? '',
    pagelanguagedir: json["pagelanguagedir"] ?? '',
    touched: DateTime.parse(json["touched"]),
    lastrevid: json["lastrevid"] ?? 0,
    length: json["length"] ?? 0,
    fullurl: json["fullurl"] ?? '',
    editurl: json["editurl"] ?? '',
    canonicalurl: json["canonicalurl"] ?? '',
  );
}


class Coordinate {
  final double lat;
  final double lon;
  final String primary;
  final String globe;

  Coordinate({
    required this.lat,
    required this.lon,
    required this.primary,
    required this.globe,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    primary: json["primary"],
    globe: json["globe"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "primary": primary,
    "globe": globe,
  };
}

class Thumbnail {
  final String source;
  final int width;
  final int height;

  Thumbnail({
    required this.source,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    source: json["source"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "width": width,
    "height": height,
  };
}









