import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/config/config_loader.dart';
import '../core/config/models/app_config.dart';

/// Bootstrap the application
Future<ProviderContainer> bootstrap() async {
  // Get app profile from environment or use default
  final appProfile = const String.fromEnvironment(
    'APP_PROFILE',
    defaultValue: 'go_academy',
  );
  
  if (kDebugMode) {
    print('🚀 Bootstrapping EDU APP ENGINE');
    print('📱 Profile: $appProfile');
  }
  
  // Load configuration
  final config = await _loadConfiguration(appProfile);
  
  if (kDebugMode) {
    print('✅ Configuration loaded successfully');
    print('📚 App: ${config.identity.displayName}');
    print('🌐 Locales: ${config.localization.supportedLocales}');
    print('🎨 Theme: ${config.branding.preset}');
  }
  
  // Create provider container with overrides
  final container = ProviderContainer(
    overrides: [
      appConfigProvider.overrideWithValue(config),
    ],
  );
  
  return container;
}

Future<AppConfig> _loadConfiguration(String profileName) async {
  try {
    return await ConfigLoader.loadProfile(profileName);
  } catch (e) {
    if (kDebugMode) {
      print('⚠️  Failed to load profile "$profileName", using default');
      print('Error: $e');
    }
    
    // Fallback to default profile
    try {
      return await ConfigLoader.loadDefault();
    } catch (e) {
      // If even default fails, we have a critical error
      if (kDebugMode) {
        print('❌ CRITICAL: Failed to load default configuration');
        print('Error: $e');
      }
      rethrow;
    }
  }
}

/// Provider for application configuration
final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('AppConfig must be overridden during bootstrap');
});
