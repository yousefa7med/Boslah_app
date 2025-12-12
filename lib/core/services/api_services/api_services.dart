import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/has_internet.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();
  factory ApiServices() => _instance;
  ApiServices._internal();
  final String geoApiKey = "29d9a542ed1f4de1994142b6ca3675dc";

  final wikiDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 4),
      baseUrl: "https://en.wikipedia.org/w/",
    ),
  );
  final geoDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 4),
      baseUrl: "https://api.geoapify.com/v2/",
    ),
  );
  final cancelToken = CancelToken();

  void cancel() {
    cancelToken.cancel();
  }

  Future<List<PlaceModel>?> getPlaces({
    required double lat,
    required double long,
    int radius = 5000,
  }) async {
    if (await hasInternet()) {
      try {
        final result = await Future.wait([
          wikiDio.get(
            "api.php",
            cancelToken: cancelToken,

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
          ),

          geoDio.get(
            'places',
            cancelToken: cancelToken,

            queryParameters: {
              "categories":
                  "airport,commercial.shopping_mall,commercial.gift_and_souvenir"
                  ",catering,accommodation.hotel,national_park,entertainment,sport,beach,religion,natural",
              "filter": "circle:$long,$lat,$radius",
              "limit": "20",
              "apiKey": geoApiKey,
            },
          ),
        ]);

        final wikiResponse = result[0];
        final geoResponse = result[1];
        final List<PlaceModel> returnedList = [];

        if (wikiResponse.statusCode == 200 &&
            wikiResponse.data['query'] != null) {
          final pages =
              wikiResponse.data['query']['pages'] as Map<String, dynamic>;
          returnedList.addAll(
            pages.values
                .map((pageJson) => PlaceModel.fromJson(pageJson))
                .toList()
                .where((e) => e.lat != null && e.lng != null)
                .toList(),
          );
        }

        if (geoResponse.statusCode == 200 &&
            geoResponse.data['features'] != null) {
          final features = geoResponse.data['features'] as List;

          returnedList.addAll(
            features.map((f) => PlaceModel.fromJson(f)).toList(),
          );
        }
        returnedList.shuffle();
        return returnedList;
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
        final response = await wikiDio.get(
          "api.php",
          queryParameters: {
            "action": "query",
            "generator": "search",
            "gsrsearch": title,
            "gsrlimit": 20,
            "prop":"pageimages|info|coordinates",
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
              .toList()
              .where((e) => (e.lat != null && e.lng != null))
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
