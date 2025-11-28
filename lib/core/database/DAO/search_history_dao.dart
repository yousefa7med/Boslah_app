
import 'package:floor/floor.dart';

import '../models/search_history.dart';

@dao
abstract class SearchHistoryDao{
  @Query('SELECT * FROM search_history WHERE user_id = :uid ORDER BY timestamp DESC')
  Future<List<SearchHistory>> selectHistory(String uid);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertHistory(SearchHistory history);

  @Query('DELETE FROM search_history WHERE user_id = :uid')
  Future<void> clearHistory(String uid);

  @Query('DELETE FROM search_history')
  Future<void> clearAll();

}