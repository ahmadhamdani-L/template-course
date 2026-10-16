import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'branding_config.freezed.dart';
part 'branding_config.g.dart';

/// Branding and visual identity configuration
@freezed
class BrandingConfig with _$BrandingConfig {
  const factory BrandingConfig({
    /// Design preset identifier
    required String preset,
    
    /// Color scheme
    required ColorSchemeConfig colors,
    
    /// Typography configuration
    required TypographyConfig typography,
    
    /// Spacing scale
    @Default(SpacingConfig()) SpacingConfig spacing,
    
    /// Border radius values
    @Default(BorderRadiusConfig()) BorderRadiusConfig borderRadius,
    
    /// Asset paths
    required AssetConfig assets,
    
    /// Custom overrides
    Map<String, dynamic>? customOverrides,
  }) = _BrandingConfig;

  factory BrandingConfig.fromJson(Map<String, dynamic> json) =>
      _$BrandingConfigFromJson(json);
}

@freezed
class ColorSchemeConfig with _$ColorSchemeConfig {
  const factory ColorSchemeConfig({
    /// Primary brand color (hex)
    required String primary,
    
    /// Secondary color (hex)
    required String secondary,
    
    /// Accent/tertiary color (hex)
    String? accent,
    
    /// Error color (hex)
    String? error,
    
    /// Warning color (hex)
    String? warning,
    
    /// Success color (hex)
    String? success,
    
    /// Info color (hex)
    String? info,
    
    /// Background color for light theme (hex)
    String? backgroundLight,
    
    /// Surface color for light theme (hex)
    String? surfaceLight,
    
    /// Background color for dark theme (hex)
    String? backgroundDark,
    
    /// Surface color for dark theme (hex)
    String? surfaceDark,
  }) = _ColorSchemeConfig;

  factory ColorSchemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ColorSchemeConfigFromJson(json);
  
  /// Convert hex string to Color
  static Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

@freezed
class TypographyConfig with _$TypographyConfig {
  const factory TypographyConfig({
    /// Font family name
    @Default('Inter') String fontFamily,
    
    /// Code font family
    @Default('monospace') String codeFontFamily,
    
    /// Base font size multiplier
    @Default(1.0) double fontSizeScale,
    
    /// Line height multiplier
    @Default(1.5) double lineHeightScale,
  }) = _TypographyConfig;

  factory TypographyConfig.fromJson(Map<String, dynamic> json) =>
      _$TypographyConfigFromJson(json);
}

@freezed
class SpacingConfig with _$SpacingConfig {
  const factory SpacingConfig({
    @Default(4.0) double xs,
    @Default(8.0) double sm,
    @Default(16.0) double md,
    @Default(24.0) double lg,
    @Default(32.0) double xl,
    @Default(48.0) double xxl,
  }) = _SpacingConfig;

  factory SpacingConfig.fromJson(Map<String, dynamic> json) =>
      _$SpacingConfigFromJson(json);
}

@freezed
class BorderRadiusConfig with _$BorderRadiusConfig {
  const factory BorderRadiusConfig({
    @Default(4.0) double sm,
    @Default(8.0) double md,
    @Default(12.0) double lg,
    @Default(16.0) double xl,
    @Default(24.0) double xxl,
  }) = _BorderRadiusConfig;

  factory BorderRadiusConfig.fromJson(Map<String, dynamic> json) =>
      _$BorderRadiusConfigFromJson(json);
}

@freezed
class AssetConfig with _$AssetConfig {
  const factory AssetConfig({
    /// Logo path
    required String logo,
    
    /// Logo for dark theme
    String? logoDark,
    
    /// Icon path
    String? icon,
    
    /// Splash screen background
    String? splashBackground,
    
    /// Empty state illustrations directory
    String? illustrationsPath,
  }) = _AssetConfig;

  factory AssetConfig.fromJson(Map<String, dynamic> json) =>
      _$AssetConfigFromJson(json);
}
