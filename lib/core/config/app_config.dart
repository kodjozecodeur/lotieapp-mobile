import 'flavor_config.dart';

/// Application Configuration
/// 
/// Centralized configuration class that provides environment-specific
/// settings for API endpoints, timeouts, and other app-wide constants.
/// This class automatically adapts based on the current Flutter flavor.
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  /// API Configuration
  static const String _stagingBaseUrl = 'https://staging-api.lotieapp.com';
  static const String _productionBaseUrl = 'https://api.lotieapp.com';
  
  /// API Timeouts (in milliseconds)
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  /// Authentication Configuration
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';

  /// App Configuration
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  /// Get the base API URL based on current flavor
  static String get baseUrl {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.staging:
        return _stagingBaseUrl;
      case Flavor.production:
        return _productionBaseUrl;
    }
  }

  /// Get the full API URL for a specific endpoint
  static String getApiUrl(String endpoint) {
    // Remove leading slash if present
    final cleanEndpoint = endpoint.startsWith('/') 
        ? endpoint.substring(1) 
        : endpoint;
    
    return '$baseUrl/$cleanEndpoint';
  }

  /// Authentication endpoints
  static String get loginUrl => getApiUrl('auth/login');
  static String get registerUrl => getApiUrl('auth/register');
  static String get refreshTokenUrl => getApiUrl('auth/refresh');
  static String get logoutUrl => getApiUrl('auth/logout');
  static String get forgotPasswordUrl => getApiUrl('auth/forgot-password');
  static String get resetPasswordUrl => getApiUrl('auth/reset-password');

  /// User endpoints
  static String get userProfileUrl => getApiUrl('user/profile');
  static String get updateProfileUrl => getApiUrl('user/profile');
  static String get changePasswordUrl => getApiUrl('user/change-password');

  /// App endpoints
  static String get appConfigUrl => getApiUrl('app/config');
  static String get appVersionUrl => getApiUrl('app/version');

  /// Check if we're in debug mode
  static bool get isDebugMode {
    return FlavorConfig.instance.isStaging;
  }

  /// Get environment-specific app name
  static String get appName => FlavorConfig.instance.appDisplayName;

  /// Get environment-specific bundle ID suffix
  static String get bundleIdSuffix => FlavorConfig.instance.bundleIdSuffix;

  /// Logging configuration
  static bool get enableDetailedLogging => FlavorConfig.instance.isStaging;
  static bool get enableNetworkLogging => FlavorConfig.instance.isStaging;
  static bool get enablePerformanceLogging => FlavorConfig.instance.isStaging;

  /// Print current configuration (for debugging)
  static void printConfig() {
    print('[AppConfig] Current Configuration:');
    print('[AppConfig] Environment: ${FlavorConfig.instance.environmentName}');
    print('[AppConfig] Base URL: $baseUrl');
    print('[AppConfig] App Name: $appName');
    print('[AppConfig] Debug Mode: $isDebugMode');
    print('[AppConfig] Detailed Logging: $enableDetailedLogging');
  }
}
