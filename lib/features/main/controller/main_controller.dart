import 'package:Boslah/features/favourite/controller/favourite_controller.dart';
import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final favControoller = Get.put(FavouritesController());
  final scheduleController = Get.put(ScheduleController());
  bool isFavPage = false;
  @override
  Future<void> onInit() async {
 
    super.onInit();
  }

  Future<void> removeFavFromDB() async {
    if (isFavPage) {
      for (var place in favControoller.deleted) {
        print("object");
       await favControoller.removeFavoriteFromDB(place);
      }
    }
  }
}
