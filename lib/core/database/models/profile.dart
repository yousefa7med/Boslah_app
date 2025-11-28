import 'package:floor/floor.dart';

@Entity(
  tableName: 'profile',
)
class Profile {
  @PrimaryKey(autoGenerate: false)
  final String user_id;

  final String? username;
  final String? gmail;
  final String? image;

  Profile({
    required this.user_id,
    this.username,
    this.gmail,
    this.image,
  });
}
