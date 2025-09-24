import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/design_tokens.dart';
import '../../core/utils/logger.dart';
import '../../routes/app_router.dart';
import 'profile_setup_screen.dart';

/// Success screen
///
/// This screen shows account creation success.
/// It features:
/// - Success icon from assets
/// - Account created confirmation
/// - Next steps instruction
/// - Continue button
/// - Space evenly layout

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initialize screen animations
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: DesignTokens.durationSlow,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: DesignTokens.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: DesignTokens.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Handle continue action
  Future<void> _handleContinue() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement setup navigation logic
      logger.info('[SuccessScreen] Navigating to setup');
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading

      // Navigate to profile setup screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSetupScreen(),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: ${e.toString()}'),
          backgroundColor: DesignTokens.error500,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DesignTokens.space6.w),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Success Icon
                      _buildSuccessIcon(),

                      // Title Group (Main Title + Subtitle together)
                      _buildTitleGroup(),

                      // Continue Button
                      _buildContinueButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Build success icon
  Widget _buildSuccessIcon() {
    return Center(
      child: Container(
        width: 120.w,
        height: 120.h,
        child: SvgPicture.asset(
          'assets/icons/success.svg', // You can replace with your success icon
          width: 120.w,
          height: 120.h,
          // colorFilter: ColorFilter.mode(
          //   DesignTokens.primary950,
          //   BlendMode.srcIn,
          // ),
        ),
      ),
    );
  }

  /// Build title group (main title + subtitle together)
  Widget _buildTitleGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Title
        Text(
          'Votre compte a été créé',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: DesignTokens.fontSize3xl.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
            height: DesignTokens.lineHeightTight,
          ),
        ),
        
        SizedBox(height: DesignTokens.space3.h), // Small gap between titles
        
        // Subtitle
        Text(
          'Veuillez configurer pour continuer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: DesignTokens.neutral550.withValues(alpha: 0.7),
            fontFamily: DesignTokens.fontFamilyPrimary,
            height: DesignTokens.lineHeightNormal,
          ),
        ),
      ],
    );
  }

  /// Build continue button
  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary950,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Continuer',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
      ),
    );
  }
}
