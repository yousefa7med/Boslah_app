import 'package:floor/floor.dart';

@DatabaseView(
  '''
  SELECT region_places.*
  FROM region_places
  INNER JOIN region_requests
    ON region_places.region_id = region_requests.regionId
  ''',
  viewName: 'select_region_places',
)
class SelectRegionPlaces {
  final int region_id;
  final String place_id;
  final String? name;
  final double lat;
  final double lng;
  final String? desc;
  final bool? isFav;
  final String? category;
  final String? image;
  final String? googleLink;

  SelectRegionPlaces(
    this.region_id,
    this.place_id,
    this.name,
    this.lat,
    this.lng,
    this.desc,
    this.isFav,
    this.category,
    this.image,
    this.googleLink,
  );
}
