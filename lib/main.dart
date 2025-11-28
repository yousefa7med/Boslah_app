import 'package:depi_graduation_project/core/utilities/routes.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/register_view.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:depi_graduation_project/features/details/presentation/view/details_view.dart';
import 'package:depi_graduation_project/features/favourite/presentation/views/favourites_view.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:depi_graduation_project/features/main/main_view.dart';
import 'package:depi_graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/services/api_services/api_services1.1.dart';
import 'features/home/controllers/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 924),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.login,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => ApiServices());
            Get.lazyPut(() => HomeController(), fenix: true); // <- سجّله هنا
          }),
          getPages: [
            GetPage(
              name: Routes.home,
              page: () => const HomeView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => HomeController());
              }),
            ),
            GetPage(
              name: Routes.login,
              page: () => const LoginView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => LoginController());
              }),
            ),
            GetPage(
              name: Routes.register,
              page: () => const RegisterView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => RegisterController());
              }),
            ),
            GetPage(
              name: Routes.details,
              page: () => DetailsView(),
              binding: BindingsBuilder((){
                Get.lazyPut(()=>DetailsController());
              })
            ),
            GetPage(name: Routes.profile, page: () => const ProfileView()),
            GetPage(name: Routes.main, page: () => const MainView()),
            GetPage(
              name: Routes.favourites,
              page: () => const FavouritesView(),
            ),


          ],
        );
      },
    );
  }
}
