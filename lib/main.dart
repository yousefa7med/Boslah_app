import 'package:depi_graduation_project/core/services/api_services/api_services.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/register_view.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
          initialRoute: '/login',
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => ApiServices());
          }),
          getPages: [
            GetPage(
              name: '/home',
              page: () => const HomePage(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => HomeController());
              }),
            ),
            GetPage(
              name: '/login',
              page: () => const LoginView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => LoginController());
              }),
            ),
            GetPage(
              name: '/register',
              page: () => const RegisterView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => RegisterController());
              }),
            ),
          ],
        );
      },
    );
  }
}
