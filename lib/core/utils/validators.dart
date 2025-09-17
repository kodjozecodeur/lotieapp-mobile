/// Validation utilities
/// 
/// This file contains all validation functions used throughout the app.
/// Centralizing validation logic ensures consistency and makes it easier
/// to maintain and test.

class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Validates email format
  /// 
  /// Returns true if the email format is valid, false otherwise
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates password strength
  /// 
  /// Returns true if the password meets minimum requirements:
  /// - At least 8 characters long
  /// - Contains at least one uppercase letter
  /// - Contains at least one lowercase letter
  /// - Contains at least one number
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'[0-9]').hasMatch(password);
    
    return hasUpperCase && hasLowerCase && hasDigits;
  }

  /// Validates phone number format
  /// 
  /// Returns true if the phone number format is valid, false otherwise
  static bool isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return false;
    
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if it's a valid length (7-15 digits)
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }

  /// Validates username format
  /// 
  /// Returns true if the username format is valid, false otherwise
  static bool isValidUsername(String username) {
    if (username.isEmpty || username.length < 3) return false;
    
    // Username should only contain letters, numbers, and underscores
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    return usernameRegex.hasMatch(username);
  }

  /// Validates if a string is not empty
  /// 
  /// Returns true if the string is not null and not empty, false otherwise
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates if a string has minimum length
  /// 
  /// Returns true if the string has at least the minimum length, false otherwise
  static bool hasMinLength(String value, int minLength) {
    return value.trim().length >= minLength;
  }

  /// Validates if a string has maximum length
  /// 
  /// Returns true if the string has at most the maximum length, false otherwise
  static bool hasMaxLength(String value, int maxLength) {
    return value.trim().length <= maxLength;
  }
}
