import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import '../../../routes/app_router.dart';
import 'simple_otp_screen.dart';

/// Simple Login screen - Phone number → OTP → Home
///
/// This screen allows existing users to sign in with just their phone number.
/// It features:
/// - Clean, modern phone input design
/// - Country code selector
/// - Apple-style UI components
/// - Direct flow: Phone → OTP → Home

class SimpleLoginScreen extends StatefulWidget {
  const SimpleLoginScreen({super.key});

  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _countryCode = '+33';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /// Handle simple login action
  Future<void> _handleSimpleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simple login flow: just go to OTP screen
      logger.info('[SimpleLoginScreen] Phone: $_countryCode ${_phoneController.text}');
      await Future.delayed(const Duration(seconds: 1)); // Simulate sending OTP

      // Navigate to simple OTP screen with phone number
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimpleOTPScreen(
            phoneNumber: '$_countryCode${_phoneController.text}',
          ),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: DesignTokens.error500,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Navigate to registration screen
  void _goToRegistration() {
    AppRouter.goToRegistration(context);
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
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(DesignTokens.space6.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        SizedBox(height: DesignTokens.space10.h),
                        _buildPhoneForm(),
                        SizedBox(height: DesignTokens.space8.h),
                        _buildLoginButton(),
                        SizedBox(height: DesignTokens.space6.h),
                        _buildRegistrationLink(),
                      ],
                    ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connexion rapide',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        SizedBox(height: DesignTokens.space3.h),
        Text(
          'Entrez votre numéro de téléphone pour vous connecter',
          style: TextStyle(
            fontSize: 16.sp,
            color: DesignTokens.neutral650,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
        ),
      ],
    );
  }

  /// Build phone number form
  Widget _buildPhoneForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Numéro de téléphone',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral900,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
        ),
        SizedBox(height: DesignTokens.space2.h),
        Row(
          children: [
            // Country code selector
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesignTokens.space3.w,
                vertical: DesignTokens.space3.h,
              ),
              decoration: BoxDecoration(
                  color: DesignTokens.neutral100,
                borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                border: Border.all(
                  color: DesignTokens.neutral300,
                  width: 1.w,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _countryCode,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: DesignTokens.neutral650,
                    size: 20.sp,
                  ),
                  items: [
                    DropdownMenuItem(value: '+33', child: Text('+33')),
                    DropdownMenuItem(value: '+1', child: Text('+1')),
                    DropdownMenuItem(value: '+44', child: Text('+44')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _countryCode = value;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: DesignTokens.space3.w),
            // Phone number input
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: '06 12 34 56 78',
                  hintStyle: TextStyle(
                    color: DesignTokens.neutral400,
                    fontSize: 16.sp,
                    fontFamily: DesignTokens.fontFamilySecondary,
                  ),
                  filled: true,
                  fillColor: DesignTokens.neutral100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                    borderSide: BorderSide(
                      color: DesignTokens.neutral300,
                      width: 1.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                    borderSide: BorderSide(
                      color: DesignTokens.neutral300,
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                    borderSide: BorderSide(
                      color: DesignTokens.primary500,
                      width: 2.w,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.space4.w,
                    vertical: DesignTokens.space3.h,
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: DesignTokens.neutral900,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  if (value.length < 10) {
                    return 'Le numéro doit contenir 10 chiffres';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSimpleLogin,
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
                'Se connecter',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
              ),
      ),
    );
  }

  /// Build registration link
  Widget _buildRegistrationLink() {
    return Center(
      child: TextButton(
        onPressed: _goToRegistration,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.space4.w,
            vertical: DesignTokens.space2.h,
          ),
        ),
        child: RichText(
          text: TextSpan(
            text: 'Pas encore de compte ? ',
            style: TextStyle(
              fontSize: 14.sp,
              color: DesignTokens.neutral650,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
            children: [
              TextSpan(
                text: 'S\'inscrire',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: DesignTokens.primary950,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
