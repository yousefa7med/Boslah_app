import 'package:floor/floor.dart';

@Entity(
  tableName: 'profile',
)
class Profile {
  @PrimaryKey(autoGenerate: true)
  final int? user_id;

  final String? username;
  final String? gmail;
  final String? image;

  Profile({
    this.user_id,
    this.username,
    this.gmail,
    this.image,
  });
}
