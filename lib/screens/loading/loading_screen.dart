import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/design_tokens.dart';
import '../../routes/app_router.dart';
import '../../core/utils/logger.dart';
import '../../providers/auth_notifier.dart';

/// Loading screen widget with animated dots
/// 
/// This screen displays animated dots while the app loads
/// and determines the next navigation step.
/// Follows Apple's Human Interface Guidelines for loading states.

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _dotControllers;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();
    _initializeDotAnimations();
    _navigateAfterDelay();
  }

  /// Initialize dot animations with staggered timing
  /// 
  /// Creates three separate animation controllers for each dot
  /// with a staggered delay to create a wave effect
  void _initializeDotAnimations() {
    _dotControllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _dotAnimations = _dotControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    // Start animations with staggered delay
    for (int i = 0; i < _dotControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _dotControllers[i].repeat(reverse: true);
        }
      });
    }
  }

  /// Handle navigation after loading delay
  /// 
  /// Determines the next screen based on:
  /// - User authentication state
  /// - Onboarding completion status
  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _determineNextRoute();
      }
    });
  }

  /// Determine the next route based on app state
  /// 
  /// This method checks various conditions to decide where to navigate:
  /// 1. If user is authenticated → Home
  /// 2. If user completed onboarding → Login/Registration
  /// 3. If first time user → Onboarding
  void _determineNextRoute() {
    logger.debug('[LoadingScreen] Determining next route - API not connected, going to onboarding');
    
    // TODO: Remove this when API is connected
    // For now, always go to onboarding since API is not ready
    AppRouter.goToOnboarding(context);
    
    /* Original auth check logic - restore when API is ready:
    final authState = ref.read(authNotifierProvider);
    
    // Check authentication status
    if (authState.isAuthenticated) {
      logger.info('[LoadingScreen] User authenticated, going to home');
      AppRouter.goToHome(context);
    } else if (authState.status == AuthStatus.unauthenticated) {
      logger.info('[LoadingScreen] User not authenticated, going to onboarding');
      AppRouter.goToOnboarding(context);
    } else {
      // Still checking authentication, wait a bit more
      logger.debug('[LoadingScreen] Still checking authentication, waiting...');
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _determineNextRoute();
      });
    }
    */
  }

  @override
  void dispose() {
    for (var controller in _dotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure white background
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _dotAnimations[index],
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Transform.scale(
                    scale: 0.5 + (_dotAnimations[index].value * 0.5),
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: DesignTokens.primary950, // Dark green dots
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
