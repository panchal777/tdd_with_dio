import 'package:tdd_with_dio/core/utils/injections.dart';
import 'package:tdd_with_dio/shared/data_sources/app_shared_prefs.dart';

class Helper {
  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}
