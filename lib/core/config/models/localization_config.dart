import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_config.freezed.dart';
part 'localization_config.g.dart';

/// Localization configuration
@freezed
class LocalizationConfig with _$LocalizationConfig {
  const factory LocalizationConfig({
    /// Default locale code (e.g., 'en', 'id')
    required String defaultLocale,
    
    /// Supported locales
    required List<String> supportedLocales,
    
    /// Fallback locale when translation is missing
    @Default('en') String fallbackLocale,
    
    /// Show language switcher in UI
    @Default(true) bool showLanguageSwitcher,
    
    /// Locale-specific content availability
    Map<String, LocaleContentConfig>? localeContent,
  }) = _LocalizationConfig;

  factory LocalizationConfig.fromJson(Map<String, dynamic> json) =>
      _$LocalizationConfigFromJson(json);
}

@freezed
class LocaleContentConfig with _$LocaleContentConfig {
  const factory LocaleContentConfig({
    /// Content availability percentage (0.0 to 1.0)
    @Default(1.0) double availability,
    
    /// Content version for this locale
    String? version,
    
    /// Last updated timestamp
    String? lastUpdated,
  }) = _LocaleContentConfig;

  factory LocaleContentConfig.fromJson(Map<String, dynamic> json) =>
      _$LocaleContentConfigFromJson(json);
}
