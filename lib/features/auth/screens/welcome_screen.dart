import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/utils/logger.dart';
import '../../../routes/app_router.dart';

/// Welcome screen with free pass offer
///
/// This screen displays the welcome page after profile setup.
/// It features:
/// - Green gradient background matching brand colors
/// - Top pill button for free pass offer
/// - Main headline about free delivery
/// - Horizontal scrollable product showcase
/// - Benefits section with cards
/// - Bottom CTA button
/// Following Apple's Human Interface Guidelines for modern, sleek design

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // PageController for product showcase
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _pageController = PageController(viewportFraction: 0.4);
  }

  /// Initialize welcome screen animations
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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: DesignTokens.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Handle free pass button press
  void _handleFreePassButton() {
    logger.info('[WelcomeScreen] Free pass button pressed');
    // TODO: Implement free pass functionality
  }

  /// Handle get free pass CTA
  void _handleGetFreePass() {
    logger.info('[WelcomeScreen] Get free pass CTA pressed');
    // TODO: Implement pass acquisition logic
    
    // Navigate to home screen - setup complete
    AppRouter.goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for bottom half
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    // Header section with green gradient background (40% of screen)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.40, // 40% of screen
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            DesignTokens.primary950, // Dark green
                            DesignTokens.neutral900, // Lighter green
                          ],
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Top section with responsive status bar padding
                            SizedBox(height: MediaQuery.of(context).padding.top + 4.h), // Further reduced
                            
                            // Header section with pill button and headline
                            _buildHeaderSection(),
                            
                            SizedBox(height: 4.h), // Further reduced
                            
                            // Product images row - top row only for space efficiency
                            _buildProductShowcase(),
                            
                            SizedBox(height: 4.h), // Further reduced
                            
                            // Bottom product row in green section
                            _buildBottomProductRow(),
                            
                            SizedBox(height: 8.h), // Add bottom padding for scroll
                          ],
                        ),
                      ),
                    ),
                    
                    // White section (60% of screen)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(DesignTokens.space5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: DesignTokens.space4.h), // Top spacing
                            
                            // Section title
                            Text(
                              'Qu\'est-ce que vous allez obtenir ?',
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeLg.sp,
                                fontWeight: DesignTokens.fontWeightSemiBold,
                                color: DesignTokens.neutral850,
                                fontFamily: DesignTokens.fontFamilyPrimary,
                              ),
                            ),
                            
                            SizedBox(height: DesignTokens.space4.h),
                            
                            // Benefit cards
                            _buildBenefitCard(
                              iconPath: 'assets/icons/delivery.svg',
                              title: 'Livraison Gratuite',
                              description: 'Livraisons sans frais à votre première commande.',
                            ),
                            
                            SizedBox(height: DesignTokens.space3.h),
                            
                            _buildBenefitCard(
                              iconPath: 'assets/icons/notif_icon.svg',
                              title: 'Accès Anticipé',
                              description: 'Soyez le premier à être informé des nouvelles promotions pendant 3 jours.',
                            ),
                            
                            const Spacer(),
                            
                            // Bottom CTA button
                            _buildBottomCTA(),
                            
                            SizedBox(height: MediaQuery.of(context).padding.bottom + DesignTokens.space4.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }

  /// Build header section with pill button and main headline
  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small pill button
          _buildPillButton(),
          
          SizedBox(height: DesignTokens.space6.h),
          
          // Main headline
          _buildMainHeadline(),
        ],
      ),
    );
  }

  /// Build small rounded pill button
  Widget _buildPillButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space4.w,
        vertical: DesignTokens.space2.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: InkWell(
        onTap: _handleFreePassButton,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        child: Text(
          'Obtenez un Pass Gratuit',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXs.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: Colors.white,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
      ),
    );
  }

  /// Build main headline text
  Widget _buildMainHeadline() {
    return Text(
      'Faites vous livrer gratuitement avec le Pass Gratuit de Bienvenue',
      style: TextStyle(
        fontSize: DesignTokens.fontSize2xl.sp, // Reduced from 3xl to 2xl
        fontWeight: DesignTokens.fontWeightSemiBold,
        color: Colors.white,
        fontFamily: DesignTokens.fontFamilyPrimary,
        height: DesignTokens.lineHeightTight,
      ),
    );
  }

  /// Build product showcase - only top row (bottom row now in Stack overlay)
  Widget _buildProductShowcase() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DesignTokens.space1.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                 _buildProductCircle({
                   'name': 'Nike Sneaker',
                   'image': 'assets/images/product_img_1.jpg',
                 }),
                 _buildLargeProductCircle({
                   'name': 'Sony Headphones',
                   'image': 'assets/images/product_img_1.jpg',
                 }),
                 _buildProductCircle({
                   'name': 'Iced Tea',
                   'image': 'assets/images/product_img_1.jpg',
                 }),
          ],
        ),
      ),
    );
  }

  /// Build bottom product row for Stack overlay (CSS-like positioning)
  Widget _buildBottomProductRow() {
    return ClipRect(
      child: SizedBox(
        height: 80.h,
        child: OverflowBox(
          maxWidth: MediaQuery.of(context).size.width * 1.5, // Extension for cutoff effect
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                   _buildProductCircle({
                     'name': 'Food Bowl',
                     'image': 'assets/images/product_img_1.jpg',
                   }),
                   _buildProductCircle({
                     'name': 'Fashion Bag',
                     'image': 'assets/images/product_img_1.jpg',
                   }),
                   _buildProductCircle({
                     'name': 'Wall Art',
                     'image': 'assets/images/product_img_1.jpg',
                   }),
                   _buildProductCircle({
                     'name': 'Kitchen',
                     'image': 'assets/images/product_img_1.jpg',
                   }),
                   _buildProductCircle({
                     'name': 'Electronics',
                     'image': 'assets/images/product_img_1.jpg',
                   }),
            ],
          ),
        ),
      ),
    );
  }

  /// Build product circle for grid layout
  Widget _buildProductCircle(Map<String, dynamic> productData) {
    return Container(
      width: 80.w, // Standard size for grid layout
      height: 80.h, // Standard size for grid layout
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Color.fromARGB(255, 206, 206, 206).withValues(alpha: 1),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: Offset(0, 4.h),
            blurRadius: 12.w,
            spreadRadius: 0,
          ),
        ],
      ),
        child: ClipOval(
          child: Image.asset(
            productData['image'] as String,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback placeholder if image not found
              return Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(
                  Icons.image,
                  size: 32.w,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
        ),
    );
  }

  /// Build large product circle for middle focal point
  Widget _buildLargeProductCircle(Map<String, dynamic> productData) {
    return Container(
      width: 100.w, // Larger size for focal point
      height: 100.h, // Larger size for focal point
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 1.w, // Slightly thicker border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: Offset(0, 6.h),
            blurRadius: 16.w,
            spreadRadius: 0,
          ),
        ],
      ),
        child: ClipOval(
          child: Image.asset(
            productData['image'] as String,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback placeholder if image not found
              return Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(
                  Icons.image,
                  size: 40.w,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
        ),
    );
  }




  /// Build individual benefit card
  Widget _buildBenefitCard({
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.space2.w), // Further reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        // Removed boxShadow for cleaner look
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 40.w, // Reduced size
            height: 40.h, // Reduced size
            decoration: BoxDecoration(
              color: DesignTokens.neutral200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                width: 24.w, // Force exact size
                height: 24.h, // Force exact size
                child: SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain, // Force to fit within the SizedBox
                  
                ),
              ),
            ),
          ),
          
          SizedBox(width: DesignTokens.space2.w), // Further reduced spacing
          
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.neutral850,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                
                SizedBox(height: 2.h), // Minimal spacing
                
                Text(
                  description,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm.sp,
                    fontWeight: DesignTokens.fontWeightRegular,
                    color: DesignTokens.neutral600,
                    fontFamily: DesignTokens.fontFamilySecondary,
                    height: DesignTokens.lineHeightNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build bottom CTA button
  Widget _buildBottomCTA() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _handleGetFreePass,
          style: ElevatedButton.styleFrom(
            backgroundColor: DesignTokens.primary950,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
            elevation: 0,
          ),
          child: Text(
            'Obtenir mon pass gratuit',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
