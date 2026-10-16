import 'models/app_config.dart';
import 'models/feature_config.dart';

/// Configuration validation result
class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  const ValidationResult({
    required this.isValid,
    this.errors = const [],
    this.warnings = const [],
  });

  factory ValidationResult.success({List<String> warnings = const []}) {
    return ValidationResult(
      isValid: true,
      warnings: warnings,
    );
  }

  factory ValidationResult.failure(List<String> errors,
      {List<String> warnings = const []}) {
    return ValidationResult(
      isValid: false,
      errors: errors,
      warnings: warnings,
    );
  }
}

/// Configuration validator
class ConfigValidator {
  /// Validate complete application configuration
  ValidationResult validate(AppConfig config) {
    final errors = <String>[];
    final warnings = <String>[];

    // Validate schema version
    if (config.schemaVersion.isEmpty) {
      errors.add('Schema version is required');
    } else if (config.schemaVersion != '1.0') {
      warnings.add(
        'Schema version ${config.schemaVersion} may not be fully supported',
      );
    }

    // Validate app key
    if (config.appKey.isEmpty) {
      errors.add('App key is required');
    } else if (!_isValidAppKey(config.appKey)) {
      errors.add('App key must contain only lowercase letters, numbers, and underscores');
    }

    // Validate identity
    errors.addAll(_validateIdentity(config.identity));

    // Validate branding
    errors.addAll(_validateBranding(config.branding));
    warnings.addAll(_validateBrandingWarnings(config.branding));

    // Validate navigation
    errors.addAll(_validateNavigation(config.navigation, config.features));

    // Validate features
    final featureErrors = FeatureRegistry.validateFeatures(config.features);
    errors.addAll(featureErrors);

    // Validate localization
    errors.addAll(_validateLocalization(config.localization));

    // Validate content
    errors.addAll(_validateContent(config.content));

    if (errors.isEmpty) {
      return ValidationResult.success(warnings: warnings);
    } else {
      return ValidationResult.failure(errors, warnings: warnings);
    }
  }

  bool _isValidAppKey(String key) {
    return RegExp(r'^[a-z0-9_]+$').hasMatch(key);
  }

  List<String> _validateIdentity(AppIdentity identity) {
    final errors = <String>[];

    if (identity.displayName.isEmpty) {
      errors.add('Display name is required');
    }

    if (identity.shortName.isEmpty) {
      errors.add('Short name is required');
    }

    if (identity.description.isEmpty) {
      errors.add('Description is required');
    }

    if (identity.version.isEmpty) {
      errors.add('Version is required');
    }

    if (identity.buildNumber <= 0) {
      errors.add('Build number must be positive');
    }

    if (identity.publisher.name.isEmpty) {
      errors.add('Publisher name is required');
    }

    return errors;
  }

  List<String> _validateBranding(BrandingConfig branding) {
    final errors = <String>[];

    if (branding.preset.isEmpty) {
      errors.add('Branding preset is required');
    }

    if (branding.colors.primary.isEmpty) {
      errors.add('Primary color is required');
    } else if (!_isValidHexColor(branding.colors.primary)) {
      errors.add('Primary color must be a valid hex color');
    }

    if (branding.colors.secondary.isEmpty) {
      errors.add('Secondary color is required');
    } else if (!_isValidHexColor(branding.colors.secondary)) {
      errors.add('Secondary color must be a valid hex color');
    }

    if (branding.assets.logo.isEmpty) {
      errors.add('Logo asset path is required');
    }

    return errors;
  }

  List<String> _validateBrandingWarnings(BrandingConfig branding) {
    final warnings = <String>[];

    if (branding.colors.accent == null) {
      warnings.add('Accent color not specified, will use default');
    }

    if (branding.assets.logoDark == null) {
      warnings.add('Dark theme logo not specified, will use default logo');
    }

    return warnings;
  }

  List<String> _validateNavigation(
    NavigationConfig navigation,
    FeatureConfig features,
  ) {
    final errors = <String>[];

    if (navigation.destinations.isEmpty) {
      errors.add('At least one navigation destination is required');
    }

    // Validate each destination
    for (final destination in navigation.destinations) {
      if (destination.id.isEmpty) {
        errors.add('Destination ID is required');
      }

      if (destination.labelKey.isEmpty) {
        errors.add('Destination label key is required');
      }

      if (destination.route.isEmpty) {
        errors.add('Destination route is required');
      }

      // Check if required features are enabled
      if (destination.requiredFeatures != null) {
        for (final requiredFeature in destination.requiredFeatures!) {
          if (!_isFeatureEnabled(features, requiredFeature)) {
            errors.add(
              'Destination "${destination.id}" requires feature "$requiredFeature" to be enabled',
            );
          }
        }
      }
    }

    // Validate dashboard
    if (navigation.dashboard.sections.isEmpty) {
      errors.add('At least one dashboard section is required');
    }

    return errors;
  }

  List<String> _validateLocalization(LocalizationConfig localization) {
    final errors = <String>[];

    if (localization.defaultLocale.isEmpty) {
      errors.add('Default locale is required');
    }

    if (localization.supportedLocales.isEmpty) {
      errors.add('At least one supported locale is required');
    }

    if (!localization.supportedLocales.contains(localization.defaultLocale)) {
      errors.add('Default locale must be in supported locales list');
    }

    if (!localization.supportedLocales.contains(localization.fallbackLocale)) {
      errors.add('Fallback locale must be in supported locales list');
    }

    return errors;
  }

  List<String> _validateContent(ContentConfig content) {
    final errors = <String>[];

    if (!content.bundledEnabled && !content.remoteEnabled) {
      errors.add('Either bundled or remote content must be enabled');
    }

    if (content.remoteEnabled) {
      if (content.remoteBaseUrl == null || content.remoteBaseUrl!.isEmpty) {
        errors.add('Remote base URL is required when remote content is enabled');
      }
    }

    if (content.updateCheckIntervalHours < 1) {
      errors.add('Update check interval must be at least 1 hour');
    }

    return errors;
  }

  bool _isValidHexColor(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(cleaned) ||
        RegExp(r'^[0-9A-Fa-f]{8}$').hasMatch(cleaned);
  }

  bool _isFeatureEnabled(FeatureConfig features, String featureId) {
    switch (featureId) {
      case 'courseCatalog':
        return features.courseCatalog;
      case 'lessonReader':
        return features.lessonReader;
      case 'quizEngine':
        return features.quizEngine;
      case 'progressTracking':
        return features.progressTracking;
      case 'learningPaths':
        return features.learningPaths;
      case 'bookmarks':
        return features.bookmarks;
      case 'search':
        return features.search;
      case 'achievements':
        return features.achievements;
      default:
        return features.customFeatures?[featureId] ?? false;
    }
  }
}
