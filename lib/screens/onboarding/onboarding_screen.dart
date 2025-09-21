import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/design_tokens.dart';
import '../../routes/app_router.dart';
import '../../core/utils/logger.dart';

/// Onboarding data model
class OnboardingData {
  final String title;
  final String subtitle;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

/// Main onboarding screen container
/// 
/// This screen manages the onboarding flow with:
/// - PageView for swipeable onboarding pages
/// - Page indicator dots
/// - Navigation buttons (Next/Previous/Skip)
/// - Smooth page transitions
/// - State management for current page

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  int _currentPage = 0;
  Timer? _autoSlideTimer;
  late AnimationController _fadeController;
  late AnimationController _loadingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _loadingAnimation;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "Vos marchands préférés à portée de main",
      subtitle: "Découvrez une large sélection des marchands locaux,\nlivrés directement chez vous.",
      icon: Icons.shopping_cart,
    ),
    OnboardingData(
      title: "Commandez et faites-vous\nlivrer en un clic.",
      subtitle: "Découvrez une large sélection des marchands locaux,\nlivrés directement chez vous.",
      icon: Icons.local_shipping,
    ),
    OnboardingData(
      title: "Suivez votre commande\nà chaque étape.",
      subtitle: "Restez informé avec un suivi en temps réel, pour savoir\nexactement quand votre colis arrivera.",
      icon: Icons.location_on,
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _loadingController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    
    // Initialize animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _fadeController.forward();
    _loadingController.repeat();
    
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _fadeController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  /// Start automatic slide timer with smooth animations
  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _nextPage();
      } else {
        // Reset to first page when reaching the end
        setState(() {
          _currentPage = 0;
        });
        _restartAnimations();
      }
    });
  }

  /// Complete onboarding flow
  /// 
  /// Marks onboarding as completed and navigates to registration
  void _completeOnboarding() {
    // TODO: Complete onboarding when provider is migrated
    logger.info('[OnboardingScreen] Onboarding completed');
    AppRouter.goToRegistration(context);
  }

  /// Navigate to next page
  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      setState(() {
        _currentPage++;
      });
      _restartAnimations();
      HapticFeedback.lightImpact();
    }
  }

  /// Navigate to previous page
  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _restartAnimations();
      HapticFeedback.lightImpact();
    }
  }

  /// Restart animations for new page
  void _restartAnimations() {
    _fadeController.reset();
    _loadingController.reset();
    _fadeController.forward();
    _loadingController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
          children: [
          // Background Image with Overlay
          _buildBackgroundImage(),
          
          // Status Bar
          // _buildStatusBar(),
          
          // Main Content Column with Swipe Gesture
          GestureDetector(
            onPanEnd: (details) {
              // Swipe left (next page)
              if (details.velocity.pixelsPerSecond.dx < -500) {
                _nextPage();
              }
              // Swipe right (previous page)
              else if (details.velocity.pixelsPerSecond.dx > 500) {
                _previousPage();
              }
            },
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  /// Build background image with overlay
  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          // Use a gradient background as fallback
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[800]!,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/onboarding_background.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  logger.error('[OnboardingScreen] Background image error', error);
                  // Return a colored container if image fails
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue[800]!,
                          Colors.purple[900]!,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build status bar
  // Widget _buildStatusBar() {
  //   return Positioned(
  //     top: 0,
  //     left: 0,
  //     right: 0,
  //     child: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
              
  //             Row(
  //               children: [
                  
                  
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  /// Build fixed page indicators (outside PageView)
  Widget _buildFixedIndicators() {
    return Row(
      children: List.generate(
        _onboardingData.length,
        (index) => _buildLoadingIndicator(index),
      ),
    );
  }

  /// Build loading indicator with water-filling effect
  Widget _buildLoadingIndicator(int index) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 60, // Longer dots
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: index == _currentPage
          ? AnimatedBuilder(
              animation: _loadingAnimation,
              builder: (context, child) {
                return Container(
                  width: 60 * _loadingAnimation.value,
                  height: 4,
                  decoration: BoxDecoration(
                    color: DesignTokens.primary500, // Use the same green as the button
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              },
            )
          : null,
    );
  }

  /// Build main content column with icon, text, and indicators
  /// 
  /// This creates a proper column layout starting from 20% bottom
  /// Order: icon -> title -> description -> dots -> buttons
  Widget _buildMainContent() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: MediaQuery.of(context).size.height * 0.8, // Use 80% of screen height (starts at 20% from bottom)
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flexible spacer to push content towards bottom
              Expanded(child: SizedBox()),
              
              // 1. App Icon
              _buildAppIcon(),
              
              SizedBox(height: 16), // Space between icon and text
              
              // 2. Title
              _buildTitle(),
              
              SizedBox(height: 8), // Space between title and description
              
              // 3. Description
              _buildDescription(),
              
              SizedBox(height: 24), // Space between description and dots
              
              // 4. Dot Indicators
              _buildFixedIndicators(),
              
              SizedBox(height: 32), // Space between dots and buttons
              
              // 5. Button 1 (Create Account)
              _buildCreateAccountButton(),
              
              SizedBox(height: 16), // Space between buttons
              
              // 6. Button 2 (Login)
              _buildLoginButton(),
              
              SizedBox(height: 8), // Space before home indicator
              
              // Home Indicator
              // _buildHomeIndicator(),
              
              SizedBox(height: 16), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }

  /// Build app icon for column layout
  Widget _buildAppIcon() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          _onboardingData[_currentPage].icon, // Use current page icon
          color: DesignTokens.primary700,
          size: 30,
        ),
      ),
    );
  }

  /// Build title text
  Widget _buildTitle() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(
        _onboardingData[_currentPage].title,
        style: TextStyle(
          fontFamily: DesignTokens.fontFamilyPrimary,
          color: Colors.white,
          fontSize: DesignTokens.fontSize2xl, // 24px
          fontWeight: DesignTokens.fontWeightBold,
          height: DesignTokens.lineHeightTight,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  /// Build description text
  Widget _buildDescription() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(
        _onboardingData[_currentPage].subtitle,
        style: TextStyle(
          fontFamily: DesignTokens.fontFamilyPrimary,
          color: Colors.white.withValues(alpha: 0.8),
          fontSize: DesignTokens.fontSizeBase, // 16px
          fontWeight: DesignTokens.fontWeightRegular,
          height: DesignTokens.lineHeightNormal,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  /// Build create account button
  Widget _buildCreateAccountButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleCreateAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary500, // Use the green color from design
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          "Créer un compte",
          style: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontSize: 17,
            fontWeight: DesignTokens.fontWeightSemiBold,
          ),
        ),
      ),
    );
  }

  /// Build login button
  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: _handleLogin,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.15),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          "Connexion",
          style: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontSize: 17,
            fontWeight: DesignTokens.fontWeightSemiBold,
          ),
        ),
      ),
    );
  }

  /// Build home indicator
  // Widget _buildHomeIndicator() {
  //   return Center(
  //     child: Container(
  //       width: 134,
  //       height: 5,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(2.5),
  //       ),
  //     ),
  //   );
  // }


  /// Handle create account action
  void _handleCreateAccount() {
    _completeOnboarding();
  }

  /// Handle login action
  void _handleLogin() {
    AppRouter.goToLogin(context);
  }
}
