import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/design_tokens.dart';
import 'floating_bottom_navbar.dart';

/// Main shell widget that wraps all pages with bottom navigation
/// 
/// This widget provides the main application shell that includes:
/// - The page content as the child
/// - Floating bottom navigation bar
/// - Proper scaffold structure
/// - Background styling using DesignTokens
/// 
/// Used with Go Router's ShellRoute to maintain navigation state
/// across different pages while providing consistent navigation UI.
class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  /// The page content to display
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get current route for active navigation state
    final goRouterState = GoRouterState.of(context);
    final String currentRoute = goRouterState.uri.path;

    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      extendBody: true, // Allow content to extend behind floating navbar
      body: SafeArea(
        bottom: false, // Don't apply safe area to bottom (navbar handles this)
        child: child,
      ),
      floatingActionButton: FloatingBottomNavBar(
        currentRoute: currentRoute,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
