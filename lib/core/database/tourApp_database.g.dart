// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourApp_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $tourDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $tourDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $tourDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<tourDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloortourDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $tourDatabaseBuilderContract databaseBuilder(String name) =>
      _$tourDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $tourDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$tourDatabaseBuilder(null);
}

class _$tourDatabaseBuilder implements $tourDatabaseBuilderContract {
  _$tourDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $tourDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $tourDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<tourDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$tourDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$tourDatabase extends tourDatabase {
  _$tourDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RegionRequestDao? _regionrequestdaoInstance;

  RegionPlacesDao? _regionplacedaoInstance;

  FavoriteDao? _favoritedaoInstance;

  ScheduleDao? _scheduledaoInstance;

  SearchHistoryDao? _searchhistorydaoInstance;

  ProfileDao? _profiledaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `region_requests` (`region_id` INTEGER PRIMARY KEY AUTOINCREMENT, `lat` REAL NOT NULL, `lng` REAL NOT NULL, `timestamp` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `region_places` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `region_id` INTEGER NOT NULL, `search_id` INTEGER, `place_id` TEXT NOT NULL, `name` TEXT, `desc` TEXT, `category` TEXT, `image` TEXT, `lat` REAL, `lng` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorites` (`favId` INTEGER PRIMARY KEY AUTOINCREMENT, `addedAt` INTEGER, `userId` TEXT NOT NULL, `category` TEXT, `placeId` INTEGER NOT NULL, `name` TEXT NOT NULL, `desc` TEXT, `image` TEXT, `lat` REAL, `lng` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `schedules` (`scheduleId` INTEGER PRIMARY KEY AUTOINCREMENT, `placeId` INTEGER, `date` TEXT NOT NULL, `hour` TEXT NOT NULL, `note` TEXT NOT NULL, `name` TEXT, `isDone` INTEGER, `createdAt` INTEGER, `userId` TEXT, `lat` REAL, `lng` REAL, `image` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `search_history` (`seachId` INTEGER PRIMARY KEY AUTOINCREMENT, `query` TEXT NOT NULL, `timestamp` INTEGER NOT NULL, `userId` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `profile` (`userId` TEXT NOT NULL, `username` TEXT, `gmail` TEXT, `image` TEXT, PRIMARY KEY (`userId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RegionRequestDao get regionrequestdao {
    return _regionrequestdaoInstance ??=
        _$RegionRequestDao(database, changeListener);
  }

  @override
  RegionPlacesDao get regionplacedao {
    return _regionplacedaoInstance ??=
        _$RegionPlacesDao(database, changeListener);
  }

  @override
  FavoriteDao get favoritedao {
    return _favoritedaoInstance ??= _$FavoriteDao(database, changeListener);
  }

  @override
  ScheduleDao get scheduledao {
    return _scheduledaoInstance ??= _$ScheduleDao(database, changeListener);
  }

  @override
  SearchHistoryDao get searchhistorydao {
    return _searchhistorydaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }

  @override
  ProfileDao get profiledao {
    return _profiledaoInstance ??= _$ProfileDao(database, changeListener);
  }
}

class _$RegionRequestDao extends RegionRequestDao {
  _$RegionRequestDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _regionRequestInsertionAdapter = InsertionAdapter(
            database,
            'region_requests',
            (RegionRequest item) => <String, Object?>{
                  'region_id': item.region_id,
                  'lat': item.lat,
                  'lng': item.lng,
                  'timestamp': item.timestamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RegionRequest> _regionRequestInsertionAdapter;

  @override
  Future<RegionRequest?> selectLastRequest(String uid) async {
    return _queryAdapter.query(
        'SELECT * FROM region_requests WHERE user_id = ?1 ORDER BY timestamp DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => RegionRequest(region_id: row['region_id'] as int?, lat: row['lat'] as double, lng: row['lng'] as double, timestamp: row['timestamp'] as int?),
        arguments: [uid]);
  }

  @override
  Future<List<RegionRequest>> selectRequests() async {
    return _queryAdapter.queryList(
        'SELECT * FROM region_requests ORDER BY region_id DESC',
        mapper: (Map<String, Object?> row) => RegionRequest(
            region_id: row['region_id'] as int?,
            lat: row['lat'] as double,
            lng: row['lng'] as double,
            timestamp: row['timestamp'] as int?));
  }

  @override
  Future<int?> selectRegionId(
    double lat,
    double lng,
  ) async {
    return _queryAdapter.query(
        'Select region_id from region_requests where lat = ?1 and lng = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [lat, lng]);
  }

  @override
  Future<int> insertRegionRequest(RegionRequest rr) {
    return _regionRequestInsertionAdapter.insertAndReturnId(
        rr, OnConflictStrategy.replace);
  }
}

class _$RegionPlacesDao extends RegionPlacesDao {
  _$RegionPlacesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _regionPlaceInsertionAdapter = InsertionAdapter(
            database,
            'region_places',
            (RegionPlace item) => <String, Object?>{
                  'id': item.id,
                  'region_id': item.region_id,
                  'search_id': item.search_id,
                  'place_id': item.place_id,
                  'name': item.name,
                  'desc': item.desc,
                  'category': item.category,
                  'image': item.image,
                  'lat': item.lat,
                  'lng': item.lng
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RegionPlace> _regionPlaceInsertionAdapter;

  @override
  Future<List<RegionPlace>> selectRegionPlaces(int regionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM region_places WHERE region_id = ?1',
        mapper: (Map<String, Object?> row) => RegionPlace(
            id: row['id'] as int?,
            region_id: row['region_id'] as int,
            place_id: row['place_id'] as String,
            name: row['name'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            desc: row['desc'] as String?,
            category: row['category'] as String?,
            image: row['image'] as String?,
            search_id: row['search_id'] as int?),
        arguments: [regionId]);
  }

  @override
  Future<RegionPlace?> selectPlaceById(int placeId) async {
    return _queryAdapter.query(
        'SELECT * FROM region_places WHERE place_id = ?1',
        mapper: (Map<String, Object?> row) => RegionPlace(
            id: row['id'] as int?,
            region_id: row['region_id'] as int,
            place_id: row['place_id'] as String,
            name: row['name'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            desc: row['desc'] as String?,
            category: row['category'] as String?,
            image: row['image'] as String?,
            search_id: row['search_id'] as int?),
        arguments: [placeId]);
  }

  @override
  Future<void> deletePlacesByRegion(int regionId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM region_places WHERE region_id = ?1',
        arguments: [regionId]);
  }

  @override
  Future<int> insertPlace(RegionPlace place) {
    return _regionPlaceInsertionAdapter.insertAndReturnId(
        place, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRespPlaces(List<RegionPlace> rp) {
    return _regionPlaceInsertionAdapter.insertListAndReturnIds(
        rp, OnConflictStrategy.replace);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteInsertionAdapter = InsertionAdapter(
            database,
            'favorites',
            (Favorite item) => <String, Object?>{
                  'favId': item.favId,
                  'addedAt': item.addedAt,
                  'userId': item.userId,
                  'category': item.category,
                  'placeId': item.placeId,
                  'name': item.name,
                  'desc': item.desc,
                  'image': item.image,
                  'lat': item.lat,
                  'lng': item.lng
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favorite> _favoriteInsertionAdapter;

  @override
  Future<List<Favorite>> selectFavorites(String userId) async {
    return _queryAdapter.queryList('SELECT * FROM favorites WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Favorite(
            favId: row['favId'] as int?,
            addedAt: row['addedAt'] as int?,
            userId: row['userId'] as String,
            category: row['category'] as String?,
            placeId: row['placeId'] as int,
            name: row['name'] as String,
            desc: row['desc'] as String?,
            image: row['image'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?),
        arguments: [userId]);
  }

  @override
  Future<Favorite?> selectOneFavPlace(
    String uid,
    int placeId,
  ) async {
    return _queryAdapter.query(
        'select * from favorites WHERE userId = ?1 AND placeId = ?2',
        mapper: (Map<String, Object?> row) => Favorite(
            favId: row['favId'] as int?,
            addedAt: row['addedAt'] as int?,
            userId: row['userId'] as String,
            category: row['category'] as String?,
            placeId: row['placeId'] as int,
            name: row['name'] as String,
            desc: row['desc'] as String?,
            image: row['image'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?),
        arguments: [uid, placeId]);
  }

  @override
  Future<void> deleteFavorite(
    String uid,
    int placeId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM favorites WHERE userId = ?1 AND placeId = ?2',
        arguments: [uid, placeId]);
  }

  @override
  Future<void> deleteAllFavoritesByUser(String uid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM favorites WHERE userId = ?1',
        arguments: [uid]);
  }

  @override
  Future<int> insertFavorite(Favorite favPlace) {
    return _favoriteInsertionAdapter.insertAndReturnId(
        favPlace, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertManyFavorite(List<Favorite> favPlace) {
    return _favoriteInsertionAdapter.insertListAndReturnIds(
        favPlace, OnConflictStrategy.replace);
  }
}

class _$ScheduleDao extends ScheduleDao {
  _$ScheduleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _scheduleInsertionAdapter = InsertionAdapter(
            database,
            'schedules',
            (Schedule item) => <String, Object?>{
                  'scheduleId': item.scheduleId,
                  'placeId': item.placeId,
                  'date': item.date,
                  'hour': item.hour,
                  'note': item.note,
                  'name': item.name,
                  'isDone': item.isDone == null ? null : (item.isDone! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'userId': item.userId,
                  'lat': item.lat,
                  'lng': item.lng,
                  'image': item.image
                }),
        _scheduleDeletionAdapter = DeletionAdapter(
            database,
            'schedules',
            ['scheduleId'],
            (Schedule item) => <String, Object?>{
                  'scheduleId': item.scheduleId,
                  'placeId': item.placeId,
                  'date': item.date,
                  'hour': item.hour,
                  'note': item.note,
                  'name': item.name,
                  'isDone': item.isDone == null ? null : (item.isDone! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'userId': item.userId,
                  'lat': item.lat,
                  'lng': item.lng,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Schedule> _scheduleInsertionAdapter;

  final DeletionAdapter<Schedule> _scheduleDeletionAdapter;

  @override
  Future<List<Schedule>> selectSchedules(String uid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM schedules WHERE userId = ?1 ORDER BY date ASC, hour ASC',
        mapper: (Map<String, Object?> row) => Schedule(
            scheduleId: row['scheduleId'] as int?,
            placeId: row['placeId'] as int?,
            date: row['date'] as String,
            note: row['note'] as String,
            isDone: row['isDone'] == null ? null : (row['isDone'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            userId: row['userId'] as String?,
            name: row['name'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            image: row['image'] as String?,
            hour: row['hour'] as String),
        arguments: [uid]);
  }

  @override
  Future<Schedule?> selectScheduleById(int id) async {
    return _queryAdapter.query('SELECT * FROM schedules WHERE scheduleId = ?1',
        mapper: (Map<String, Object?> row) => Schedule(
            scheduleId: row['scheduleId'] as int?,
            placeId: row['placeId'] as int?,
            date: row['date'] as String,
            note: row['note'] as String,
            isDone: row['isDone'] == null ? null : (row['isDone'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            userId: row['userId'] as String?,
            name: row['name'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            image: row['image'] as String?,
            hour: row['hour'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Schedule?>> selectAllScheduleById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM schedules WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Schedule(
            scheduleId: row['scheduleId'] as int?,
            placeId: row['placeId'] as int?,
            date: row['date'] as String,
            note: row['note'] as String,
            isDone: row['isDone'] == null ? null : (row['isDone'] as int) != 0,
            createdAt: row['createdAt'] as int?,
            userId: row['userId'] as String?,
            name: row['name'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            image: row['image'] as String?,
            hour: row['hour'] as String),
        arguments: [id]);
  }

  @override
  Future<void> markAsDone(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE schedules SET isDone = 1 WHERE scheduleId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAllSchedules(String uid) async {
    await _queryAdapter.queryNoReturn('DELETE FROM schedules WHERE userId = ?1',
        arguments: [uid]);
  }

  @override
  Future<int> insertSchedule(Schedule schedule) {
    return _scheduleInsertionAdapter.insertAndReturnId(
        schedule, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteSchedule(Schedule schedule) {
    return _scheduleDeletionAdapter.deleteAndReturnChangedRows(schedule);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _searchHistoryInsertionAdapter = InsertionAdapter(
            database,
            'search_history',
            (SearchHistory item) => <String, Object?>{
                  'seachId': item.seachId,
                  'query': item.query,
                  'timestamp': item.timestamp,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchHistory> _searchHistoryInsertionAdapter;

  @override
  Future<List<SearchHistory>> selectHistory(String uid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM search_history WHERE userId = ?1 ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => SearchHistory(seachId: row['seachId'] as int?, query: row['query'] as String, timestamp: row['timestamp'] as int, userId: row['userId'] as String?),
        arguments: [uid]);
  }

  @override
  Future<void> clearHistory(String uid) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM search_history WHERE userId = ?1',
        arguments: [uid]);
  }

  @override
  Future<void> clearAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM search_history');
  }

  @override
  Future<int> insertHistory(SearchHistory history) {
    return _searchHistoryInsertionAdapter.insertAndReturnId(
        history, OnConflictStrategy.replace);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileInsertionAdapter = InsertionAdapter(
            database,
            'profile',
            (Profile item) => <String, Object?>{
                  'userId': item.userId,
                  'username': item.username,
                  'gmail': item.gmail,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Profile> _profileInsertionAdapter;

  @override
  Future<Profile?> selectProfileById(String id) async {
    return _queryAdapter.query('SELECT * FROM profile WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Profile(
            userId: row['userId'] as String,
            username: row['username'] as String?,
            gmail: row['gmail'] as String?,
            image: row['image'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertUser(Profile user) {
    return _profileInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.replace);
  }
}
