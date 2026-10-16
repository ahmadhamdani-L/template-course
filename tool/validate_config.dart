import 'dart:convert';
import 'dart:io';

/// Configuration validation tool
/// Usage: dart run tool/validate_config.dart <profile_name>
void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('❌ Usage: dart run tool/validate_config.dart <profile_name>');
    exit(1);
  }

  final profileName = arguments[0];
  final profilePath = 'assets/config/profiles/$profileName.json';

  print('🔍 Validating configuration profile: $profileName');
  print('📁 Path: $profilePath');
  print('');

  try {
    // Check if file exists
    final file = File(profilePath);
    if (!file.existsSync()) {
      print('❌ ERROR: Profile file not found');
      exit(1);
    }

    // Read and parse JSON
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;

    // Validate schema version
    if (!json.containsKey('schemaVersion')) {
      print('❌ ERROR: Missing schemaVersion');
      exit(1);
    }

    // Validate required fields
    final errors = <String>[];
    final warnings = <String>[];

    _validateRequired(json, 'appKey', errors);
    _validateRequired(json, 'identity', errors);
    _validateRequired(json, 'branding', errors);
    _validateRequired(json, 'navigation', errors);
    _validateRequired(json, 'features', errors);
    _validateRequired(json, 'localization', errors);
    _validateRequired(json, 'content', errors);

    // Validate identity
    if (json.containsKey('identity')) {
      final identity = json['identity'] as Map<String, dynamic>;
      _validateRequired(identity, 'displayName', errors);
      _validateRequired(identity, 'shortName', errors);
      _validateRequired(identity, 'description', errors);
      _validateRequired(identity, 'publisher', errors);
      _validateRequired(identity, 'version', errors);
      _validateRequired(identity, 'buildNumber', errors);
    }

    // Validate branding
    if (json.containsKey('branding')) {
      final branding = json['branding'] as Map<String, dynamic>;
      _validateRequired(branding, 'preset', errors);
      _validateRequired(branding, 'colors', errors);
      _validateRequired(branding, 'assets', errors);

      if (branding.containsKey('colors')) {
        final colors = branding['colors'] as Map<String, dynamic>;
        _validateRequired(colors, 'primary', errors);
        _validateRequired(colors, 'secondary', errors);

        // Validate hex colors
        if (colors.containsKey('primary')) {
          _validateHexColor(colors['primary'], 'primary', errors);
        }
        if (colors.containsKey('secondary')) {
          _validateHexColor(colors['secondary'], 'secondary', errors);
        }
      }
    }

    // Validate navigation
    if (json.containsKey('navigation')) {
      final navigation = json['navigation'] as Map<String, dynamic>;
      _validateRequired(navigation, 'type', errors);
      _validateRequired(navigation, 'destinations', errors);
      _validateRequired(navigation, 'dashboard', errors);

      if (navigation.containsKey('destinations')) {
        final destinations = navigation['destinations'] as List;
        if (destinations.isEmpty) {
          errors.add('Navigation destinations cannot be empty');
        }
      }
    }

    // Validate localization
    if (json.containsKey('localization')) {
      final localization = json['localization'] as Map<String, dynamic>;
      _validateRequired(localization, 'defaultLocale', errors);
      _validateRequired(localization, 'supportedLocales', errors);

      if (localization.containsKey('supportedLocales')) {
        final locales = localization['supportedLocales'] as List;
        if (locales.isEmpty) {
          errors.add('Supported locales cannot be empty');
        }
        if (!locales.contains(localization['defaultLocale'])) {
          errors.add('Default locale must be in supported locales');
        }
      }
    }

    // Print results
    if (errors.isNotEmpty) {
      print('❌ VALIDATION FAILED');
      print('');
      print('Errors:');
      for (final error in errors) {
        print('  - $error');
      }
      exit(1);
    }

    if (warnings.isNotEmpty) {
      print('⚠️  WARNINGS');
      for (final warning in warnings) {
        print('  - $warning');
      }
      print('');
    }

    print('✅ VALIDATION PASSED');
    print('');
    print('Profile Summary:');
    print('  App Key: ${json['appKey']}');
    if (json.containsKey('identity')) {
      final identity = json['identity'] as Map<String, dynamic>;
      print('  Display Name: ${identity['displayName']}');
      print('  Version: ${identity['version']}');
    }
    if (json.containsKey('localization')) {
      final localization = json['localization'] as Map<String, dynamic>;
      print('  Locales: ${localization['supportedLocales']}');
    }
    print('');

    exit(0);
  } catch (e, stackTrace) {
    print('❌ ERROR: Failed to validate configuration');
    print('');
    print('Details: $e');
    if (e is FormatException) {
      print('This usually means the JSON is malformed');
    }
    exit(1);
  }
}

void _validateRequired(Map<String, dynamic> map, String key, List<String> errors) {
  if (!map.containsKey(key)) {
    errors.add('Missing required field: $key');
  }
}

void _validateHexColor(dynamic value, String name, List<String> errors) {
  if (value is! String) {
    errors.add('Color $name must be a string');
    return;
  }

  final hex = value.replaceFirst('#', '');
  if (!RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(hex) &&
      !RegExp(r'^[0-9A-Fa-f]{8}$').hasMatch(hex)) {
    errors.add('Color $name is not a valid hex color: $value');
  }
}
