import 'package:flutter/material.dart';

/// Design tokens for consistent theming across the app
/// 
/// This file contains all design tokens exported from Figma,
/// ensuring pixel-perfect implementation of your design system.
/// Update these values to match your Figma design exactly.

class DesignTokens {
  // Private constructor to prevent instantiation
  DesignTokens._();

  // ============================================================================
  // COLORS - Export these exact values from your Figma design
  // ============================================================================
  
  /// Primary brand colors - Dark Green (#144A19)
  static const Color primary50 = Color(0xFFE8F5E8);
  static const Color primary100 = Color(0xFFC8E6C9);
  static const Color primary200 = Color(0xFFA5D6A7);
  static const Color primary300 = Color(0xFF81C784);
  static const Color primary400 = Color(0xFF66BB6A);
  static const Color primary500 = Color(0xFF4CAF50);
  static const Color primary600 = Color(0xFF43A047);
  static const Color primary700 = Color(0xFF388E3C);
  static const Color primary800 = Color(0xFF2E7D32);
  static const Color primary900 = Color(0xFF1B5E20);
  static const Color primary950 = Color(0xFF144A19);

  /// Secondary brand colors
  static const Color secondary50 = Color(0xFFF3E5F5);
  static const Color secondary100 = Color(0xFFE1BEE7);
  static const Color secondary200 = Color(0xFFCE93D8);
  static const Color secondary300 = Color(0xFFBA68C8);
  static const Color secondary400 = Color(0xFFAB47BC);
  static const Color secondary500 = Color(0xFF9C27B0);
  static const Color secondary600 = Color(0xFF8E24AA);
  static const Color secondary700 = Color(0xFF7B1FA2);
  static const Color secondary800 = Color(0xFF6A1B9A);
  static const Color secondary900 = Color(0xFF4A148C);
  static const Color secondary950 = Color(0xFFFFCF19);

  /// Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFFF4F5F4);
  static const Color neutral550 = Color(0xFF181727);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral650 = Color(0xFF8C8C8C);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral850 = Color(0xFF111111);

  static const Color neutral900 = Color(0xFF090B09);

  /// Semantic colors
  static const Color success50 = Color(0xFFE8F5E8);
  static const Color success500 = Color(0xFF4CAF50);
  static const Color success700 = Color(0xFF388E3C);

  static const Color warning50 = Color(0xFFFFF3E0);
  static const Color warning500 = Color(0xFFFF9800);
  static const Color warning700 = Color(0xFFF57C00);

  static const Color error50 = Color(0xFFFFEBEE);
  static const Color error500 = Color(0xFFF44336);
  static const Color error700 = Color(0xFFD32F2F);

  static const Color info50 = Color(0xFFE3F2FD);
  static const Color info500 = Color(0xFF2196F3);
  static const Color info700 = Color(0xFF1976D2);

  // ============================================================================
  // TYPOGRAPHY - Export these exact values from your Figma design
  // ============================================================================
  
  /// Font families
  static const String fontFamilyPrimary = 'SF Pro Display';
  static const String fontFamilySecondary = 'SF Pro Text';
  static const String fontFamilyMono = 'SF Mono';

  /// Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightHeavy = FontWeight.w800;

  /// Font sizes
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeBase = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSize2xl = 24.0;
  static const double fontSize3xl = 30.0;
  static const double fontSize4xl = 36.0;
  static const double fontSize5xl = 48.0;
  static const double fontSize6xl = 60.0;

  /// Line heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;

  /// Letter spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;

  // ============================================================================
  // SPACING - Export these exact values from your Figma design
  // ============================================================================
  
  /// Spacing scale (based on 4px grid system)
  static const double space0 = 0.0;
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;
  static const double space24 = 96.0;
  static const double space32 = 128.0;

  // ============================================================================
  // BORDER RADIUS - Export these exact values from your Figma design
  // ============================================================================
  
  static const double radiusNone = 0.0;
  static const double radiusSm = 4.0;
  static const double radiusBase = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;
  static const double radius3xl = 32.0;
  static const double radiusFull = 9999.0;

  // ============================================================================
  // SHADOWS - Export these exact values from your Figma design
  // ============================================================================
  
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowBase = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 10),
      blurRadius: 10,
      spreadRadius: -5,
    ),
  ];

  // ============================================================================
  // ANIMATION DURATIONS - Export these exact values from your Figma design
  // ============================================================================
  
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationSlower = Duration(milliseconds: 700);

  // ============================================================================
  // EASING CURVES - Export these exact values from your Figma design
  // ============================================================================
  
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOutBack = Curves.easeOutBack;
  static const Curve easeInOutCubic = Curves.easeInOutCubic;

  // ============================================================================
  // BREAKPOINTS - For responsive design
  // ============================================================================
  
  static const double breakpointSm = 640.0;
  static const double breakpointMd = 768.0;
  static const double breakpointLg = 1024.0;
  static const double breakpointXl = 1280.0;
  static const double breakpoint2xl = 1536.0;

  // ============================================================================
  // COMPONENT SPECIFIC TOKENS
  // ============================================================================
  
  /// Button tokens
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightBase = 40.0;
  static const double buttonHeightLg = 48.0;
  static const double buttonPaddingHorizontal = 16.0;
  static const double buttonPaddingVertical = 8.0;

  /// Input field tokens
  static const double inputHeight = 48.0;
  static const double inputPaddingHorizontal = 16.0;
  static const double inputPaddingVertical = 12.0;
  static const double inputBorderWidth = 1.0;

  /// Card tokens
  static const double cardPadding = 16.0;
  static const double cardElevation = 0.0;
  static const double cardBorderRadius = 12.0;

  /// App bar tokens
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;

  /// Bottom navigation tokens
  static const double bottomNavHeight = 60.0;
  static const double bottomNavIconSize = 24.0;
}
