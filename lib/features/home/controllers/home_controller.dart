import 'package:depi_graduation_project/core/services/api_services/api_services.dart';
import 'package:depi_graduation_project/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final searchController=TextEditingController();
  final selectedCard=1.obs;
  final position=Rxn<Position>();

  final all=[].obs;
  final museums=[].obs;
  final restaurant=[].obs;

  final api=Get.find<ApiServices>();
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   loadAll();
  // }

  void loadAll() async{
    position.value= await Location().getPosition();
    final data= api.getPlaces(lat: position.value!.latitude, long: position.value!.longitude);
  }

}