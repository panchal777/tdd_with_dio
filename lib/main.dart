import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tdd_with_dio/core/helper/helper.dart';
import 'package:tdd_with_dio/core/router/app_router.dart';
import 'package:tdd_with_dio/injectors/main_injector.dart';

import 'core/styles/app_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inject all dependencies
  await MainInjector.init();
  runApp(DevicePreview(builder: (context) => const MyApp(), enabled: false));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Ny Times Articles App',
                debugShowCheckedModeBanner: false,
                builder: DevicePreview.appBuilder,
                navigatorKey: navigatorKey,
                theme: Helper.isDarkTheme() ? darkAppTheme : appTheme,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

class AppNotifier extends ChangeNotifier {
  late bool darkTheme;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = Helper.isDarkTheme();
    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    notifyListeners();
  }
}
