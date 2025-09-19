import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/design_tokens.dart';
import '../../routes/app_router.dart';

/// Splash screen widget
/// 
/// This is the first screen users see when opening the app.
/// It displays the app logo and handles the initial navigation logic
/// based on user authentication state and onboarding completion.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateAfterDelay();
  }

  /// Initialize splash screen animations
  /// 
  /// Creates smooth fade-in and scale animations for the logo
  /// following Apple's Human Interface Guidelines
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: DesignTokens.durationSlow,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOutBack,
    ));

    _animationController.forward();
  }

  /// Handle navigation after splash delay
  /// 
  /// Determines the next screen based on:
  /// - User authentication state
  /// - Onboarding completion status
  /// - App first launch
  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _determineNextRoute();
      }
    });
  }

  /// Navigate to loading screen after splash
  /// 
  /// The loading screen will handle the actual navigation logic
  /// to determine the next screen based on app state
  void _determineNextRoute() {
    // Navigate to loading screen which will handle the actual routing logic
    AppRouter.goToOnboarding(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure white background as per design
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120.w,
                    height: 120.w,
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
}
