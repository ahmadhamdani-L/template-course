import 'package:flutter/material.dart';
import '../config/models/branding_config.dart';

/// Dynamic theme builder based on branding configuration
class AppTheme {
  static ThemeData buildLightTheme(BrandingConfig branding) {
    final colorScheme = _buildColorScheme(branding, Brightness.light);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: branding.typography.fontFamily,
      
      // App Bar
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      
      // Card
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.lg),
        ),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.sm),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: branding.spacing.sm,
          vertical: branding.spacing.xs,
        ),
      ),
      
      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        elevation: 0,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
        ),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        space: branding.spacing.md,
        thickness: 1,
      ),
    );
  }

  static ThemeData buildDarkTheme(BrandingConfig branding) {
    final colorScheme = _buildColorScheme(branding, Brightness.dark);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: branding.typography.fontFamily,
      
      // App Bar
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      
      // Card
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1,
          ),
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: branding.spacing.lg,
            vertical: branding.spacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(branding.borderRadius.md),
          ),
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.lg),
        ),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.sm),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: branding.spacing.sm,
          vertical: branding.spacing.xs,
        ),
      ),
      
      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        elevation: 0,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(branding.borderRadius.md),
        ),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        space: branding.spacing.md,
        thickness: 1,
      ),
    );
  }

  static ColorScheme _buildColorScheme(
    BrandingConfig branding,
    Brightness brightness,
  ) {
    final primary = ColorSchemeConfig.hexToColor(branding.colors.primary);
    final secondary = ColorSchemeConfig.hexToColor(branding.colors.secondary);
    
    if (brightness == Brightness.light) {
      return ColorScheme.fromSeed(
        seedColor: primary,
        secondary: secondary,
        brightness: Brightness.light,
        error: branding.colors.error != null
            ? ColorSchemeConfig.hexToColor(branding.colors.error!)
            : null,
      );
    } else {
      return ColorScheme.fromSeed(
        seedColor: primary,
        secondary: secondary,
        brightness: Brightness.dark,
        error: branding.colors.error != null
            ? ColorSchemeConfig.hexToColor(branding.colors.error!)
            : null,
      );
    }
  }
}
