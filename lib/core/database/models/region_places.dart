import 'package:depi_graduation_project/models/place_model.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'region_places')
class RegionPlace extends PlaceModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int regionId;
  final int? searchId;

  RegionPlace({
    this.id,
    required this.regionId,
    required super.placeId,
    super.lat,
    super.lng,
    super.desc,
    required super.categories,
    super.image,
    this.searchId,
    required super.name,
  });

  Map<String, dynamic> toJson() => {
    'region_id': regionId,
    'search_id': searchId,
    'place_id': placeId,
    'name': name,
    'lat': lat,
    'lng': lng,
    'image': image,
    'desc': desc,
  };
}
