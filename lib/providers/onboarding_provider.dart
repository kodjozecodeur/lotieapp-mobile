import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding state provider
/// 
/// This provider manages the onboarding flow state including:
/// - Current page tracking
/// - Onboarding completion status
/// - Persistent storage of onboarding state
/// - Navigation logic

class OnboardingProvider extends ChangeNotifier {
  // Private constructor
  OnboardingProvider._();
  
  // Singleton instance
  static final OnboardingProvider _instance = OnboardingProvider._();
  
  /// Get singleton instance
  static OnboardingProvider get instance => _instance;
  
  // Private fields
  int _currentPage = 0;
  bool _isOnboardingCompleted = false;
  bool _isLoading = false;
  
  // Getters
  int get currentPage => _currentPage;
  bool get isOnboardingCompleted => _isOnboardingCompleted;
  bool get isLoading => _isLoading;
  
  /// Initialize the provider
  /// 
  /// Loads onboarding completion status from shared preferences
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _isOnboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
    } catch (e) {
      debugPrint('[OnboardingProvider] Error initializing: $e');
      _isOnboardingCompleted = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Set current page
  /// 
  /// Updates the current onboarding page index
  void setCurrentPage(int page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }
  
  /// Complete onboarding
  /// 
  /// Marks onboarding as completed and saves to persistent storage
  Future<void> completeOnboarding() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_completed', true);
      _isOnboardingCompleted = true;
    } catch (e) {
      debugPrint('[OnboardingProvider] Error completing onboarding: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Reset onboarding
  /// 
  /// Resets onboarding completion status (useful for testing)
  Future<void> resetOnboarding() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('onboarding_completed');
      _isOnboardingCompleted = false;
      _currentPage = 0;
    } catch (e) {
      debugPrint('[OnboardingProvider] Error resetting onboarding: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Check if onboarding should be shown
  /// 
  /// Returns true if onboarding hasn't been completed yet
  bool shouldShowOnboarding() {
    return !_isOnboardingCompleted;
  }
}
