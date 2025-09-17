/// Application-wide constants
/// 
/// This file contains all the constant values used throughout the app.
/// Following clean architecture principles, constants are centralized here
/// for easy maintenance and consistency.

class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'Lotie App';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.lotieapp.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'app_settings';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxUsernameLength = 50;
  static const int maxEmailLength = 100;
}
