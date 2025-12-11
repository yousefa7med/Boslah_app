import 'package:Boslah/features/favourite/controller/favourite_controller.dart';
import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final favControoller = Get.put(FavouritesController());
  final scheduleController = Get.put(ScheduleController());
  bool isFavPage = false;
  @override
  Future<void> onInit() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    super.onInit();
  }

  void removeFavFromDB() {
    if (isFavPage) {
      for (var place in favControoller.deleted) {
        print("object");
        favControoller.removeFavoriteFromDB(place);
      }
    }
  }
}
