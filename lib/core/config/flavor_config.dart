import 'package:flutter/foundation.dart';

/// Flutter Flavor Configuration
/// 
/// This enum defines the different environments/flavors for the Lotie app.
/// Each flavor represents a different build configuration with its own
/// API endpoints, app identifiers, and other environment-specific settings.
enum Flavor {
  /// Staging environment for testing and development
  staging,
  
  /// Production environment for live app store releases
  production,
}

/// Flavor Configuration Manager
/// 
/// Singleton class that manages the current flavor/environment configuration.
/// This allows the app to dynamically switch between different environments
/// based on the build flavor.
class FlavorConfig {
  static FlavorConfig? _instance;
  static FlavorConfig get instance {
    _instance ??= FlavorConfig._internal();
    return _instance!;
  }

  FlavorConfig._internal();

  /// Current flavor/environment
  Flavor _flavor = Flavor.staging;

  /// Get the current flavor
  Flavor get flavor => _flavor;

  /// Set the current flavor (typically called from main.dart)
  void setFlavor(Flavor flavor) {
    _flavor = flavor;
    if (kDebugMode) {
      print('[FlavorConfig] Environment set to: ${flavor.name}');
    }
  }

  /// Check if current flavor is staging
  bool get isStaging => _flavor == Flavor.staging;

  /// Check if current flavor is production
  bool get isProduction => _flavor == Flavor.production;

  /// Get environment name as string
  String get environmentName => _flavor.name.toUpperCase();

  /// Get app display name with environment suffix
  String get appDisplayName {
    switch (_flavor) {
      case Flavor.staging:
        return 'LotieApp (Staging)';
      case Flavor.production:
        return 'LotieApp';
    }
  }

  /// Get app bundle identifier suffix
  String get bundleIdSuffix {
    switch (_flavor) {
      case Flavor.staging:
        return '.staging';
      case Flavor.production:
        return '';
    }
  }
}
