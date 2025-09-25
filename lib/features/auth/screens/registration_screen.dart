import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import '../../../routes/app_router.dart';
import 'otp_screen.dart';

/// Registration screen
///
/// This screen allows new users to create an account.
/// It features:
/// - Clean, modern form design
/// - Input validation
/// - Smooth animations
/// - Apple-style UI components

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  // Form state
  bool _acceptCGU = false;
  bool _isLoading = false;
  String _phoneNumber = '';
  String _countryCode = '228'; // Togo country code

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
    _phoneController.dispose();
    super.dispose();
  }

  /// Handle form submission
  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptCGU) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez accepter les CGU'),
          backgroundColor: DesignTokens.error500,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual registration logic with phone number
      logger.info('[RegistrationScreen] Phone: $_countryCode $_phoneNumber');
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to OTP screen with phone number
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(
            phoneNumber: '$_countryCode$_phoneNumber',
          ),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: DesignTokens.error500,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Navigate to login screen
  void _goToLogin() {
    AppRouter.goToLogin(context);
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

                      // Registration Form
                      _buildRegistrationForm(),

                      SizedBox(height: DesignTokens.space6.h),

                      // Login Link
                      // _buildLoginLink(),
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
          'Bienvenue sur Lotie 👋',
          style: TextStyle(
            fontSize: DesignTokens.fontSize2xl.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral850,
            // letterSpacing: DesignTokens.letterSpacingTight,
          ),
        ),

        SizedBox(height: DesignTokens.space2.h),

        // Subtitle
        Text(
          'Entrez votre numéro de téléphone pour commencer',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: Color(0xB3181727),
          ),
        ),
      ],
    );
  }

  /// Build registration form
  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Phone Number Field with Country Selector
          _buildPhoneField(),

          SizedBox(height: DesignTokens.space6.h),

          // CGU Checkbox
          _buildCGUCheckbox(),

          SizedBox(height: DesignTokens.space8.h),

          // Register Button
          _buildRegisterButton(),
        ],
      ),
    );
  }

  /// Build phone number field with country selector
  Widget _buildPhoneField() {
    return Row(
      children: [
        // Country Selector Field
        Expanded(
          flex: 2,
          child: _buildCountryField(),
        ),
        
        SizedBox(width: 12.w), // Space between the two fields
        
        // Phone Number Field
        Expanded(
          flex: 4,
          child: _buildNumberField(),
        ),
      ],
    );
  }

  /// Build country selector field (flag only)
  Widget _buildCountryField() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: DesignTokens.neutral100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: DesignTokens.neutral300,
          width: 1,
        ),
      ),
      child: IntlPhoneField(
        showCountryFlag: true,
        disableLengthCheck: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        style: TextStyle(
          fontFamily: DesignTokens.fontFamilyPrimary,
          fontSize: DesignTokens.fontSizeBase.sp,
          color: DesignTokens.neutral900,
        ),
        dropdownTextStyle: TextStyle(
          fontFamily: DesignTokens.fontFamilyPrimary,
          fontSize: DesignTokens.fontSizeSm.sp,
          color: DesignTokens.neutral900,
        ),
        initialCountryCode: 'TG',
        showDropdownIcon: true,
        dropdownIcon: Icon(
          Icons.keyboard_arrow_down,
          color: DesignTokens.neutral600,
          size: 16.w,
        ),
        searchText: 'Rechercher un pays',
        invalidNumberMessage: 'Numéro de téléphone invalide',
        onChanged: (phone) {
          setState(() {
            _countryCode = phone.countryCode;
          });
        },
        validator: null,
      ),
    );
  }

  /// Build phone number input field (with country code)
  Widget _buildNumberField() {
    return Container(
      height: 50.h, // Match the height of country field
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        style: TextStyle(
          fontFamily: DesignTokens.fontFamilyPrimary,
          fontSize: DesignTokens.fontSizeBase.sp,
          color: DesignTokens.neutral900,
          fontWeight: DesignTokens.fontWeightRegular,
        ),
        decoration: InputDecoration(
          hintText: '00-00-00-00',
          hintStyle: TextStyle(
            color: DesignTokens.neutral400,
            fontSize: DesignTokens.fontSizeBase.sp,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
          prefixText: '+${_countryCode.isNotEmpty ? _countryCode : "228"} ',
          prefixStyle: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontSize: DesignTokens.fontSizeBase.sp,
            color: DesignTokens.neutral900,
            fontWeight: DesignTokens.fontWeightRegular,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: DesignTokens.neutral300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: DesignTokens.neutral300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: DesignTokens.primary500, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: DesignTokens.error500),
          ),
          filled: true,
          fillColor: DesignTokens.neutral100,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre numéro de téléphone';
              }
          if (value.length < 8) {
            return 'Numéro de téléphone trop court';
              }
              return null;
            },
        onChanged: (value) {
          setState(() {
            _phoneNumber = value;
          });
        },
      ),
    );
  }

  /// Build CGU checkbox
  Widget _buildCGUCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0), // Match page padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.2, // Make checkbox bigger
            child: Checkbox(
              value: _acceptCGU,
              onChanged: (value) {
                setState(() {
                  _acceptCGU = value ?? false;
                });
              },
              activeColor: DesignTokens.primary950,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(
                color: DesignTokens.neutral300,
                width: 1.0, // Thinner border
              ),
            ),
          ),
        Expanded(
          child: GestureDetector(
            onTap: () {
                setState(() {
                _acceptCGU = !_acceptCGU;
                });
              },
            child: Text.rich(
              TextSpan(
                text: "En continuant, vous acceptez nos ",
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXs.sp,
                  color: DesignTokens.neutral550.withValues(alpha: 0.7),
                  fontFamily: DesignTokens.fontFamilyPrimary,
                  fontWeight: DesignTokens.fontWeightLight
                ),
                children: [
                  TextSpan(
                    text: 'Termes & Conditions ',
                    style: TextStyle(
                      color: DesignTokens.primary950,
                      fontWeight: DesignTokens.fontWeightSemiBold,
                      
                    ),
                  ),
                  TextSpan(
                    text: 'et notre ',
                    style: TextStyle(
                      color: DesignTokens.neutral550.withValues(alpha: 0.7),
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  TextSpan(
                    text: ' Politique de confidentialité',
                    style: TextStyle(
                      color: DesignTokens.primary950,
                      fontWeight: DesignTokens.fontWeightSemiBold,
                      
                    ),
                  ),  
                ],
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }

  /// Build register button
  Widget _buildRegisterButton() {
    // Check if form is complete
    bool isFormComplete = _phoneNumber.isNotEmpty && 
                         _phoneNumber.length >= 8 && 
                         _acceptCGU;
    
    return SizedBox(
            width: double.infinity,
        height: 56.h,
            child: ElevatedButton(
               onPressed: (_isLoading || !isFormComplete) ? null : _handleRegistration,
              style: ElevatedButton.styleFrom(
          backgroundColor: isFormComplete ? DesignTokens.primary950 : DesignTokens.neutral400, // Use same green as onboarding
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continuer',
                      style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: DesignTokens.fontWeightMedium,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  
                ],
              ),
      ),
    );
  }


  /// Build login link
  // Widget _buildLoginLink() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         'Already have an account? ',
  //         style: TextStyle(
  //           fontSize: DesignTokens.fontSizeBase.sp,
  //           color: DesignTokens.neutral600,
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: _goToLogin,
  //         child: Text(
  //           'Sign In',
  //           style: TextStyle(
  //             fontSize: DesignTokens.fontSizeBase.sp,
  //             fontWeight: DesignTokens.fontWeightSemiBold,
  //             color: DesignTokens.primary500,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
