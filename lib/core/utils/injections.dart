import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/data_sources/app_shared_prefs.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
}

initSharedPrefsInjections() async {
  sl.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();

  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}
