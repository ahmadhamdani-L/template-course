import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/models/branding_config.dart';
import '../../app/bootstrap.dart';
import 'app_theme.dart';

/// Theme mode provider with persistence
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _key = 'theme_mode';
  
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_key);
    
    if (savedMode != null) {
      state = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.toString());
  }
}

/// Light theme provider
final lightThemeProvider = Provider<ThemeData>((ref) {
  final config = ref.watch(appConfigProvider);
  return AppTheme.buildLightTheme(config.branding);
});

/// Dark theme provider
final darkThemeProvider = Provider<ThemeData>((ref) {
  final config = ref.watch(appConfigProvider);
  return AppTheme.buildDarkTheme(config.branding);
});
