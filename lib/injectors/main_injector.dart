import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:tdd_with_dio/injectors/core_injector.dart';
import 'package:tdd_with_dio/injectors/feature_injector.dart';

class MainInjector {
  MainInjector._();

  static GetIt instance = GetIt.instance;

  static init() async {
    await CoreInjector.init();
    await FeatureInjector.init();
    await MainInjector.instance.allReady();
    debugPrint(
      'injectors ---> ${MainInjector.instance.allReadySync()}',
    ); // Lists all registered dependencies
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
