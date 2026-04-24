import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  PreferenceManager._internal();

  static final PreferenceManager instance = PreferenceManager._internal();

  late SharedPreferences prefs;
  bool initialized = false;

  
  Future<void> init() async {
    if (initialized) return;
    prefs = await SharedPreferences.getInstance();
    initialized = true;
  }


  void _ensureInitialized() {
    if (!initialized) {
      throw StateError('PreferenceManager not initialized. Call init() first.');
    }
  }


  Future<bool> setString(String key, String value) async {
    _ensureInitialized();
    return prefs.setString(key, value);
  }

  String? getString(String key) {
    _ensureInitialized();
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    _ensureInitialized();
    return prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    _ensureInitialized();
    return prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    _ensureInitialized();
    return prefs.setInt(key, value);
  }

  int? getInt(String key) {
    _ensureInitialized();
    return prefs.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    _ensureInitialized();
    return prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    _ensureInitialized();
    return prefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    _ensureInitialized();
    return prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    _ensureInitialized();
    return prefs.getStringList(key);
  }

  Future<bool> remove(String key) async {
    _ensureInitialized();
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    _ensureInitialized();
    return prefs.clear();
  }

}
