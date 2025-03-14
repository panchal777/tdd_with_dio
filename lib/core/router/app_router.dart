import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdd_with_dio/core/router/route_name.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';
import 'package:tdd_with_dio/features/intro/presentation/pages/intro_page.dart';

import '../../features/article/presentation/pages/article_details_page.dart';
import '../../features/article/presentation/pages/articles_page.dart';
import '../../shared/presentation/pages/photo_view_page.dart';
import '../../shared/presentation/pages/web_view_page.dart';

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
        return _bindRoute(settings, ArticlesPage());

      case RouteName.articlesDetailsPage:
        return _bindRoute(
          settings,
          ArticleDetailsPage(model: settings.arguments as ArticleModel),
        );

      case RouteName.webViewPage:
        return _bindRoute(
          settings,
          WebViewPage(link: settings.arguments as String),
        );

      case RouteName.photoViewPage:
        Map<String, dynamic>? args =
            settings.arguments as Map<String, dynamic>?;
        return _bindRoute(
          settings,
          PhotoViewPage(path: args!['path'], fromNet: args['fromNet']),
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
