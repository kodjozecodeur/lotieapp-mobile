import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';
import '../../core/utils/logger.dart';
import '../../routes/app_router.dart';
import '../../providers/auth_notifier.dart';

/// Login screen
/// 
/// This screen allows existing users to sign in to their account.
/// It features:
/// - Clean, modern form design
/// - Input validation
/// - Smooth animations
/// - Apple-style UI components

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Form state
  bool _isPasswordVisible = false;
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

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle form submission
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      logger.info('[LoginScreen] Attempting login');
      
      final success = await ref.read(authNotifierProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (success) {
        logger.info('[LoginScreen] Login successful, navigating to home');
        AppRouter.goToHome(context);
      } else {
        // Error message will be shown from auth state
        final authState = ref.read(authNotifierProvider);
        if (authState.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.errorMessage!),
              backgroundColor: DesignTokens.error500,
            ),
          );
        }
      }
    } catch (e) {
      logger.error('[LoginScreen] Login error', e);
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
                      
                      // Login Form
                      _buildLoginForm(),
                      
                      SizedBox(height: DesignTokens.space6.h),
                      
                      // Registration Link
                      _buildRegistrationLink(),
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
        IconButton(
          onPressed: () => AppRouter.goBack(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: DesignTokens.neutral700,
            size: 20.w,
          ),
        ),
        
        SizedBox(height: DesignTokens.space4.h),
        
        // Title
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: DesignTokens.fontSize4xl.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
            letterSpacing: DesignTokens.letterSpacingTight,
          ),
        ),
        
        SizedBox(height: DesignTokens.space2.h),
        
        // Subtitle
        Text(
          'Sign in to continue your journey',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: DesignTokens.neutral600,
          ),
        ),
      ],
    );
  }

  /// Build login form
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          _buildTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          
          SizedBox(height: DesignTokens.space4.h),
          
          // Password Field
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            icon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: DesignTokens.neutral500,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          
          SizedBox(height: DesignTokens.space4.h),
          
          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement forgot password
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Forgot password feature coming soon'),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: DesignTokens.primary500,
                ),
              ),
            ),
          ),
          
          SizedBox(height: DesignTokens.space8.h),
          
          // Login Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.primary500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
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
                      'Sign In',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase.sp,
                        fontWeight: DesignTokens.fontWeightSemiBold,
                      ),
                    ),
            ),
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
    required IconData icon,
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
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral700,
          ),
        ),
        SizedBox(height: DesignTokens.space2.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: DesignTokens.neutral500),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
              borderSide: BorderSide(color: DesignTokens.neutral300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
              borderSide: BorderSide(color: DesignTokens.neutral300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
              borderSide: BorderSide(color: DesignTokens.primary500, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
              borderSide: BorderSide(color: DesignTokens.error500),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: DesignTokens.space4.w,
              vertical: DesignTokens.space3.h,
            ),
          ),
        ),
      ],
    );
  }

  /// Build registration link
  Widget _buildRegistrationLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            color: DesignTokens.neutral600,
          ),
        ),
        GestureDetector(
          onTap: _goToRegistration,
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.primary500,
            ),
          ),
        ),
      ],
    );
  }
}
