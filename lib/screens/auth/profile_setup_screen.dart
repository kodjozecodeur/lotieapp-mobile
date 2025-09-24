import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';
import '../../core/utils/logger.dart';
import '../../routes/app_router.dart';
import 'autorize_location.dart';

/// Profile setup screen
///
/// This screen allows users to configure their profile.
/// It features:
/// - Progress indicator
/// - Profile avatar with add photo option
/// - Form fields for user information
/// - Password requirements checklist
/// - Skip/Continue buttons

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form state
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  List<bool> _passwordRequirements = [false, false, false, false];

  // Styling constants


  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePasswordMatch);
  }

  /// Validate password match when confirm password changes
  void _validatePasswordMatch() {
    // Trigger validation for confirm password field
    if (_confirmPasswordController.text.isNotEmpty) {
      _formKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validate password requirements
  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _passwordRequirements[0] = password.length >= 8; // At least 8 characters
      _passwordRequirements[1] = password.contains(RegExp(r'[0-9]')); // At least 1 digit
      _passwordRequirements[2] = password.contains(RegExp(r'[A-Z]')); // At least 1 uppercase
      _passwordRequirements[3] = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')); // At least 1 symbol
    });
  }

  /// Check if passwords match
  bool _doPasswordsMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }

  /// Validate password confirmation
  String? _validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (!_doPasswordsMatch()) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  /// Handle skip action
  void _handleSkip() {
    logger.info('[ProfileSetupScreen] Skipping profile setup');
    AppRouter.goToHome(context);
  }

  /// Handle continue action
  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      logger.info('[ProfileSetupScreen] Profile setup completed, moving to step 2');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AutorizeLocationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                
                // Progress indicator
                _buildProgressIndicator(),
                
                SizedBox(height: 16.h),
                
                // Main title
                _buildMainTitle(),
                
                SizedBox(height: 16.h),
                
                // Subtitle
                _buildSubtitle(),
                
                SizedBox(height: 16.h),
                
                // Profile avatar
                _buildProfileAvatar(),
                
                SizedBox(height: 16.h),
                
                // Form fields
                _buildFormFields(),
                
                SizedBox(height: 16.h),
                
                // Password requirements
                _buildPasswordRequirements(),
                
                SizedBox(height: 16.h),
                
                // Bottom buttons
                _buildBottomButtons(),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
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
              color: index == 0 ? DesignTokens.primary950 : DesignTokens.neutral550.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }

  /// Build main title
  Widget _buildMainTitle() {
    return Text(
      'Configurer votre profil',
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: DesignTokens.neutral850,
        fontFamily: DesignTokens.fontFamilyPrimary,
      ),
    );
  }

  /// Build subtitle
  Widget _buildSubtitle() {
    return Text(
      'Remplissez les informations pour créer un profil',
      style: TextStyle(
        fontSize: 16.sp,
        color: DesignTokens.neutral650,
        fontFamily: DesignTokens.fontFamilyPrimary,
      ),
    );
  }

  /// Build profile avatar
  Widget _buildProfileAvatar() {
    return Center(
      child: Stack(
        children: [
          // Avatar container
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DesignTokens.neutral650.withValues(alpha: 0.5),
            ),
            child: Icon(
              Icons.person,
              size: 60.w,
              color: Colors.white,
            ),
          ),
          // Add photo button
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DesignTokens.primary950,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build form fields
  Widget _buildFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Full Name
          _buildTextField(
            controller: _fullNameController,
            label: 'Nom complet',
            hint: 'Ex : Donal Trump',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom complet';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Email
          _buildTextField(
            controller: _emailController,
            label: 'Adresse e-mail',
            hint: 'Ex : donald@gmail.com',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre adresse e-mail';
              }
              if (!value.contains('@')) {
                return 'Veuillez entrer une adresse e-mail valide';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Password
          _buildTextField(
            controller: _passwordController,
            label: 'Mot de passe',
            hint: 'Mot de passe',
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: DesignTokens.neutral650,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // Confirm Password
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirmer le mot de passe',
            hint: 'Confirmer votre mot de passe',
            obscureText: !_isConfirmPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: DesignTokens.neutral650,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            validator: _validatePasswordConfirmation,
          ),
        ],
      ),
    );
  }

  /// Build text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: DesignTokens.neutral650,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: DesignTokens.neutral500,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: DesignTokens.primary950, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }

  /// Build password requirements
  Widget _buildPasswordRequirements() {
    final requirements = [
      'Au moins 8 caractères',
      'Au moins 1 chiffre',
      'Au moins 1 majuscule',
      'Au moins 1 symbole',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        // crossAxisSpacing: 8.w,
        // mainAxisSpacing: 8.h,
      ),
      itemCount: requirements.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _passwordRequirements[index] ? DesignTokens.primary950 : DesignTokens.neutral650.withValues(alpha: 0.3),
              ),
              child: _passwordRequirements[index]
                  ? Icon(
                      Icons.check,
                      size: 12.w,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                requirements[index],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: _passwordRequirements[index] ? DesignTokens.primary950 : DesignTokens.neutral650,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build bottom buttons
  Widget _buildBottomButtons() {
    return Row(
      children: [
        // Skip button
        Expanded(
          child: Container(
            height: 50.h,
            child: OutlinedButton(
              onPressed: _handleSkip,
              style: OutlinedButton.styleFrom(
                backgroundColor: DesignTokens.neutral500,
                side: BorderSide(color: DesignTokens.neutral500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Passer',
                style: TextStyle(
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                ),
              ),
            ),
          ),
        ),
        
        SizedBox(width: 16.w),
        
        // Continue button
        Expanded(
          child: Container(
            height: 50.h,
            child: ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.primary950,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continuer',
                style: TextStyle(
                  fontFamily: DesignTokens.fontFamilyPrimary,
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
