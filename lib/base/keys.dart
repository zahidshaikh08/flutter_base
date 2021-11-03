import 'package:flutter/material.dart';

import 'globals.dart';

/// USED ONLY FOR STORING KEYS
class Keys {
  static const authToken = "AUTH_TOKEN";
  static const deviceType = "DEVICE_TYPE";
  static const deviceOS = "DEVICE_OS";
  static const theme = "THEME";

  /// key to get secure storage file
  static const privateKey = 'private-key';
}

/// USED FOR RETRIEVING AND SETTING VALUES
class Prefs {
  static const light = "light";
  static const dark = "dark";

  static ThemeMode getThemeMode() {
    final currentTheme = sharedPref.getString(Keys.theme) ?? light;
    return currentTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
  }
}
