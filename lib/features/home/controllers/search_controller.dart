import 'package:Boslah/core/database/models/search_history.dart';
import 'package:Boslah/main.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_services/api_services.dart';

class searchController extends GetxController {
  final searchList = <PlaceModel>[].obs;
  var sController = TextEditingController();
  final api = Get.find<ApiServices>();

  final historySearch = <SearchHistory>[].obs;

  Future<void> loadData() async {
    final data = await api.searchPlacesWithImages(sController.text);
    searchList.value =
        data?.where((p) {
          if (p.image == null) {
            return false;
          }

          return true;
          // final title = p.title.toLowerCase();
          // final desc = p.description!.toLowerCase();
          // return keywords.any((k) {
          //   final key = k.toLowerCase();
          //   return title.toLowerCase().contains(key) || desc.toLowerCase().contains(key);
          // });
        }).toList() ??
        [];

    final history = SearchHistory(
      query: sController.text,
      timestamp: 1,
      userId: cloud.auth.currentUser!.id,
    );
    database.searchhistorydao.insertHistory(history);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HistorySearch();
  }

  Future<void> HistorySearch() async {
    final data = await database.searchhistorydao.selectHistory(
      cloud.auth.currentUser!.id,
    );
    historySearch.value = data ;
  }

  Future<void> clearHistory() async {
    historySearch.clear();
    await database.searchhistorydao.clearAll();
  }

  Future<void> onchange(String a) async {
    if (a.trim().isEmpty) {
      searchList.clear();
      await HistorySearch();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    api.cancelToken;
  }
}
