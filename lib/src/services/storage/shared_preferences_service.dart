import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class SharedPreferencesService implements KeyValueStorageService {
  late Future<SharedPreferences> _preferences;

  SharedPreferencesService() {
    _preferences = _openDB();
  }

  Future<SharedPreferences> _openDB() async {
    return SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final db = await _preferences;
    switch (T) {
      case int:
        return db.getInt(key) as T?;
      case String:
        return db.getString(key) as T?;
      case bool:
        return db.getBool(key) as T?;
      default:
        throw UnimplementedError('Unimplemented type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final db = await _preferences;
    return await db.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final db = await _preferences;
    switch (T) {
      case int:
        await db.setInt(key, value as int);
      case String:
        await db.setString(key, value as String);
      case bool:
        await db.setBool(key, value as bool);
      default:
        throw UnimplementedError('Unimplemented type ${T.runtimeType}');
    }
  }
}
