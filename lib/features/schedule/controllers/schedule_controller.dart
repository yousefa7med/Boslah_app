import 'package:depi_graduation_project/core/services/schedule_services/schedule_service.dart';
import 'package:depi_graduation_project/models/schedule_model.dart';
import 'package:depi_graduation_project/models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/database/models/schedules.dart';
import '../../../core/errors/app_exception.dart';
import '../../../main.dart';

class ScheduleController extends GetxController {
  final allSchedules = <ScheduleModel>[].obs;
  final error = RxnString();
  final selectedCard = 1.obs;
  final List<FilterModel> filterList = [
    FilterModel(text: 'All'),
    FilterModel(text: 'Upcoming', icon: Icons.pending_outlined),
    FilterModel(text: 'Completed', icon: Icons.done_all),
  ];

  @override
  void onInit() {
    print('initttttt');
    // TODO: implement onInit
    try {
      loadData();
    } on Exception catch (e) {
      error.value = e.toString();
    }

    super.onInit();
  }

  Future<void> loadData() async {
    print("sssssssssssssssssssssssss");
    try {
      final userId = cloud.auth.currentUser!.id;
      final localList = await database.scheduledao.selectSchedules(userId);

      if (localList.isNotEmpty) {
        allSchedules.value = localList;
        return;
      } else {
        allSchedules.value = await ScheduleService().getSchedulesSB(userId);
      }
    } catch (e) {
      throw AppException(msg: "Failed to load schedules");
    }
  }
}
