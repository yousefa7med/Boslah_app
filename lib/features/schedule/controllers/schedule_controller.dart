import 'package:get/get.dart';

import '../../../core/database/models/schedules.dart';
import '../../../core/errors/app_exception.dart';
import '../../../main.dart';

class ScheduleController extends GetxController {
  final allSchedules = <Schedule>[].obs;
  final error = RxnString();
  final selectedCard = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    try {
      loadData();
    } on Exception catch (e) {
      error.value = e.toString();
    }

    super.onInit();
  }

  Future<void> loadData() async {
    try {
      final userId = cloud.auth.currentUser!.id;
      final localList = await database.scheduledao.selectSchedules(userId);

      if (localList.isNotEmpty) {
        allSchedules.value = localList;
        return;
      }
    } catch (e) {
      throw AppException(msg: "Failed to load schedules");
    }
  }
}
