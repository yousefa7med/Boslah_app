import 'package:depi_graduation_project/core/database/models/profile.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProfileDao {
  @Query('SELECT * FROM profile WHERE userId = :id')
  Future<Profile?> selectProfileById(String id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertUser(Profile user);
}
