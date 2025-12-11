import 'package:Boslah/core/helper/casheHelper.dart';
import 'package:flutter/material.dart';

import 'cashe_keys.dart';

class ThemeManager {
  ThemeManager._internal();
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeModeState currentTheme = ThemeModeState.system;

  ThemeMode getTheme() {
    switch (currentTheme) {
      case ThemeModeState.light:
        return ThemeMode.light;
      case ThemeModeState.dark:
        return ThemeMode.dark;

      default:
        return ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeModeState theme) async {
    currentTheme = theme;
    await CasheHelper().saveData(key: CasheKeys.theme, value: theme.name);
  }

  void loadTheme() {
    String savedTheme =
        CasheHelper().getData(CasheKeys.theme) as String? ?? "system";

    currentTheme = ThemeModeState.values.firstWhere(
      (e) => e.name == savedTheme,
      orElse: () => ThemeModeState.system,
    );
  }
}

enum ThemeModeState { light, dark, system }
