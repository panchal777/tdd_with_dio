import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdd_with_dio/core/router/route_name.dart';
import 'package:tdd_with_dio/features/intro/presentation/pages/intro_page.dart';

class AppRouter {
  static String currentRoute = "/";

  static _bindRoute(dynamic settings, dynamic builderRoute) {
    return CupertinoPageRoute(
      settings: RouteSettings(name: settings.name),
      builder: (_) => builderRoute,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      case "/":
        return _bindRoute(settings, IntroPage());

      case RouteName.articlesPage:
        return _bindRoute(
          settings,
          SafeArea(child: Scaffold(body: Center(child: Text("data")))),
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
