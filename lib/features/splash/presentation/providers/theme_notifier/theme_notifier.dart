import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<ThemeMode> build() async {
    final themeMode = await getThemeConfig();
    return themeMode;
  }

  Future<ThemeMode> getThemeConfig() async {
    final sp = await SharedPreferences.getInstance();
    final themeChoice = sp.getInt("theme");
    return switch (themeChoice) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void setTheme(ThemeMode theme) async {
    state = AsyncData(theme);
    final sp = await SharedPreferences.getInstance();
    switch (theme) {
      case ThemeMode.light:
        sp.setInt("theme", 1);
        break;
      case ThemeMode.dark:
        sp.setInt("theme", 2);
        break;
      default:
        sp.remove("theme");
    }
  }
}
