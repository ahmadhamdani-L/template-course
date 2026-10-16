import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_config.freezed.dart';
part 'feature_config.g.dart';

/// Feature flags and capabilities configuration
@freezed
class FeatureConfig with _$FeatureConfig {
  const factory FeatureConfig({
    // Core Learning Features
    @Default(true) bool courseCatalog,
    @Default(true) bool lessonReader,
    @Default(true) bool quizEngine,
    @Default(true) bool progressTracking,
    
    // Content Organization
    @Default(true) bool learningPaths,
    @Default(true) bool bookmarks,
    @Default(false) bool notes,
    @Default(true) bool search,
    
    // Assessment & Practice
    @Default(true) bool assessments,
    @Default(false) bool flashcards,
    @Default(false) bool spacedRepetition,
    @Default(false) bool interactiveExercises,
    @Default(false) bool codePlayground,
    
    // Progress & Motivation
    @Default(true) bool learningHistory,
    @Default(false) bool achievements,
    @Default(false) bool learningStreaks,
    @Default(false) bool dailyChallenges,
    @Default(false) bool certificates,
    
    // Offline & Sync
    @Default(true) bool offlineMode,
    @Default(false) bool downloads,
    @Default(false) bool cloudSync,
    
    // User & Social
    @Default(false) bool userAccounts,
    @Default(false) bool socialSharing,
    
    // Content & Discovery
    @Default(true) bool recommendations,
    @Default(false) bool contentRating,
    
    // Accessibility & Customization
    @Default(true) bool themeSwitcher,
    @Default(true) bool fontSizeAdjustment,
    @Default(true) bool languageSwitcher,
    
    // Monetization
    @Default(false) bool premiumFeatures,
    @Default(false) bool advertisements,
    
    // Support & Feedback
    @Default(true) bool helpCenter,
    @Default(true) bool feedback,
    
    // Analytics & Monitoring
    @Default(false) bool analytics,
    @Default(false) bool crashReporting,
    
    // Notifications
    @Default(false) bool pushNotifications,
    @Default(false) bool reminderNotifications,
    
    // Advanced Features
    Map<String, bool>? customFeatures,
  }) = _FeatureConfig;

  factory FeatureConfig.fromJson(Map<String, dynamic> json) =>
      _$FeatureConfigFromJson(json);
}

/// Feature metadata and dependencies
class FeatureMetadata {
  final String id;
  final String name;
  final String description;
  final List<String> dependencies;
  final List<String> conflicts;
  final bool requiresBackend;
  final bool requiresNativeSetup;

  const FeatureMetadata({
    required this.id,
    required this.name,
    required this.description,
    this.dependencies = const [],
    this.conflicts = const [],
    this.requiresBackend = false,
    this.requiresNativeSetup = false,
  });
}

/// Feature registry for validation and management
class FeatureRegistry {
  static const Map<String, FeatureMetadata> features = {
    'courseCatalog': FeatureMetadata(
      id: 'courseCatalog',
      name: 'Course Catalog',
      description: 'Browse and discover available courses',
    ),
    'lessonReader': FeatureMetadata(
      id: 'lessonReader',
      name: 'Lesson Reader',
      description: 'Read lesson content with rich formatting',
    ),
    'quizEngine': FeatureMetadata(
      id: 'quizEngine',
      name: 'Quiz Engine',
      description: 'Interactive quizzes and knowledge checks',
    ),
    'progressTracking': FeatureMetadata(
      id: 'progressTracking',
      name: 'Progress Tracking',
      description: 'Track learning progress and completion',
    ),
    'cloudSync': FeatureMetadata(
      id: 'cloudSync',
      name: 'Cloud Synchronization',
      description: 'Sync progress across devices',
      dependencies: ['userAccounts'],
      requiresBackend: true,
    ),
    'userAccounts': FeatureMetadata(
      id: 'userAccounts',
      name: 'User Accounts',
      description: 'User registration and authentication',
      requiresBackend: true,
    ),
    'codePlayground': FeatureMetadata(
      id: 'codePlayground',
      name: 'Code Playground',
      description: 'Execute code in sandboxed environment',
      requiresBackend: true,
    ),
    'advertisements': FeatureMetadata(
      id: 'advertisements',
      name: 'Advertisements',
      description: 'Display ads (AdMob integration)',
      conflicts: ['premiumFeatures'],
      requiresNativeSetup: true,
    ),
    'pushNotifications': FeatureMetadata(
      id: 'pushNotifications',
      name: 'Push Notifications',
      description: 'Send push notifications to users',
      requiresNativeSetup: true,
    ),
  };

  /// Validate feature configuration
  static List<String> validateFeatures(FeatureConfig config) {
    final errors = <String>[];
    final enabledFeatures = _getEnabledFeatures(config);

    for (final featureId in enabledFeatures) {
      final metadata = features[featureId];
      if (metadata == null) continue;

      // Check dependencies
      for (final dependency in metadata.dependencies) {
        if (!enabledFeatures.contains(dependency)) {
          errors.add(
            'Feature "$featureId" requires "$dependency" to be enabled',
          );
        }
      }

      // Check conflicts
      for (final conflict in metadata.conflicts) {
        if (enabledFeatures.contains(conflict)) {
          errors.add(
            'Feature "$featureId" conflicts with "$conflict"',
          );
        }
      }
    }

    return errors;
  }

  static List<String> _getEnabledFeatures(FeatureConfig config) {
    final enabled = <String>[];
    
    if (config.courseCatalog) enabled.add('courseCatalog');
    if (config.lessonReader) enabled.add('lessonReader');
    if (config.quizEngine) enabled.add('quizEngine');
    if (config.progressTracking) enabled.add('progressTracking');
    if (config.cloudSync) enabled.add('cloudSync');
    if (config.userAccounts) enabled.add('userAccounts');
    if (config.codePlayground) enabled.add('codePlayground');
    if (config.advertisements) enabled.add('advertisements');
    if (config.pushNotifications) enabled.add('pushNotifications');
    
    // Add custom features
    config.customFeatures?.forEach((key, value) {
      if (value) enabled.add(key);
    });
    
    return enabled;
  }
}
