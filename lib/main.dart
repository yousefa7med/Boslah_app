import 'dart:io';
import 'dart:typed_data';
import 'package:depi_graduation_project/core/database/tourApp_database.dart';
import 'package:depi_graduation_project/core/services/api_services/api_services1.1.dart';
import 'package:depi_graduation_project/core/utilities/assets.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/register_view.dart';
import 'package:depi_graduation_project/features/details/controllers/details_controller.dart';
import 'package:depi_graduation_project/features/details/presentation/view/details_view.dart';
import 'package:depi_graduation_project/features/details/presentation/view/schedule_bottom_sheet.dart';
import 'package:depi_graduation_project/features/favourite/controller/favourite_controller.dart';
import 'package:depi_graduation_project/features/favourite/presentation/views/favourites_view.dart';
import 'package:depi_graduation_project/features/home/controllers/home_controller.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:depi_graduation_project/features/main/controller/main_controller.dart';
import 'package:depi_graduation_project/features/main/main_view.dart';
import 'package:depi_graduation_project/features/profile/controllers/profile_controller.dart';
import 'package:depi_graduation_project/features/profile/presentation/views/profile_view.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:depi_graduation_project/features/schedule/presentation/view/schedule_view.dart';
import 'package:depi_graduation_project/features/search/presentation/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'core/services/supabase_services/auth_service.dart';
import 'core/utilities/routes.dart';
import 'features/search/search_controller/search_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await copyDatabase();

  database = await $FloortourDatabase.databaseBuilder('tourAppDB.db').build();
  await Supabase.initialize(
    url: 'https://xpirlaokxxrftthxoewh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwaXJsYW9reHhyZnR0aHhvZXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQwMTk2MTAsImV4cCI6MjA3OTU5NTYxMH0.rpqSSo8Swf5QEqbM6RfIvV5vtRbJOYUg5_MvCNHIheY',
  );
  runApp(const MyApp());
}

late tourDatabase database;

Future<void> copyDatabase() async {
  // 1) المسار اللي هتتخزن فيه القاعدة
  final dbDir = await getDatabasesPath();
  final dbPath = join(dbDir, 'tourAppDB.db');

  // 2) لو الملف موجود → خلاص
  if (File(dbPath).existsSync()) {
    print("Database already exists");
    return;
  }

  print("Copying database...");

  // 3) اقرأ ملف db من الـassets
  ByteData data = await rootBundle.load(Assets.databaseAsset);

  // 4) حوله لـ List<int>
  List<int> bytes = data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  );

  // 5) اكتب ملف جديد في المسار
  await File(dbPath).create(recursive: true);
  await File(dbPath).writeAsBytes(bytes, flush: true);

  print("Database copied!");
}

final cloud = Supabase.instance.client;

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
          // initialRoute: AuthService().isLogin() ? Routes.main : Routes.login,
          initialRoute: Routes.schedule,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => ApiServices());
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
              page: () => const DetailsView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => DetailsController());
              }),
            ),
            GetPage(
              name: Routes.profile,
              page: () => const ProfileView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => ProfileController());
              }),
            ),
            GetPage(
              name: Routes.main,
              page: () => const MainView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => MainController());
              }),
            ),
            GetPage(
              name: Routes.favourites,
              page: () => const FavouritesView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => FavouritesController());
              }),
            ),
            GetPage(
              name: Routes.search,
              page: () => const SearchView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => searchController());
              }),
            ),
            GetPage(
              name: Routes.schedule,
              page: () => const ScheduleView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => ScheduleController());
              }),
            ),
          ],
        );
      },
    );
  }
}
