import 'package:depi_graduation_project/core/database/models/profile.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProfileDao{

  @Query('SELECT * FROM profile WHERE user_id = :id')
  Future<Profile?> selectProfileById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertUser(Profile user);

}