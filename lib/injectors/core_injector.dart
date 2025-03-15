import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_with_dio/core/network/dio_network.dart';
import '../../shared/data_sources/app_shared_prefs.dart';
import '../core/utils/log/app_logger.dart';
import 'main_injector.dart';

class CoreInjector {
  static init() async {
    await initSharedPrefsInjections();
    await initDioInjections();
  }

  static Future<void> initSharedPrefsInjections() async {
    final injector = MainInjector.instance;
    injector.registerLazySingletonAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    // Ensure SharedPreferences is ready before proceeding
    await injector.isReady<SharedPreferences>();
    injector.registerLazySingleton<AppSharedPrefs>(
      () => AppSharedPrefs(injector()), // Ensure it's registered correctly
    );
  }

  static initDioInjections() async {
    initRootLogger();
    DioNetwork.initDio();
  }
}
