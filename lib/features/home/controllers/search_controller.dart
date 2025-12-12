import 'package:Boslah/core/database/models/region_places.dart';
import 'package:Boslah/core/database/models/region_requests.dart';
import 'package:Boslah/core/database/models/search_history.dart';
import 'package:Boslah/main.dart';
import 'package:Boslah/models/place_model.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/functions/get_postion.dart';
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
        }).toList() ??
        [];


      final history=SearchHistory(query: sController.text, timestamp: 1, userId: cloud.auth.currentUser!.id);
      await database.searchhistorydao.insertHistory(history);

      // try {
      //   final position = await getPosition();
      //   final history=SearchHistory(query: sController.text, timestamp: 1, userId: cloud.auth.currentUser!.id);
      //   final searchID=await database.searchhistorydao.insertHistory(history);
      //   final regionRequest=RegionRequest(lat: position.latitude, lng: position.longitude);
      //   final id=await database.regionrequestdao.insertRegionRequest(regionRequest);
      //   if(data!=null){
      //     for(var d in data){
      //       final regionPlace=RegionPlace(regionId: id, placeId:d.placeId , categories: d.categories, name: d.name,searchId: searchID);
      //       await database.regionplacedao.insertPlace(regionPlace);
      //     }
      //   }
      // } on Exception catch (e) {
      //   rethrow;
      // }


  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HistorySearch();
  }

  Future<void> HistorySearch() async {
    final data=await database.searchhistorydao.selectHistory(cloud.auth.currentUser!.id);
    historySearch.value=data??[];
  }

  Future<void> clearHistory() async {
    historySearch.clear();
    await database.searchhistorydao.clearAll();
  }

  Future<void> onchange(String a) async {
     if(a.trim().isEmpty){
       searchList.clear();
       await HistorySearch();
     }
  }

  // Future<void> clickOnHistoryCard() async {
  //   final id=await database.searchhistorydao.selectId(sController.text);
  //   final places=await database.regionplacedao.selectplacesbysearchid(id!);
  //     searchList.assignAll(places as List<PlaceModel>);
  // }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    api.cancelToken;
  }
}
