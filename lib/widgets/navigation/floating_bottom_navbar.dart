import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/design_tokens.dart';
import '../../models/nav_item.dart';
import '../../core/config/navigation_config.dart';
import '../../core/utils/logger.dart';

/// Floating bottom navigation bar component
/// 
/// This widget creates a custom floating bottom navigation bar that matches
/// the design specification. It uses Go Router for navigation and includes
/// smooth transitions, haptic feedback, and proper active state management.
/// 
/// Features:
/// - Floating design with green background
/// - Smooth animations for active state transitions
/// - Haptic feedback on navigation
/// - SVG icon support
/// - Apple-style visual design
/// - Responsive sizing using ScreenUtil
class FloatingBottomNavBar extends StatefulWidget {
  const FloatingBottomNavBar({
    super.key,
    required this.currentRoute,
  });

  /// Current route to determine active tab
  final String currentRoute;

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignTokens.durationNormal,
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOutBack,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void didUpdateWidget(FloatingBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Force rebuild when route changes to update active state
    if (oldWidget.currentRoute != widget.currentRoute) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Get the currently active nav item index
  int get _currentIndex {
    final currentPath = widget.currentRoute;
    logger.debug('[FloatingBottomNavBar] Current route: $currentPath');
    
    // Check for exact matches first
    for (int i = 0; i < NavigationConfig.bottomNavItems.length; i++) {
      final navRoute = NavigationConfig.bottomNavItems[i].route;
      if (currentPath == navRoute) {
        logger.debug('[FloatingBottomNavBar] Exact match found at index: $i');
        return i;
      }
    }
    
    // Check for route matches with nested paths
    for (int i = 0; i < NavigationConfig.bottomNavItems.length; i++) {
      final navRoute = NavigationConfig.bottomNavItems[i].route;
      if (currentPath.startsWith(navRoute)) {
        logger.debug('[FloatingBottomNavBar] StartsWith match found at index: $i');
        return i;
      }
    }
    
    // Handle fallback cases
    if (currentPath == '/home' || currentPath == '/') {
      logger.debug('[FloatingBottomNavBar] Fallback case - returning index 0');
      return 0; // Default to "Accueil"
    }
    
    logger.debug('[FloatingBottomNavBar] No match found - defaulting to index 0');
    return 0; // Default to first tab
  }

  /// Handle navigation tab tap
  void _onTabTapped(int index) {
    final navItem = NavigationConfig.bottomNavItems[index];
    
    logger.debug('[FloatingBottomNavBar] Tab tapped: ${navItem.label} -> ${navItem.route}');
    
    // Haptic feedback for iOS-style interaction
    HapticFeedback.selectionClick();
    
    // Use go for proper navigation with nested routes
    context.go(navItem.route);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex;
    logger.debug('[FloatingBottomNavBar] Building navbar, currentIndex: $currentIndex');
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              margin: EdgeInsets.only(
                left: DesignTokens.space2.w,
                right: DesignTokens.space2.w,
                bottom: MediaQuery.of(context).padding.bottom + DesignTokens.space4.h,
              ),
              height: 70.h, // Optimized height with reduced vertical padding
              decoration: BoxDecoration(
                color: DesignTokens.primary950,
                borderRadius: BorderRadius.circular(DesignTokens.radius3xl.r),
                boxShadow: DesignTokens.shadowLg,
              ),
              child: Row(
                children: List.generate(
                  NavigationConfig.bottomNavItems.length,
                  (index) {
                    final isActive = _currentIndex == index;
                    return _buildNavItem(
                      NavigationConfig.bottomNavItems[index],
                      index,
                      isActive,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build individual navigation item
  Widget _buildNavItem(NavItem navItem, int index, bool isActive) {
    logger.debug('[FloatingBottomNavBar] Building nav item ${navItem.label} at index $index, isActive: $isActive');
    
    return Expanded(
      flex: isActive ? 2 : 1, // Balanced distribution with optimized padding (2/6 vs 1/6 each)
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        behavior: HitTestBehavior.opaque, // Ensure entire area is tappable
        child: AnimatedContainer(
          duration: DesignTokens.durationNormal,
          curve: DesignTokens.easeInOutCubic,
          margin: EdgeInsets.symmetric(
            horizontal: DesignTokens.space2.w,
            vertical: DesignTokens.space3.h,
          ),
          padding: EdgeInsets.only(
            left: isActive ? DesignTokens.space0 : DesignTokens.space1.w,
            right: isActive ? DesignTokens.space1.w : DesignTokens.space1.w,
            top: DesignTokens.space2.h,
            bottom: DesignTokens.space2.h,
          ),
          decoration: isActive
              ? BoxDecoration(
                  color: DesignTokens.secondary950, // Yellow pill background
                  borderRadius: BorderRadius.circular(DesignTokens.radiusFull.r), // Full radius for pill shape
                )
              : null,
          child: Center(
            child: _buildNavContent(navItem, isActive),
          ),
        ),
      ),
    );
  }

  /// Build navigation content (icon + label for active, icon only for inactive)
  Widget _buildNavContent(NavItem navItem, bool isActive) {
    logger.debug('[FloatingBottomNavBar] Building content for ${navItem.label}, isActive: $isActive');
    
    if (isActive) {
      // Active: Show icon + label side by side in horizontal layout (pill style)
      logger.debug('[FloatingBottomNavBar] Rendering active content for ${navItem.label}');
      
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(navItem.iconPath, isActive),
          SizedBox(width: DesignTokens.space1.w), // Increased spacing for better visual separation
          Flexible(
            child: Text(
              navItem.label,
              style: TextStyle(
                fontSize: 13.sp, // Larger text for better readability with more space
                fontWeight: DesignTokens.fontWeightSemiBold, // Bolder text for better contrast
                color: DesignTokens.neutral900, // Dark text on yellow background
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      // Inactive: Show icon only for clean, minimal design
      return _buildIcon(navItem.iconPath, isActive);
    }
  }

  /// Build icon with fallback
  Widget _buildIcon(String iconPath, bool isActive) {
    try {
      return SvgPicture.asset(
        iconPath,
        width: isActive ? 20.w : 24.w, // Proper active icon size with more space, 24w/h for inactive
        height: isActive ? 20.h : 24.h,
        colorFilter: ColorFilter.mode(
          isActive ? DesignTokens.neutral900 : Colors.white,
          BlendMode.srcIn,
        ),
      );
    } catch (e) {
      logger.error('[FloatingBottomNavBar] Error loading SVG $iconPath: $e');
      // Fallback to a simple icon
      return Icon(
        Icons.home,
        size: isActive ? 18.w : 24.w, // Match icon size based on state
        color: isActive ? DesignTokens.primary900 : Colors.white,
      );
    }
  }
}