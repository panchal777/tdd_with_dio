// enum AppRouteEnum {
//   articlesPage,
//   articleDetailsPage,
//   weViewPage,
//   photoViewPage,
// }
//
// extension AppRouteExtension on AppRouteEnum {
//   String get name {
//     switch (this) {
//       case AppRouteEnum.articlesPage:
//         return "/articles_page";
//
//       default:
//         return "/articles_page";
//     }
//   }
// }

class RouteName {
  static const articlesPage = '/articles_page';
  static const articlesDetailsPage = '/articles_details_page';
  static const webViewPage = '/web_view_page';
  static const photoViewPage = '/photo_view_page';
}
