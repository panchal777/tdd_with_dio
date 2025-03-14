import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdd_with_dio/core/utils/injections.dart';
import 'package:tdd_with_dio/shared/data_sources/app_shared_prefs.dart';

import '../../shared/domain/entities/language_enum.dart';

class Helper {
  /// Get language
  static LanguageEnum getLang() {
    // LanguageEnum? lang;
    // lang = sl<AppSharedPrefs>().getLang();
    // lang = lang ?? LanguageEnum.en;
    return LanguageEnum.en;
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }
}
