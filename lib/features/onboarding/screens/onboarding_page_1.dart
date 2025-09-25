import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';

/// First onboarding page
/// 
/// This page introduces the app and its main purpose.
/// It follows Apple's Human Interface Guidelines with:
/// - Clear, concise messaging
/// - High-quality visuals
/// - Smooth animations
/// - Accessible design

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initialize page animations
  /// 
  /// Creates smooth fade-in and slide animations for the content
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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.space6.w),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main Illustration
                  Container(
                    width: 280.w,
                    height: 280.w,
                    decoration: BoxDecoration(
                      color: DesignTokens.primary50,
                      borderRadius: BorderRadius.circular(DesignTokens.radius3xl.r),
                      boxShadow: DesignTokens.shadowLg,
                    ),
                    child: Icon(
                      Icons.rocket_launch,
                      size: 120.w,
                      color: DesignTokens.primary500,
                    ),
                  ),
                  
                  SizedBox(height: DesignTokens.space8.h),
                  
                  // Main Title
                  Text(
                    'Welcome to Lotie',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSize4xl.sp,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: DesignTokens.neutral900,
                      letterSpacing: DesignTokens.letterSpacingTight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: DesignTokens.space4.h),
                  
                  // Subtitle
                  Text(
                    'Your journey to success starts here. Discover amazing features and unlock your potential.',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral600,
                      height: DesignTokens.lineHeightRelaxed,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: DesignTokens.space8.h),
                  
                  // Feature Highlights
                  _buildFeatureHighlight(
                    icon: Icons.speed,
                    title: 'Fast & Reliable',
                    description: 'Lightning-fast performance',
                  ),
                  
                  SizedBox(height: DesignTokens.space4.h),
                  
                  _buildFeatureHighlight(
                    icon: Icons.security,
                    title: 'Secure & Private',
                    description: 'Your data is always protected',
                  ),
                  
                  SizedBox(height: DesignTokens.space4.h),
                  
                  _buildFeatureHighlight(
                    icon: Icons.palette,
                    title: 'Beautiful Design',
                    description: 'Sleek and modern interface',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build feature highlight item
  /// 
  /// Creates a consistent feature highlight with icon, title, and description
  Widget _buildFeatureHighlight({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: DesignTokens.primary100,
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
          ),
          child: Icon(
            icon,
            size: 20.w,
            color: DesignTokens.primary500,
          ),
        ),
        
        SizedBox(width: DesignTokens.space4.w),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  color: DesignTokens.neutral900,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm.sp,
                  fontWeight: DesignTokens.fontWeightRegular,
                  color: DesignTokens.neutral600,
                ),
              ),
            ],
          ),

        ),
      ],
    );
  }
}
