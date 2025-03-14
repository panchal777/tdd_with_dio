import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_with_dio/core/network/dio_network.dart';
import 'package:tdd_with_dio/features/article/articles_injections.dart';

import '../../shared/data_sources/app_shared_prefs.dart';
import 'log/app_logger.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initDioInjections();
  await initArticlesInjections();
}

initSharedPrefsInjections() async {
  sl.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();

  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}

initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
