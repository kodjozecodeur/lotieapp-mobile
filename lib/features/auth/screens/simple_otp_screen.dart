import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import '../../../routes/app_router.dart';
import '../../../services/storage_service.dart';

/// Simple OTP verification screen - goes directly to home
///
/// This screen allows users to verify their phone number with OTP.
/// After verification, it goes directly to home instead of profile setup.
/// It features:
/// - Clean, modern OTP input design
/// - Masked phone number display
/// - Resend code functionality
/// - Direct to home flow

class SimpleOTPScreen extends StatefulWidget {
  final String phoneNumber;

  const SimpleOTPScreen({super.key, required this.phoneNumber});

  @override
  State<SimpleOTPScreen> createState() => _SimpleOTPScreenState();
}

class _SimpleOTPScreenState extends State<SimpleOTPScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  
  String _otp = '';
  bool _isLoading = false;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startResendCountdown();
  }

  /// Initialize animations
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: DesignTokens.durationNormal,
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

  /// Start resend countdown
  void _startResendCountdown() {
    setState(() {
      _resendCountdown = 60;
    });
    
    _countdownTimer();
  }

  void _countdownTimer() {
    if (_resendCountdown > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _resendCountdown--;
          });
          _countdownTimer();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Handle OTP verification - goes directly to home
  Future<void> _handleVerification() async {
    _otp = _otpControllers.map((controller) => controller.text).join();
    
    if (_otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez entrer le code à 6 chiffres'),
          backgroundColor: DesignTokens.error500,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual OTP verification logic
      logger.info('[SimpleOTPScreen] Verifying OTP: $_otp');
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mark both onboarding and login as completed
      await StorageService.markOnboardingCompleted();
      await StorageService.markLoginCompleted();
      logger.info('[SimpleOTPScreen] Onboarding and login marked as completed');

      // Navigate directly to home after OTP verification
      logger.info('[SimpleOTPScreen] OTP verified successfully, going to home');
      AppRouter.goToHome(context);
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vérification échouée: ${e.toString()}'),
          backgroundColor: DesignTokens.error500,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Handle resend code
  Future<void> _handleResendCode() async {
    if (_resendCountdown > 0) return;

    try {
      // TODO: Implement actual resend logic
      logger.info('[SimpleOTPScreen] Resending OTP to ${widget.phoneNumber}');
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      _startResendCountdown();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Code envoyé !'),
          backgroundColor: DesignTokens.success500,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi: ${e.toString()}'),
          backgroundColor: DesignTokens.error500,
        ),
      );
    }
  }

  /// Mask phone number for display
  String get _maskedPhoneNumber {
    final phone = widget.phoneNumber;
    if (phone.length >= 4) {
      return '${phone.substring(0, phone.length - 4)}${'*' * 4}';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: DesignTokens.neutral900,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(DesignTokens.space6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: DesignTokens.space8.h),
                      _buildHeader(),
                      SizedBox(height: DesignTokens.space10.h),
                      _buildOTPInputs(),
                      SizedBox(height: DesignTokens.space8.h),
                      _buildVerifyButton(),
                      SizedBox(height: DesignTokens.space6.h),
                      _buildResendSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build header section
  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Vérification',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: DesignTokens.space4.h),
        Text(
          'Entrez le code à 6 chiffres envoyé au',
          style: TextStyle(
            fontSize: 16.sp,
            color: DesignTokens.neutral650,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: DesignTokens.space1.h),
        Text(
          _maskedPhoneNumber,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral900,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Build OTP input fields
  Widget _buildOTPInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 45.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: DesignTokens.neutral100,
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
            border: Border.all(
              color: _otpControllers[index].text.isNotEmpty
                  ? DesignTokens.primary500
                  : DesignTokens.neutral300,
              width: 1.5.w,
            ),
          ),
          child: TextFormField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
            onChanged: (value) {
              setState(() {});
              
              if (value.isNotEmpty && index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
              
              // Auto-verify when all fields are filled
              if (index == 5 && value.isNotEmpty) {
                final otp = _otpControllers.map((controller) => controller.text).join();
                if (otp.length == 6) {
                  _handleVerification();
                }
              }
            },
          ),
        );
      }),
    );
  }

  /// Build verify button
  Widget _buildVerifyButton() {
    final isComplete = _otpControllers.every((controller) => controller.text.isNotEmpty);
    
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: (_isLoading || !isComplete) ? null : _handleVerification,
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary950,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Vérifier',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
              ),
      ),
    );
  }

  /// Build resend section
  Widget _buildResendSection() {
    return Column(
      children: [
        Text(
          'Vous n\'avez pas reçu le code ?',
          style: TextStyle(
            fontSize: 14.sp,
            color: DesignTokens.neutral650,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
        ),
        SizedBox(height: DesignTokens.space2.h),
        TextButton(
          onPressed: _resendCountdown > 0 ? null : _handleResendCode,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: DesignTokens.space4.w,
              vertical: DesignTokens.space2.h,
            ),
          ),
          child: Text(
            _resendCountdown > 0
                ? 'Renvoyer dans ${_resendCountdown}s'
                : 'Renvoyer le code',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: _resendCountdown > 0
                  ? DesignTokens.neutral400
                  : DesignTokens.primary950,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
          ),
        ),
      ],
    );
  }
}
