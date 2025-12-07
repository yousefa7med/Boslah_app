import 'package:depi_graduation_project/core/errors/app_exception.dart';
import 'package:depi_graduation_project/core/functions/is_dark.dart';
import 'package:depi_graduation_project/core/functions/snack_bar.dart';
import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:depi_graduation_project/features/favourite/presentation/views/favourites_view.dart';
import 'package:depi_graduation_project/features/home/controllers/home_controller.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:depi_graduation_project/features/main/controller/main_controller.dart';
import 'package:depi_graduation_project/features/profile/controllers/profile_controller.dart';
import 'package:depi_graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:depi_graduation_project/features/schedule/presentation/view/schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../favourite/controller/favourite_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        height: 58,
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: isDark() ? AppColors.darkSurface : Colors.white,
        ),
      ),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      onTabChanged: (value) {
        print(value);
        if (value == 1) {
          controller.isFavPage = true;
        } else {
          if (controller.isFavPage &&
              controller.favControoller.deleted.isNotEmpty) {
            try {
              controller.removeFavFromDB();
              controller.favControoller.deleted.clear();
            } on AppException catch (e) {
              showSnackBar(context, e.msg);
            } catch (e) {
              showSnackBar(context, e.toString());
            }
            controller.isFavPage = false;
            controller.favControoller.isFav.clear();
            controller.favControoller.isFav.addAll(
              List.generate(
                controller.favControoller.allFavourits.length,
                (i) => true.obs,
              ),
            );
          }
        }

        // controller.
        // if (value != 1) {
        //   for (var place in cont.deleted) {
        //     cont.removeFavoriteFromDB(place);
        //   }
        // } else {
        //   cont.isFav.clear();
        //   cont.isFav.addAll(
        //     List.generate(cont.allFavourits.length, (i) => true.obs),
        //   );
        // }
      },
      tabs: [
        PersistentTabConfig(
          screen: Builder(
            builder: (_) {
              // Ensure the controller is initialized
              if (!Get.isRegistered<HomeController>()) {
                Get.put(HomeController());
              }
              return const HomeView();
            },
          ),

          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeForegroundColor: AppColors.main,
            inactiveForegroundColor: Colors.grey,
          ),
        ),

        PersistentTabConfig(
          screen: Builder(
            builder: (_) {
              // Ensure the controller is initialized
              if (!Get.isRegistered<FavouritesController>()) {
                Get.put(controller.favControoller);
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
        PersistentTabConfig(
          screen: Builder(
            builder: (_) {
              // Ensure the controller is initialized
              if (!Get.isRegistered<ScheduleController>()) {
                Get.put(ScheduleController());
              }
              return const ScheduleView();
            },
          ),
          item: ItemConfig(
            icon: const Icon(Icons.schedule),
            title: 'Schedule',
            activeForegroundColor: AppColors.main,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
        PersistentTabConfig(
          screen: Builder(
            builder: (_) {
              // Ensure the controller is initialized
              if (!Get.isRegistered<ProfileController>()) {
                Get.put(ProfileController());
              }
              return const ProfileView();
            },
          ),
          item: ItemConfig(
            icon: const Icon(Icons.person),
            title: 'Profile',
            activeForegroundColor: AppColors.main,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
