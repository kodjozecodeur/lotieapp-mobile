import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';

/// Third onboarding page
/// 
/// This is the final onboarding page that encourages users
/// to get started and highlights the value proposition.
/// It creates excitement and motivation to continue.

class OnboardingPage3 extends StatefulWidget {
  const OnboardingPage3({super.key});

  @override
  State<OnboardingPage3> createState() => _OnboardingPage3State();
}

class _OnboardingPage3State extends State<OnboardingPage3>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

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

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOutBack,
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
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main Illustration
                    Container(
                      width: 280.w,
                      height: 280.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            DesignTokens.primary500,
                            DesignTokens.secondary500,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(DesignTokens.radius3xl.r),
                        boxShadow: DesignTokens.shadowXl,
                      ),
                      child: Icon(
                        Icons.celebration,
                        size: 120.w,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: DesignTokens.space8.h),
                    
                    // Main Title
                    Text(
                      'Ready to Start?',
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
                      'Join thousands of users who are already achieving their goals. Your success story starts now!',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeLg.sp,
                        fontWeight: DesignTokens.fontWeightRegular,
                        color: DesignTokens.neutral600,
                        height: DesignTokens.lineHeightRelaxed,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: DesignTokens.space8.h),
                    
                    // Benefits List
                    _buildBenefitItem(
                      icon: Icons.check_circle,
                      text: 'Free to get started',
                      color: DesignTokens.success500,
                    ),
                    
                    SizedBox(height: DesignTokens.space3.h),
                    
                    _buildBenefitItem(
                      icon: Icons.check_circle,
                      text: 'No hidden fees',
                      color: DesignTokens.success500,
                    ),
                    
                    SizedBox(height: DesignTokens.space3.h),
                    
                    _buildBenefitItem(
                      icon: Icons.check_circle,
                      text: '24/7 support available',
                      color: DesignTokens.success500,
                    ),
                    
                    SizedBox(height: DesignTokens.space8.h),
                    
                    // Call to Action
                    Container(
                      padding: EdgeInsets.all(DesignTokens.space4.w),
                      decoration: BoxDecoration(
                        color: DesignTokens.primary50,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
                        border: Border.all(
                          color: DesignTokens.primary200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: DesignTokens.primary500,
                            size: 20.w,
                          ),
                          SizedBox(width: DesignTokens.space2.w),
                          Expanded(
                            child: Text(
                              'Join over 10,000+ satisfied users',
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeSm.sp,
                                fontWeight: DesignTokens.fontWeightMedium,
                                color: DesignTokens.primary700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build benefit item
  /// 
  /// Creates a benefit item with checkmark icon and text
  Widget _buildBenefitItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.w,
          color: color,
        ),
        SizedBox(width: DesignTokens.space3.w),
        Text(
          text,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral700,
          ),
        ),
      ],
    );
  }
}
