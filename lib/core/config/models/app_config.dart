import 'package:freezed_annotation/freezed_annotation.dart';
import 'branding_config.dart';
import 'navigation_config.dart';
import 'feature_config.dart';
import 'localization_config.dart';
import 'monetization_config.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

/// Root configuration for an application instance
/// This is Layer B: Application Profile in the configuration hierarchy
@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    /// Schema version for migration support
    required String schemaVersion,
    
    /// Internal application key (stable identifier)
    required String appKey,
    
    /// Application identity
    required AppIdentity identity,
    
    /// Branding and visual identity
    required BrandingConfig branding,
    
    /// Navigation structure and layout
    required NavigationConfig navigation,
    
    /// Feature flags and capabilities
    required FeatureConfig features,
    
    /// Localization settings
    required LocalizationConfig localization,
    
    /// Monetization configuration
    MonetizationConfig? monetization,
    
    /// Content sources
    required ContentConfig content,
    
    /// Additional metadata
    Map<String, dynamic>? metadata,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}

@freezed
class AppIdentity with _$AppIdentity {
  const factory AppIdentity({
    /// Display name shown in UI
    required String displayName,
    
    /// Short name for limited space
    required String shortName,
    
    /// Subtitle or tagline
    String? subtitle,
    
    /// Full description
    required String description,
    
    /// Publisher information
    required PublisherInfo publisher,
    
    /// Application version
    required String version,
    
    /// Build number
    required int buildNumber,
  }) = _AppIdentity;

  factory AppIdentity.fromJson(Map<String, dynamic> json) =>
      _$AppIdentityFromJson(json);
}

@freezed
class PublisherInfo with _$PublisherInfo {
  const factory PublisherInfo({
    required String name,
    String? website,
    String? supportEmail,
    String? privacyPolicyUrl,
    String? termsOfServiceUrl,
  }) = _PublisherInfo;

  factory PublisherInfo.fromJson(Map<String, dynamic> json) =>
      _$PublisherInfoFromJson(json);
}

@freezed
class ContentConfig with _$ContentConfig {
  const factory ContentConfig({
    /// Bundled content enabled
    @Default(true) bool bundledEnabled,
    
    /// Remote content enabled
    @Default(false) bool remoteEnabled,
    
    /// Remote content base URL
    String? remoteBaseUrl,
    
    /// Remote configuration endpoint
    String? remoteConfigUrl,
    
    /// Content version for cache invalidation
    String? contentVersion,
    
    /// Update check interval in hours
    @Default(24) int updateCheckIntervalHours,
  }) = _ContentConfig;

  factory ContentConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentConfigFromJson(json);
}
