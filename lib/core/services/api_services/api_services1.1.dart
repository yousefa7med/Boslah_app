import 'dart:convert';

import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';
import 'package:depi_graduation_project/core/services/api_services/nearest_places_respone.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final dio = Dio();
  final baseUrl = "https://en.wikipedia.org/w/api.php";
  final rest = "https://en.wikipedia.org/api/rest_v1/page/summary/";

  Future<NearestPlacesResponse?> getNearbyPlaces(double lat, double lon) async {
    if (await hasInternet()) {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          "action": "query",
          "list": "geosearch",
          "gscoord": "$lat|$lon",
          "gsradius": 5000,
          "gslimit": 50,
          "format": "json",
        },
      );
      if (response.statusCode == 200) {
        final result = nearestPlacesResponseFromJson(
          json.encode(response.data),
        );
        return result;
      }
      return null;
    } else {
      throw AppException(msg: "Please Check your internet connection");
    }
  }

  // Future<PlaceDetailsResponse?> getSummary(String title) async {
  //   if (await hasInternet()) {
  //     final response = await dio.get(rest + Uri.encodeComponent(title));
  //     if (response.statusCode == 200) {
  //       final result = placeDetailsResponseFromJson(json.encode(response.data));
  //       return result;
  //     }
  //     return null;
  //   } else {
  //     throw AppException(msg: "Please Check your internet connection");
  //   }
  // }

  Future<List<PlaceModel>?> getPlacesWithDetails({
    required double lat,
    required double long,
  }) async {
    if (await hasInternet()) {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          "action": "query",
          "generator": "geosearch",
          "ggscoord": "$lat|$long",
          "ggsradius": 5000,
          "ggslimit": 10,
          "prop": "coordinates|pageimages|description|info",
          "piprop": "thumbnail",
          "pithumbsize": 1200,
          "inprop": "url",
          "format": "json",
          "origin": "*",
        },
      );

      if (response.statusCode == 200 && response.data['query'] != null) {
        final pages = response.data['query']['pages'] as Map<String, dynamic>;
        return pages.values
            .map((pageJson) => PlaceModel.fromJson(pageJson))
            .toList();
      }
      return null;
    } else {
      throw AppException(msg: "Please Check your internet connection");
    }
  }
}
