import 'package:floor/floor.dart';

class CategoriesConverter extends TypeConverter<List<String>, String> {
    static final CategoriesConverter _instance = CategoriesConverter._internal();
  factory CategoriesConverter() => _instance;
  CategoriesConverter._internal();

  @override
  List<String> decode(String? databaseValue) {
    if (databaseValue == null || databaseValue.isEmpty) return [];
    return databaseValue.split(',');
  }

  @override
  String encode(List<String> value) {
    return value.join(',');
  }
}


