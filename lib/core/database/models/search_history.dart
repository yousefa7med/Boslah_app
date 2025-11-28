import 'package:floor/floor.dart';

@Entity(tableName: 'search_history')
class SearchHistory {
  @PrimaryKey(autoGenerate: true)
  final int? seachId;

  final String query;
  final int timestamp;

  final String? user_id;

  SearchHistory({
    this.seachId,
    required this.query,
    required this.timestamp,
    this.user_id
  });
}
