import 'package:floor/floor.dart';

@Entity(
  tableName: 'profile',
)
class Profile {
  @PrimaryKey(autoGenerate: false)
  final String userId;

  final String? username;
  final String? gmail;
  final String? image;

  Profile({
    required this.userId,
    this.username,
    this.gmail,
    this.image,
  });
}
