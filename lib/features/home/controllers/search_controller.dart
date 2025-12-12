import 'package:Boslah/core/errors/app_exception.dart';
import 'package:Boslah/core/functions/snack_bar.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services.dart';

class searchController extends GetxController {
  final searchList = <PlaceModel>[].obs;
  var sController = TextEditingController();
  final api = Get.find<ApiServices>();

  Future<void> loadData() async {
    print('gooooooooooo');
    try {
      final data = await api.searchPlacesWithImages(sController.text);
      searchList.value =
          data?.where((p) {
            if (p.image == null) {
              return false;
            }
            return true;
          }).toList() ??
          [];
    } on AppException catch (e) {
      showSnackBar(e.msg);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    api.cancelToken;
  }
}
