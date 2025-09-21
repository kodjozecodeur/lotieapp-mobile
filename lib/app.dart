import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routes/app_router.dart';
import 'core/constants/design_tokens.dart';
import 'core/utils/logger.dart';

/// Main application widget that configures the app structure
/// 
/// This file separates the app configuration from main.dart
/// following clean architecture principles. It handles:
/// - Theme configuration
/// - Riverpod setup
/// - Route configuration
/// - Global app settings
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    logger.debug('[App] Building app with Riverpod');
    
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // iPhone 12 Pro size as base
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Lotie App',
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }

  /// Builds the app theme using design tokens from Figma
  /// 
  /// This creates a modern, sleek, and minimal design that's
  /// consistent with your Figma design system
  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DesignTokens.primary950,
        brightness: Brightness.light,
        primary: DesignTokens.primary950,
        secondary: DesignTokens.secondary500,
        surface: Colors.white,
        error: DesignTokens.error500,
      ),
      fontFamily: DesignTokens.fontFamilyPrimary,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: DesignTokens.fontSize5xl.sp,
          fontWeight: DesignTokens.fontWeightBold,
          letterSpacing: DesignTokens.letterSpacingTight,
          color: DesignTokens.neutral900,
        ),
        displayMedium: TextStyle(
          fontSize: DesignTokens.fontSize4xl.sp,
          fontWeight: DesignTokens.fontWeightBold,
          letterSpacing: DesignTokens.letterSpacingTight,
          color: DesignTokens.neutral900,
        ),
        displaySmall: TextStyle(
          fontSize: DesignTokens.fontSize3xl.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
        headlineLarge: TextStyle(
          fontSize: DesignTokens.fontSize2xl.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
        headlineMedium: TextStyle(
          fontSize: DesignTokens.fontSizeXl.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
        headlineSmall: TextStyle(
          fontSize: DesignTokens.fontSizeLg.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
        titleLarge: TextStyle(
          fontSize: DesignTokens.fontSizeBase.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
        titleMedium: TextStyle(
          fontSize: DesignTokens.fontSizeSm.sp,
          fontWeight: DesignTokens.fontWeightMedium,
          color: DesignTokens.neutral900,
        ),
        titleSmall: TextStyle(
          fontSize: DesignTokens.fontSizeXs.sp,
          fontWeight: DesignTokens.fontWeightMedium,
          color: DesignTokens.neutral900,
        ),
        bodyLarge: TextStyle(
          fontSize: DesignTokens.fontSizeBase.sp,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.neutral900,
        ),
        bodyMedium: TextStyle(
          fontSize: DesignTokens.fontSizeSm.sp,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.neutral700,
        ),
        bodySmall: TextStyle(
          fontSize: DesignTokens.fontSizeXs.sp,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.neutral600,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: DesignTokens.appBarElevation,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: DesignTokens.neutral900,
        titleTextStyle: TextStyle(
          fontSize: DesignTokens.fontSizeLg.sp,
          fontWeight: DesignTokens.fontWeightSemiBold,
          color: DesignTokens.neutral900,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.buttonPaddingHorizontal.w,
            vertical: DesignTokens.buttonPaddingVertical.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: DesignTokens.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.cardBorderRadius.r),
        ),
        color: Colors.white,
      ),
    );
  }
}

