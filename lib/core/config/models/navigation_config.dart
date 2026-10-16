import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_config.freezed.dart';
part 'navigation_config.g.dart';

/// Navigation structure and layout configuration
@freezed
class NavigationConfig with _$NavigationConfig {
  const factory NavigationConfig({
    /// Navigation type
    required NavigationType type,
    
    /// Top-level destinations
    required List<NavDestination> destinations,
    
    /// Home dashboard configuration
    required DashboardConfig dashboard,
    
    /// Initial route
    @Default('/') String initialRoute,
    
    /// Enable onboarding flow
    @Default(false) bool enableOnboarding,
  }) = _NavigationConfig;

  factory NavigationConfig.fromJson(Map<String, dynamic> json) =>
      _$NavigationConfigFromJson(json);
}

enum NavigationType {
  @JsonValue('bottom_nav')
  bottomNav,
  
  @JsonValue('drawer')
  drawer,
  
  @JsonValue('rail')
  rail,
}

@freezed
class NavDestination with _$NavDestination {
  const factory NavDestination({
    /// Destination identifier
    required String id,
    
    /// Display label key (for localization)
    required String labelKey,
    
    /// Icon identifier
    required String icon,
    
    /// Route path
    required String route,
    
    /// Required features
    List<String>? requiredFeatures,
    
    /// Enabled state
    @Default(true) bool enabled,
    
    /// Badge configuration
    NavBadge? badge,
  }) = _NavDestination;

  factory NavDestination.fromJson(Map<String, dynamic> json) =>
      _$NavDestinationFromJson(json);
}

@freezed
class NavBadge with _$NavBadge {
  const factory NavBadge({
    /// Badge type
    required BadgeType type,
    
    /// Static value (for 'count' type)
    int? value,
    
    /// Dynamic source key (for runtime values)
    String? sourceKey,
  }) = _NavBadge;

  factory NavBadge.fromJson(Map<String, dynamic> json) =>
      _$NavBadgeFromJson(json);
}

enum BadgeType {
  @JsonValue('dot')
  dot,
  
  @JsonValue('count')
  count,
}

@freezed
class DashboardConfig with _$DashboardConfig {
  const factory DashboardConfig({
    /// Dashboard sections
    required List<DashboardSection> sections,
    
    /// Enable search
    @Default(true) bool enableSearch,
    
    /// Welcome header enabled
    @Default(true) bool showWelcomeHeader,
  }) = _DashboardConfig;

  factory DashboardConfig.fromJson(Map<String, dynamic> json) =>
      _$DashboardConfigFromJson(json);
}

@freezed
class DashboardSection with _$DashboardSection {
  const factory DashboardSection({
    /// Section identifier
    required String id,
    
    /// Section type
    required DashboardSectionType type,
    
    /// Title key for localization
    required String titleKey,
    
    /// Subtitle key (optional)
    String? subtitleKey,
    
    /// Maximum items to display
    @Default(5) int maxItems,
    
    /// Display style
    @Default(DisplayStyle.list) DisplayStyle displayStyle,
    
    /// Navigation destination on tap
    String? navigationRoute,
    
    /// Required features
    List<String>? requiredFeatures,
    
    /// Enabled state
    @Default(true) bool enabled,
    
    /// Section order
    required int order,
  }) = _DashboardSection;

  factory DashboardSection.fromJson(Map<String, dynamic> json) =>
      _$DashboardSectionFromJson(json);
}

enum DashboardSectionType {
  @JsonValue('continue_learning')
  continueLearning,
  
  @JsonValue('recommended_courses')
  recommendedCourses,
  
  @JsonValue('learning_streak')
  learningStreak,
  
  @JsonValue('weekly_progress')
  weeklyProgress,
  
  @JsonValue('daily_challenge')
  dailyChallenge,
  
  @JsonValue('recent_lessons')
  recentLessons,
  
  @JsonValue('bookmarks')
  bookmarks,
  
  @JsonValue('new_content')
  newContent,
  
  @JsonValue('featured_paths')
  featuredPaths,
  
  @JsonValue('achievements')
  achievements,
}

enum DisplayStyle {
  @JsonValue('list')
  list,
  
  @JsonValue('grid')
  grid,
  
  @JsonValue('carousel')
  carousel,
  
  @JsonValue('card')
  card,
}
