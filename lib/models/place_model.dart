import 'dart:convert';
import 'package:Boslah/core/utilities/assets.dart';
import 'package:crypto/crypto.dart';

class PlaceModel {
  final int placeId;
  final String name;
  final String? desc;
  final String? image;
  final double? lat;
  final double? lng;
  final List<String> categories;

  PlaceModel({
    this.lat,
    this.lng,
    required this.placeId,
    required this.name,
    this.image,
    this.desc,
    required this.categories,
  });

  // Generate integer ID from a string for Geoapify
  static int _stringToIntId(String input) {
    final hash = md5.convert(utf8.encode(input)).toString().substring(0, 8);
    return int.parse(hash, radix: 16);
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    // Wiki
    if (json.containsKey("pageid")) {
      return PlaceModel(
        placeId: json["pageid"],
        name: json["title"],

        lat: json["coordinates"] != null
            ? json["coordinates"][0]["lat"]?.toDouble()
            : null,
        lng: json["coordinates"] != null
            ? json["coordinates"][0]["lon"]?.toDouble()
            : null,

        image: json["thumbnail"] != null
            ? json["thumbnail"]['source']
            : Assets.imagesDefaultPhotosTourism,

        desc: json["description"],
        categories: ["Tourism"],
      );
    }

    // GEOAPIFY
    if (json.containsKey("properties")) {
      final props = json["properties"];

      final rawId = props["place_id"]?.toString() ?? "geo_unknown";

      return PlaceModel(
        placeId: _stringToIntId(rawId), // convert to int
        name: props["name"] ?? "Unknown",
        desc: props["formatted"] ?? props["address_line2"],
        categories: props["categories"] != null
            ? List<String>.from(props["categories"])
            : [],
        lat: props["lat"],
        lng: props["lon"],
        image: getDefaultPhoto(
          props["categories"] != null
              ? List<String>.from(props["categories"])
              : [],
        ),
      );
    }
    // Unknown structure
    return PlaceModel(placeId: 0, name: "Unknown", categories: []);
  }
  static String getDefaultPhoto(final List<String> categories) {
    switch (categories[0]) {
      case 'airport':
        return Assets.imagesDefaultPhotosAirport;
      case 'commercial':
        return Assets.imagesDefaultPhotosShoppingMall;

      case 'catering':
        if (categories[1] == 'catering.cafe') {
          return Assets.imagesDefaultPhotosCafe;
        } else {
          return Assets.imagesDefaultPhotosRestaurant;
        }
      case 'accommodation':
        return Assets.imagesDefaultPhotosHotel;
      case 'national_park':
        return Assets.imagesDefaultPhotosNationalPark;
      case 'entertainment':
        return Assets.imagesDefaultPhotosEntertainment;
      case 'sport':
        return Assets.imagesDefaultPhotosSport;
      case 'beach':
        return Assets.imagesDefaultPhotosBeach;
      case 'religion':
        return Assets.imagesDefaultPhotosReligion;
      case 'natural':
        return Assets.imagesDefaultPhotosNatural;

      default:
        return Assets.imagesDefaultPhotosNoImageAvailable;
    }
  }

  bool isAssetPath(String path) {
    // يبدأ بـ assets/
    if (path.startsWith('assets/')) return true;
    return false;
  }
}
