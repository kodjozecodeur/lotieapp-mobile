/// API configuration for Express.js backend integration
/// 
/// This file manages all API-related configuration including:
/// - Base URLs for different environments
/// - Endpoint definitions for Express.js routes
/// - Feature flags for mock vs real API
/// - JWT token configuration

class ApiConfig {
  // Private constructor to prevent instantiation
  ApiConfig._();
  
  /// Base URL configuration
  /// 
  /// Uses environment variables to support different environments:
  /// - Development: localhost:3000 (Express.js default)
  /// - Staging: your staging server
  /// - Production: your production server
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api', // Express.js default structure
  );
  
  /// Feature flag to switch between mock and real API
  /// 
  /// Set to false when your Express.js API is ready
  static const bool useMockData = bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true, // Start with mocks, switch when API is ready
  );
  
  /// API timeout configurations
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 10);
  
  /// Express.js API endpoint structure
  /// 
  /// Following RESTful conventions typically used in Express.js applications
  static const Map<String, String> authEndpoints = {
    'login': '/auth/login',
    'register': '/auth/register',
    'logout': '/auth/logout',
    'me': '/auth/me',                    // Get current user profile
    'refresh': '/auth/refresh',          // Refresh JWT token
    'forgotPassword': '/auth/forgot-password',
    'resetPassword': '/auth/reset-password',
  };
  
  /// User management endpoints
  static const Map<String, String> userEndpoints = {
    'profile': '/user/profile',
    'updateProfile': '/user/profile',
    'deleteAccount': '/user/account',
    'uploadAvatar': '/user/avatar',
  };
  
  /// JWT token configuration
  static const String tokenHeader = 'Authorization';
  static const String tokenPrefix = 'Bearer';
  
  /// Storage keys for secure token storage
  static const String accessTokenKey = 'jwt_access_token';
  static const String refreshTokenKey = 'jwt_refresh_token';
  static const String userDataKey = 'user_data';
  
  /// Request headers for Express.js API
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'LotieApp/1.0.0',
  };
  
  /// Environment detection helpers
  static bool get isDevelopment => baseUrl.contains('localhost');
  static bool get isProduction => !isDevelopment && !isStaging;
  static bool get isStaging => baseUrl.contains('staging');
  
  /// API version for future compatibility
  static const String apiVersion = 'v1';
  
  /// Full endpoint URL builder
  /// 
  /// Combines base URL with endpoint paths
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
  
  /// Build authenticated endpoint URL
  static String buildAuthUrl(String endpointKey) {
    final endpoint = authEndpoints[endpointKey];
    if (endpoint == null) {
      throw ArgumentError('Unknown auth endpoint: $endpointKey');
    }
    return buildUrl(endpoint);
  }
  
  /// Build user endpoint URL
  static String buildUserUrl(String endpointKey) {
    final endpoint = userEndpoints[endpointKey];
    if (endpoint == null) {
      throw ArgumentError('Unknown user endpoint: $endpointKey');
    }
    return buildUrl(endpoint);
  }
}

/// Environment configuration helper
/// 
/// Manages different environment settings for development, staging, and production
class EnvironmentConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );
  
  /// Debug mode configuration
  static const bool isDebug = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );
  
  /// Logging level configuration
  static const String logLevel = String.fromEnvironment(
    'LOG_LEVEL',
    defaultValue: 'debug', // debug, info, warning, error
  );
  
  /// Feature flags
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: false,
  );
  
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
    defaultValue: false,
  );
}
