import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String theme = 'styles';
}

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  setBool(String prefKey, bool value) {
    _preferences.setBool(prefKey, value);
  }

  getBool(String prefKey) {
    return _preferences.getBool(prefKey) ?? false;
  }

  ///------------Dark Theme-----------///
  void setDarkTheme(bool isDark) {
    setBool(PrefKeys.theme, isDark);
  }

  bool getIsDarkTheme() {
    return getBool(PrefKeys.theme);
  }
}
