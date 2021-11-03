import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

enum Routes { login }

extension RoutesExt on Routes {
  String get value => toString().split(".")[1];
}

class AppRouter {
  AppRouter._();

  static AppRouter get instance => AppRouter._();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget screen = const SizedBox();

    if (settings.name != null) {
      switch (EnumToString.fromString(Routes.values, settings.name!)) {
        case Routes.login:
          // TODO: Handle this case.
          break;
        default:
      }
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  }
}
