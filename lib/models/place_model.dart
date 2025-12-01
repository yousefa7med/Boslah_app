
class PlaceModel {
  final int placeId;
  final String name;
  final String? desc;
  final String? image; 
  final double? lat;
  final double? lng;

  PlaceModel({this.lat, this.lng, 
    required this.placeId,
    required this.name,
    this.image,
    this.desc,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    placeId: json["pageid"],
    name: json["title"],

    lat:json["coordinates"][0] ["lat"]?.toDouble(),
   lng :json["coordinates"][0] ["lon"]?.toDouble(),
 
    image: json["thumbnail"]['source'],

    desc: json["description"],
  );
}


