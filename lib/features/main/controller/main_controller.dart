import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final favControoller = FavouritesController();
  final scheduleController = ScheduleController();
  bool isFavPage = false;

  void removeFavFromDB() {
    if (isFavPage) {
      for (var place in favControoller.deleted) {
        print("object");
        favControoller.removeFavoriteFromDB(place);
      }
    }
  }
}
