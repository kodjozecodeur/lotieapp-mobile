import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constants/design_tokens.dart';
import '../../providers/onboarding_provider.dart';
import '../../routes/app_router.dart';

/// Onboarding data model
class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
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

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "Vos marchands préférés\nà portée de main",
      subtitle: "Découvrez une large sélection des marchands locaux,\nlivrés directement chez vous.",
      imagePath: "assets/images/onboarding_background.png",
      icon: Icons.shopping_cart,
    ),
    OnboardingData(
      title: "Commandez et faites-vous\nlivrer en un clic.",
      subtitle: "Découvrez une large sélection des marchands locaux,\nlivrés directement chez vous.",
      imagePath: "assets/images/onboarding_background.png",
      icon: Icons.local_shipping,
    ),
    OnboardingData(
      title: "Suivez votre commande\nà chaque étape.",
      subtitle: "Restez informé avec un suivi en temps réel, pour savoir\nexactement quand votre colis arrivera.",
      imagePath: "assets/images/onboarding_background.png",
      icon: Icons.location_on,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Complete onboarding flow
  /// 
  /// Marks onboarding as completed and navigates to registration
  void _completeOnboarding() {
    final onboardingProvider = Provider.of<OnboardingProvider>(context, listen: false);
    onboardingProvider.completeOnboarding();
    AppRouter.goToRegistration(context);
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
          _buildStatusBar(),
          
          // Page View Content
          _buildPageView(),
          
          // Bottom Navigation
          _buildBottomNavigation(),
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
            // Try to load the background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/onboarding_background.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Background image error: $error');
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
            // Gradient overlay
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
  Widget _buildStatusBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "9:41",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Icon(Icons.wifi, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Container(
                    width: 25,
                    height: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build page view
  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        HapticFeedback.lightImpact();
      },
      itemCount: _onboardingData.length,
      itemBuilder: (context, index) {
        return _buildOnboardingPage(_onboardingData[index]);
      },
    );
  }

  /// Build individual onboarding page
  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // App Icon
          Container(
            margin: EdgeInsets.only(top: 120, bottom: 80),
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
              data.icon,
              color: DesignTokens.primary950,
              size: 30,
            ),
          ),
          
          Spacer(),
          
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 16),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16,
                  height: 1.4,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 40),
              
              // Page Indicators
              Row(
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: EdgeInsets.only(right: 8),
                    width: index == _currentPage ? 24 : 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color: index == _currentPage 
                          ? DesignTokens.primary950 
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 60),
          ],
        ),
      );
  }

  /// Build bottom navigation
  Widget _buildBottomNavigation() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Create Account Button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Navigate to sign up
                      _handleCreateAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.primary950,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage < _onboardingData.length - 1 
                            ? "Suivant" 
                            : "Créer un compte",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Login Button
              Container(
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
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 8),
              
              // Home Indicator
              Container(
                width: 134,
                height: 5,
      decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handle create account action
  void _handleCreateAccount() {
    _completeOnboarding();
  }

  /// Handle login action
  void _handleLogin() {
    AppRouter.goToLogin(context);
  }
}
