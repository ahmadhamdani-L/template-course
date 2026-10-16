import 'package:flutter_test/flutter_test.dart';
import 'package:edu_app_engine/core/config/config_validator.dart';
import 'package:edu_app_engine/core/config/models/app_config.dart';
import 'package:edu_app_engine/core/config/models/branding_config.dart';
import 'package:edu_app_engine/core/config/models/navigation_config.dart';
import 'package:edu_app_engine/core/config/models/feature_config.dart';
import 'package:edu_app_engine/core/config/models/localization_config.dart';

void main() {
  group('ConfigValidator', () {
    late ConfigValidator validator;

    setUp(() {
      validator = ConfigValidator();
    });

    test('validates valid configuration', () {
      final config = _createValidConfig();
      final result = validator.validate(config);

      expect(result.isValid, true);
      expect(result.errors, isEmpty);
    });

    test('fails when app key is missing', () {
      final config = _createValidConfig().copyWith(appKey: '');
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(result.errors, contains('App key is required'));
    });

    test('fails when app key contains invalid characters', () {
      final config = _createValidConfig().copyWith(appKey: 'Invalid-Key!');
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('App key must contain only lowercase letters, numbers, and underscores'),
      );
    });

    test('fails when display name is missing', () {
      final config = _createValidConfig().copyWith(
        identity: _createValidIdentity().copyWith(displayName: ''),
      );
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(result.errors, contains('Display name is required'));
    });

    test('fails when primary color is invalid', () {
      final config = _createValidConfig().copyWith(
        branding: _createValidBranding().copyWith(
          colors: const ColorSchemeConfig(
            primary: 'invalid',
            secondary: '#FF0000',
          ),
        ),
      );
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(result.errors.any((e) => e.contains('valid hex color')), true);
    });

    test('fails when no navigation destinations', () {
      final config = _createValidConfig().copyWith(
        navigation: _createValidNavigation().copyWith(destinations: []),
      );
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('At least one navigation destination is required'),
      );
    });

    test('fails when default locale not in supported locales', () {
      final config = _createValidConfig().copyWith(
        localization: const LocalizationConfig(
          defaultLocale: 'fr',
          supportedLocales: ['en', 'id'],
        ),
      );
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(
        result.errors,
        contains('Default locale must be in supported locales list'),
      );
    });

    test('validates feature dependencies', () {
      final config = _createValidConfig().copyWith(
        features: const FeatureConfig(
          cloudSync: true,
          userAccounts: false, // Required by cloudSync
        ),
      );
      final result = validator.validate(config);

      expect(result.isValid, false);
      expect(
        result.errors.any((e) => e.contains('cloudSync') && e.contains('userAccounts')),
        true,
      );
    });
  });
}

AppConfig _createValidConfig() {
  return AppConfig(
    schemaVersion: '1.0',
    appKey: 'test_app',
    identity: _createValidIdentity(),
    branding: _createValidBranding(),
    navigation: _createValidNavigation(),
    features: const FeatureConfig(),
    localization: const LocalizationConfig(
      defaultLocale: 'en',
      supportedLocales: ['en', 'id'],
    ),
    content: const ContentConfig(bundledEnabled: true),
  );
}

AppIdentity _createValidIdentity() {
  return const AppIdentity(
    displayName: 'Test App',
    shortName: 'Test',
    description: 'A test application',
    publisher: PublisherInfo(name: 'Test Publisher'),
    version: '1.0.0',
    buildNumber: 1,
  );
}

BrandingConfig _createValidBranding() {
  return const BrandingConfig(
    preset: 'default',
    colors: ColorSchemeConfig(
      primary: '#6750A4',
      secondary: '#625B71',
    ),
    typography: TypographyConfig(),
    assets: AssetConfig(logo: 'assets/logo.png'),
  );
}

NavigationConfig _createValidNavigation() {
  return const NavigationConfig(
    type: NavigationType.bottomNav,
    destinations: [
      NavDestination(
        id: 'home',
        labelKey: 'home',
        icon: 'home',
        route: '/',
      ),
    ],
    dashboard: DashboardConfig(
      sections: [
        DashboardSection(
          id: 'test',
          type: DashboardSectionType.continueLearning,
          titleKey: 'test',
          order: 1,
        ),
      ],
    ),
  );
}
