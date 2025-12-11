import 'dart:async';

import 'package:depi_graduation_project/core/database/DAO/Schedule_dao.dart';
import 'package:depi_graduation_project/core/database/DAO/favorites_dao.dart';
import 'package:depi_graduation_project/core/database/DAO/profile_dao.dart';
import 'package:depi_graduation_project/core/database/DAO/region_places_dao.dart';
import 'package:depi_graduation_project/core/database/DAO/region_requests_dao.dart';
import 'package:depi_graduation_project/core/database/DAO/search_history_dao.dart';
import 'package:depi_graduation_project/core/database/converter/categories_converter.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'models/favorites.dart';
import 'models/profile.dart';
import 'models/region_places.dart';
import 'models/region_requests.dart';
import 'models/schedules.dart';
import 'models/search_history.dart';

part 'tourApp_database.g.dart';

@TypeConverters([CategoriesConverter])
@Database(
  version: 1,
  entities: [
    RegionRequest,
    RegionPlace,
    Favorite,
    Schedule,
    SearchHistory,
    Profile,
  ],
)
abstract class tourDatabase extends FloorDatabase {
  RegionRequestDao get regionrequestdao;
  RegionPlacesDao get regionplacedao;
  FavoriteDao get favoritedao;
  ScheduleDao get scheduledao;
  SearchHistoryDao get searchhistorydao;
  ProfileDao get profiledao;
}
