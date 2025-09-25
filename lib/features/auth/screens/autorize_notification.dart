import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import 'welcome_screen.dart';

/// Notifications authorization screen (Step 3)
///
/// This screen requests notification permission from the user.
/// It features:
/// - Header with back button
/// - Centered content with space evenly layout
/// - Progress indicator (step 3 of 3)
/// - Notification icon and explanation
/// - Authorize button

class AutorizeNotification extends StatefulWidget {
  const AutorizeNotification({super.key});

  @override
  State<AutorizeNotification> createState() => _AutorizeNotificationState();
}

class _AutorizeNotificationState extends State<AutorizeNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false;

  // Styling constants


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

  /// Handle notifications authorization
  Future<void> _handleNotificationsAuthorization() async {
    setState(() {
      _isLoading = true;
    });

    try {
      logger.info('[AutorizeNotification] Requesting notification permission');
      
      // TODO: Implement actual notification permission request
      await Future.delayed(const Duration(seconds: 1)); // Simulate permission request

      // Navigate to welcome screen - show free pass offer
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: DesignTokens.error500,
          ),
        );
      }
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              
              // Progress indicator
              _buildProgressIndicator(),
              
              SizedBox(height: 12.h),
              
              // Header with back button (positioned after stepper)
              _buildHeader(),
              
              // Main content with remaining space
              Expanded(
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
                            // Main content icon
                            _buildMainIcon(),

                            // Title Group
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
            ],
          ),
        ),
      ),
    );
  }

  /// Build header with back button
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignTokens.neutral500,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: DesignTokens.neutral900,
              size: 20.w,
            ),
          ),
        ),
      ],
    );
  }

  /// Build progress indicator
  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            height: 4.h,
            margin: EdgeInsets.only(right: index < 2 ? 8.w : 0),
            decoration: BoxDecoration(
              color: DesignTokens.primary950, // All steps active for final step
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }

  /// Build main icon
  Widget _buildMainIcon() {
    return Center(
      child: Container(
        width: 120.w,
        height: 120.h,
        child: SvgPicture.asset(
          'assets/icons/notif.svg', // You can replace with your success icon
          width:240.w,
          height: 240.h,
          // colorFilter: ColorFilter.mode(
          //   DesignTokens.primary950,
          //   BlendMode.srcIn,
          // ),
        ),
      ),
    );
  }

  /// Build title group
  Widget _buildTitleGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Title
        Text(
          'Restez informé des promotions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: DesignTokens.fontSize3xl.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
            height: DesignTokens.lineHeightTight,
          ),
        ),
        
        SizedBox(height: DesignTokens.space3.h),
        
        // Subtitle
        Text(
          'Ne ratez aucune promotion, activez la cloche pour en savoir plus',
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
        onPressed: _isLoading ? null : _handleNotificationsAuthorization,
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
                'Autoriser les notifications',
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