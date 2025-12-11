import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw "Please Open Location";
  }
  print('rrrrrrrrrrr');
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location Permission Required';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Location Permanently Denied';
  }
  print('dddddddddddddd');
  return await Geolocator.getCurrentPosition();
}
