import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/has_internet.dart';
import 'package:depi_graduation_project/models/place_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();
  factory ApiServices() => _instance;
  ApiServices._internal();

  final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 4)));

  final cancelToken = CancelToken();

  void cancel() {
    cancelToken.cancel();
  }

  final baseUrl = "https://en.wikipedia.org/w/api.php";
  final rest = "https://en.wikipedia.org/api/rest_v1/page/summary/";

  Future<List<PlaceModel>?> getPlacesWithDetails({
    required double lat,
    required double long,
  }) async {
    if (await hasInternet()) {
      try {
        final response = await dio.get(
          cancelToken: cancelToken,
          baseUrl,
          queryParameters: {
            "action": "query",
            "generator": "geosearch",
            "ggscoord": "$lat|$long",
            "ggsradius": 5000,
            "ggslimit": 20,
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
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout) {
          throw AppException(msg: "Request timed out");
        }
      }
    } else {
      throw AppException(msg: "Please Check your internet connection");
    }
    return null;
  }

  Future<List<PlaceModel>?> searchPlacesWithImages(String title) async {
    if (await hasInternet()) {
      try {
        final response = await dio.get(
          baseUrl,
          queryParameters: {
            "action": "query",
            "generator": "search",
            "gsrsearch": title,
            "gsrlimit": 20,
            "prop": "pageimages|info",
            "inprop": "url",
            "piprop": "thumbnail",
            "pithumbsize": 600, // حجم الصورة
            "format": "json",
            "origin": "*",
          },
          cancelToken: cancelToken,
        );

        if (response.statusCode == 200 &&
            response.data["query"] != null &&
            response.data["query"]["pages"] != null) {
          final pages = response.data["query"]["pages"] as Map<String, dynamic>;

          return pages.values
              .map((pageJson) => PlaceModel.fromJson(pageJson))
              .toList();
        }

        return null;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout) {
          throw AppException(msg: "Request timed out");
        }
      }
    } else {
      throw AppException(msg: "Please Check your internet connection");
    }
    return null;
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
}
