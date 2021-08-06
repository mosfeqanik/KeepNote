import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static const String IS_LOGGED_IN = 'is-logged-in';
  static SharedPreferences _prefs;

  static Future<SharedPreferences> loadPref() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static void setString(String key, String value) {
    _prefs.setString(key, value);
  }

  static String getString(String key, {String def}) {
    String val;
    val = _prefs.getString(key);
    if (val == null) {
      val = def;
    }
    return val;
  }

  static void setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool def}) {
    bool val;
    val = _prefs.getBool(key);
    if (val == null) {
      val = def;
    }
    return val;
  }

  static void clearPref() {
    _prefs.clear();
  }

}