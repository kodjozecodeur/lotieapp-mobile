import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';
import '../../core/utils/logger.dart';
import '../../routes/app_router.dart';
import 'success_screen.dart';

/// OTP verification screen
///
/// This screen allows users to verify their phone number with OTP.
/// It features:
/// - Clean, modern OTP input design
/// - Masked phone number display
/// - Resend code functionality
/// - Apple-style UI components

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form controllers
  final List<TextEditingController> _otpControllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  // Form state
  bool _isLoading = false;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    
    // Auto-focus first field to show keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          FocusScope.of(context).requestFocus(_focusNodes[0]);
        }
      });
    });
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

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Mask phone number showing first 2 and last 2 digits
  String _getMaskedPhoneNumber() {
    if (widget.phoneNumber.length >= 4) {
      String first2 = widget.phoneNumber.substring(0, 2);
      String last2 = widget.phoneNumber.substring(
        widget.phoneNumber.length - 2,
      );
      return '$first2 ** ** $last2';
    }
    return widget.phoneNumber;
  }

  /// Handle OTP verification
  Future<void> _handleVerification() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual OTP verification logic
      logger.info('[OTPScreen] Verifying OTP: $_otp');
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to success screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(),
        ),
      );
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
    // TODO: Implement resend code logic
    logger.info('[OTPScreen] Resending code to: ${widget.phoneNumber}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code renvoyé avec succès'),
        backgroundColor: DesignTokens.primary950,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DesignTokens.space6.w),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      _buildHeader(),

                      SizedBox(height: DesignTokens.space8.h),

                      // OTP Form
                      _buildOTPForm(),

                      SizedBox(height: DesignTokens.space6.h),

                      // Resend Code Link
                      _buildResendCodeLink(),

                      SizedBox(height: DesignTokens.space8.h),

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

  /// Build header section
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignTokens.neutral500,
          ),
          child: IconButton(
            onPressed: () => AppRouter.goBack(context),
            icon: Icon(
              Icons.arrow_back,
              color: DesignTokens.neutral900,
              size: 20.w,
            ),
          ),
        ),

        SizedBox(height: DesignTokens.space2.h),

        // Title
        Text(
          'Code de vérification',
          style: TextStyle(
            fontSize: DesignTokens.fontSize2xl.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),

        SizedBox(height: DesignTokens.space2.h),

        // Subtitle with masked phone number
        Text.rich(
          TextSpan(
            text: "Nous venon d'envoyer un code de vérification au ",
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              color: DesignTokens.neutral550.withValues(alpha: 0.7),
              fontFamily: DesignTokens.fontFamilyPrimary,
              fontWeight: DesignTokens.fontWeightLight,
            ),
            children: [
              TextSpan(
                text: _getMaskedPhoneNumber(),
                style: TextStyle(
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  color: DesignTokens.neutral900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build OTP form
  Widget _buildOTPForm() {
    return Column(
      children: [
        // OTP Input Fields
        _buildOTPFields(),
      ],
    );
  }

  /// Build OTP input fields (5 fields)
  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return Container(
          width: 56.w,
          height: 56.h,
          child: TextFormField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 1,
            autofocus: index == 0, // Auto-focus first field
            obscureText: true, // Hide OTP values with dots
            enableInteractiveSelection: false,
            showCursor: true,
            style: TextStyle(
              fontFamily: DesignTokens.fontFamilyPrimary,
              fontSize: DesignTokens.fontSize2xl.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.neutral900,
            ),
            decoration: InputDecoration(
              counterText: '', // Hide counter
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: DesignTokens.neutral300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: DesignTokens.neutral300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: DesignTokens.primary950,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: DesignTokens.error500),
              ),
              filled: true,
              fillColor: DesignTokens.neutral100,
              contentPadding: EdgeInsets.zero,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onTap: () {
              // Force focus on tap
              _focusNodes[index].requestFocus();
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Move to next field
                if (index < 4) {
                  _focusNodes[index + 1].requestFocus();
                }
              } else {
                // Move to previous field
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
              
              // Update OTP string
              _updateOTP();
            },
          ),
        );
      }),
    );
  }

  /// Update OTP string from controllers
  void _updateOTP() {
    setState(() {
      _otp = _otpControllers.map((controller) => controller.text).join();
    });
  }

  /// Build resend code link
  Widget _buildResendCodeLink() {
    return Center(
      child: GestureDetector(
        onTap: _handleResendCode,
        child: Text.rich(
          TextSpan(
            text: "Vous n'avez pas reçu de code? ",
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral550.withValues(alpha: 0.7),
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
           children: [
            TextSpan(text: "Renvoyer", style: TextStyle(fontWeight: DesignTokens.fontWeightSemiBold, color: DesignTokens.primary950)),
          ],
          ),
         
        ),
      ),
    );
  }

  /// Build continue button
  Widget _buildContinueButton() {
    // Check if OTP is complete
    bool isOTPComplete = _otp.length == 5;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: (_isLoading || !isOTPComplete) ? null : _handleVerification,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOTPComplete
              ? DesignTokens.primary950
              : DesignTokens.neutral400,
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
