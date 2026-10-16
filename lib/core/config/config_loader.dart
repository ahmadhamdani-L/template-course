import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/app_config.dart';
import 'config_validator.dart';

/// Configuration loader with validation and error handling
class ConfigLoader {
  static const String _defaultProfilePath = 'assets/config/profiles/';
  static const String _defaultProfile = 'default';
  
  /// Load application configuration from profile
  static Future<AppConfig> loadProfile(String profileName) async {
    try {
      final profilePath = '$_defaultProfilePath$profileName.json';
      final jsonString = await rootBundle.loadString(profilePath);
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      
      final config = AppConfig.fromJson(json);
      
      // Validate configuration
      final validator = ConfigValidator();
      final validationResult = validator.validate(config);
      
      if (!validationResult.isValid) {
        throw ConfigurationException(
          'Configuration validation failed for profile "$profileName"',
          errors: validationResult.errors,
          warnings: validationResult.warnings,
        );
      }
      
      // Log warnings if any
      if (validationResult.warnings.isNotEmpty) {
        for (final warning in validationResult.warnings) {
          print('CONFIG WARNING: $warning');
        }
      }
      
      return config;
    } on ConfigurationException {
      rethrow;
    } catch (e, stackTrace) {
      throw ConfigurationException(
        'Failed to load configuration profile "$profileName": $e',
        stackTrace: stackTrace,
      );
    }
  }
  
  /// Load default configuration (fallback)
  static Future<AppConfig> loadDefault() async {
    return loadProfile(_defaultProfile);
  }
  
  /// Check if profile exists
  static Future<bool> profileExists(String profileName) async {
    try {
      final profilePath = '$_defaultProfilePath$profileName.json';
      await rootBundle.load(profilePath);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Get available profiles (if manifest exists)
  static Future<List<String>> getAvailableProfiles() async {
    try {
      final manifestString = await rootBundle.loadString(
        '${_defaultProfilePath}manifest.json',
      );
      final manifest = jsonDecode(manifestString) as Map<String, dynamic>;
      final profiles = manifest['profiles'] as List<dynamic>?;
      return profiles?.cast<String>() ?? [];
    } catch (e) {
      // Manifest not found or invalid, return empty list
      return [];
    }
  }
}

/// Configuration exception with detailed error information
class ConfigurationException implements Exception {
  final String message;
  final List<String>? errors;
  final List<String>? warnings;
  final StackTrace? stackTrace;

  ConfigurationException(
    this.message, {
    this.errors,
    this.warnings,
    this.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ConfigurationException: $message');
    
    if (errors != null && errors!.isNotEmpty) {
      buffer.write('\nErrors:');
      for (final error in errors!) {
        buffer.write('\n  - $error');
      }
    }
    
    if (warnings != null && warnings!.isNotEmpty) {
      buffer.write('\nWarnings:');
      for (final warning in warnings!) {
        buffer.write('\n  - $warning');
      }
    }
    
    return buffer.toString();
  }
}
