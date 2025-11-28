import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:dio/dio.dart';

class ApiServices1 {
  static Dio dio = Dio()..options.baseUrl = EndPoints.baseUrl;

  Future<List<dynamic>> getPlacesByCatagory({
    required String catagory,
    required double lat,
    required double long,
  }) async {
    Response<dynamic>? response;
    try {
       response = await dio.get(
        "categories=$catagory&filter=circle:$long,$lat,5000&bias=proximity:$long,$lat&limit=80&apiKey=${EndPoints.apiKey}",
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw AppException(
          msg: " error ${e.response!.statusCode} please try again leter",
        );
      }
    }

    return response?.data["features"];
  }

  Future<List<dynamic>> getPlaces({
    required double lat,
    required double long,
  }) async {
    String catPram =
        '${EndPoints.commercial},${EndPoints.catering},${EndPoints.emergency},${EndPoints.childcare},${EndPoints.entertainment},${EndPoints.healthcare},${EndPoints.tourism},${EndPoints.nationalPark}';
    Response<dynamic>? response;

    try {
   response = await dio.get(
    "categories=$catPram&filter=circle:$long,$lat,5000&bias=proximity:$long,$lat&limit=80&apiKey=${EndPoints.apiKey}",
  );
   } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw AppException(
          msg: " error ${e.response!.statusCode} please try again leter",
        );
      }
    }
    return response?.data["features"];
  }
}

class EndPoints {
  static const baseUrl = "https://api.geoapify.com/v2/places?";
  static const apiKey = "4e9c986caa8e404ca2e3e2ca96486a0d";
  static const commercial = "commercial";
  static const catering = "catering";
  static const emergency = "emergency";
  static const childcare = "childcare";
  static const entertainment = "entertainment";
  static const healthcare = "childcare";
  static const nationalPark = "national_park";
  static const tourism = "tourism";
}
