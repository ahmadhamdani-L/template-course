import 'package:freezed_annotation/freezed_annotation.dart';

part 'monetization_config.freezed.dart';
part 'monetization_config.g.dart';

/// Monetization configuration
@freezed
class MonetizationConfig with _$MonetizationConfig {
  const factory MonetizationConfig({
    /// AdMob configuration
    AdMobConfig? admob,
    
    /// Premium features configuration
    PremiumConfig? premium,
  }) = _MonetizationConfig;

  factory MonetizationConfig.fromJson(Map<String, dynamic> json) =>
      _$MonetizationConfigFromJson(json);
}

@freezed
class AdMobConfig with _$AdMobConfig {
  const factory AdMobConfig({
    /// AdMob app ID (Android)
    required String androidAppId,
    
    /// Banner ad unit IDs
    AdUnitIds? bannerAds,
    
    /// Interstitial ad unit IDs
    AdUnitIds? interstitialAds,
    
    /// Rewarded ad unit IDs
    AdUnitIds? rewardedAds,
    
    /// Ad placements configuration
    List<AdPlacement>? placements,
    
    /// Test device IDs
    List<String>? testDeviceIds,
  }) = _AdMobConfig;

  factory AdMobConfig.fromJson(Map<String, dynamic> json) =>
      _$AdMobConfigFromJson(json);
}

@freezed
class AdUnitIds with _$AdUnitIds {
  const factory AdUnitIds({
    /// Production ad unit ID
    required String production,
    
    /// Development/test ad unit ID
    required String development,
  }) = _AdUnitIds;

  factory AdUnitIds.fromJson(Map<String, dynamic> json) =>
      _$AdUnitIdsFromJson(json);
}

@freezed
class AdPlacement with _$AdPlacement {
  const factory AdPlacement({
    /// Placement identifier
    required String id,
    
    /// Ad type
    required AdType type,
    
    /// Placement location
    required String location,
    
    /// Frequency cap (minutes between shows)
    int? frequencyCap,
    
    /// Enabled state
    @Default(true) bool enabled,
  }) = _AdPlacement;

  factory AdPlacement.fromJson(Map<String, dynamic> json) =>
      _$AdPlacementFromJson(json);
}

enum AdType {
  @JsonValue('banner')
  banner,
  
  @JsonValue('interstitial')
  interstitial,
  
  @JsonValue('rewarded')
  rewarded,
}

@freezed
class PremiumConfig with _$PremiumConfig {
  const factory PremiumConfig({
    /// Premium features list
    required List<String> features,
    
    /// In-app purchase product IDs
    required List<String> productIds,
    
    /// Subscription product IDs
    List<String>? subscriptionIds,
    
    /// Trial period enabled
    @Default(false) bool trialEnabled,
    
    /// Trial duration in days
    int? trialDays,
  }) = _PremiumConfig;

  factory PremiumConfig.fromJson(Map<String, dynamic> json) =>
      _$PremiumConfigFromJson(json);
}
