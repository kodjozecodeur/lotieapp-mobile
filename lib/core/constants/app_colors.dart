import 'package:flutter/material.dart';

/// Application color palette
/// 
/// This file defines all the colors used throughout the app,
/// following Apple's Human Interface Guidelines for a modern,
/// sleek, and minimal design aesthetic.

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors (iOS Blue theme)
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryDark = Color(0xFF0056CC);
  static const Color primaryLight = Color(0xFF4DA6FF);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF5856D6);
  static const Color secondaryDark = Color(0xFF3D3C9E);
  static const Color secondaryLight = Color(0xFF7B7AE5);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF9500);
  static const Color accentDark = Color(0xFFE6850E);
  static const Color accentLight = Color(0xFFFFB84D);
  
  // Success, Warning, Error Colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF007AFF);
  
  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF8E8E93);
  static const Color lightGray = Color(0xFFF2F2F7);
  static const Color darkGray = Color(0xFF48484A);
  
  // Background Colors
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textTertiary = Color(0xFFC7C7CC);
  
  // Border Colors
  static const Color border = Color(0xFFE5E5EA);
  static const Color borderLight = Color(0xFFF2F2F7);
  static const Color borderDark = Color(0xFFC7C7CC);
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x33000000);
}
