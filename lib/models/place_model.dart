class PlaceModel {
  final String name;
  final String disc;
  final String? img;
  final int long;
  final int lat;
  final double rate;

  PlaceModel({
    required this.name,
    required this.disc,
    this.img,
    required this.long,
    required this.lat,
    required this.rate,
  });

  factory PlaceModel.fromjson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json["properties"]['name'],
      disc: 'fghdjhjdfgsjkldfsjklfdsjkldfsjkldfjklsfdjklsdfjklsjdfklsfsdklsdkl',
      long: json["properties"]['lon'],
      lat: json["properties"]['lat'],
      rate: 3.2,
    );
  }
}
