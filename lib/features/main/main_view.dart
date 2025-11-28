import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/features/favourite/presentation/views/favourites_view.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:depi_graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../favourite/controller/favourite_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) =>
          Style6BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}

List<PersistentTabConfig> _tabs() => [
  PersistentTabConfig(
    screen: const HomeView(),
    item: ItemConfig(
      icon: const Icon(Icons.home),
      title: 'Home',
      activeForegroundColor: AppColors.main,
      inactiveForegroundColor: Colors.grey,
    ),
  ),
  // PersistentTabConfig(
  //   screen: const FavouritesView(),
  //   item: ItemConfig(
  //     icon: const Icon(Icons.favorite_border),
  //     title: 'Favourites',
  //     activeForegroundColor: AppColors.main,
  //     inactiveForegroundColor: Colors.grey,
  //   ),
  // ),
  PersistentTabConfig(
    screen: const ProfileView(),
    item: ItemConfig(
      icon: const Icon(Icons.person),
      title: 'Profile',
      activeForegroundColor: AppColors.main,
      inactiveForegroundColor: Colors.grey,
    ),
  ),
  PersistentTabConfig(
    screen: Builder(
      builder: (_) {
        // Ensure the controller is initialized
        if (!Get.isRegistered<FavouritesController>()) {
          Get.put(FavouritesController());
        }
        return const FavouritesView();
      },
    ),
    item: ItemConfig(
      icon: const Icon(Icons.favorite_border),
      title: 'Favourites',
      activeForegroundColor: AppColors.main,
      inactiveForegroundColor: Colors.grey,
    ),
  ),
];
