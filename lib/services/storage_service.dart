import 'package:shared_preferences/shared_preferences.dart';

/// Storage service for managing app preferences and state
/// 
/// This service handles persistent storage using SharedPreferences
/// for user preferences, onboarding completion, and other app state.
class StorageService {
  // Private constructor to prevent instantiation
  StorageService._();

  /// Storage keys
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _firstLaunchKey = 'first_launch';
  static const String _loginCompletedKey = 'login_completed';

  /// Check if onboarding has been completed
  /// 
  /// Returns true if the user has completed the onboarding flow
  static Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      print('[StorageService] Error checking onboarding status: $e');
      return false;
    }
  }

  /// Mark onboarding as completed
  /// 
  /// Call this when the user finishes the onboarding flow
  static Future<void> markOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompletedKey, true);
      print('[StorageService] Onboarding marked as completed');
    } catch (e) {
      print('[StorageService] Error marking onboarding completed: $e');
    }
  }

  /// Check if this is the first app launch
  /// 
  /// Returns true if this is the very first time the app is launched
  static Future<bool> isFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirst = prefs.getBool(_firstLaunchKey) ?? true;
      
      // Mark as not first launch after checking
      if (isFirst) {
        await prefs.setBool(_firstLaunchKey, false);
      }
      
      return isFirst;
    } catch (e) {
      print('[StorageService] Error checking first launch: $e');
      return true; // Default to first launch if error
    }
  }

  /// Check if login has been completed
  /// 
  /// Returns true if the user has successfully completed login/registration
  static Future<bool> isLoginCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_loginCompletedKey) ?? false;
    } catch (e) {
      print('[StorageService] Error checking login status: $e');
      return false;
    }
  }

  /// Mark login as completed
  /// 
  /// Call this when the user successfully completes login or registration
  static Future<void> markLoginCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginCompletedKey, true);
      print('[StorageService] Login marked as completed');
    } catch (e) {
      print('[StorageService] Error marking login completed: $e');
    }
  }

  /// Reset onboarding status (for testing/debugging)
  /// 
  /// This will make the onboarding appear again on next app launch
  static Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompletedKey, false);
      await prefs.setBool(_firstLaunchKey, true);
      await prefs.setBool(_loginCompletedKey, false);
      print('[StorageService] Onboarding status reset');
    } catch (e) {
      print('[StorageService] Error resetting onboarding: $e');
    }
  }

  /// Clear all stored preferences
  /// 
  /// This will reset the app to its initial state
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('[StorageService] All preferences cleared');
    } catch (e) {
      print('[StorageService] Error clearing preferences: $e');
    }
  }
}
