import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';

/// Second onboarding page
/// 
/// This page showcases the app's key features and benefits.
/// It uses engaging visuals and clear messaging to highlight
/// what makes the app special.

class OnboardingPage2 extends StatefulWidget {
  const OnboardingPage2({super.key});

  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2>
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
                      color: DesignTokens.secondary50,
                      borderRadius: BorderRadius.circular(DesignTokens.radius3xl.r),
                      boxShadow: DesignTokens.shadowLg,
                    ),
                    child: Icon(
                      Icons.insights,
                      size: 120.w,
                      color: DesignTokens.secondary500,
                    ),
                  ),
                  
                  SizedBox(height: DesignTokens.space8.h),
                  
                  // Main Title
                  Text(
                    'Powerful Features',
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
                    'Discover tools and features designed to help you achieve your goals faster and more efficiently.',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral600,
                      height: DesignTokens.lineHeightRelaxed,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: DesignTokens.space8.h),
                  
                  // Feature Cards
                  _buildFeatureCard(
                    icon: Icons.analytics,
                    title: 'Smart Analytics',
                    description: 'Get insights into your progress with detailed analytics and reports.',
                    color: DesignTokens.primary500,
                  ),
                  
                  SizedBox(height: DesignTokens.space4.h),
                  
                  _buildFeatureCard(
                    icon: Icons.notifications,
                    title: 'Smart Notifications',
                    description: 'Stay on track with intelligent reminders and updates.',
                    color: DesignTokens.secondary500,
                  ),
                  
                  SizedBox(height: DesignTokens.space4.h),
                  
                  _buildFeatureCard(
                    icon: Icons.sync,
                    title: 'Sync Everywhere',
                    description: 'Access your data from any device, anywhere, anytime.',
                    color: DesignTokens.success500,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build feature card
  /// 
  /// Creates an attractive feature card with icon, title, and description
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
        boxShadow: DesignTokens.shadowBase,
        border: Border.all(
          color: DesignTokens.neutral200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
            ),
            child: Icon(
              icon,
              size: 24.w,
              color: color,
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
                SizedBox(height: DesignTokens.space1.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm.sp,
                    fontWeight: DesignTokens.fontWeightRegular,
                    color: DesignTokens.neutral600,
                    height: DesignTokens.lineHeightNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
