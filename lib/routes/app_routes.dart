import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/loading/loading_screen.dart';

/// Application routes configuration
/// 
/// This file defines all the routes in the application following
/// clean architecture principles. It centralizes route management
/// and provides type-safe navigation.

class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route names
  static const String home = '/';
  static const String loading = '/loading';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  /// Route generator function
  /// 
  /// This function is used by MaterialApp to generate routes
  /// based on the route name and arguments
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(
          const HomeScreen(),
          settings,
        );
      
      case loading:
        return _buildRoute(
          const LoadingScreen(),
          settings,
        );
      
      case login:
        return _buildRoute(
          const LoginScreen(),
          settings,
        );
      
      case register:
        return _buildRoute(
          const RegisterScreen(),
          settings,
        );
      
      case profile:
        return _buildRoute(
          const ProfileScreen(),
          settings,
        );
      
      case '/settings':
        return _buildRoute(
          const SettingsScreen(),
          settings,
        );
      
      case notifications:
        return _buildRoute(
          const NotificationsScreen(),
          settings,
        );
      
      default:
        return _buildRoute(
          const NotFoundScreen(),
          settings,
        );
    }
  }

  /// Builds a route with custom transition
  /// 
  /// [screen] - The screen widget to display
  /// [settings] - The route settings
  static Route<dynamic> _buildRoute(Widget screen, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => screen,
      settings: settings,
    );
  }

  /// Navigates to a named route
  /// 
  /// [context] - The build context
  /// [routeName] - The name of the route to navigate to
  /// [arguments] - Optional arguments to pass to the route
  static Future<T?> navigateTo<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a new one
  /// 
  /// [context] - The build context
  /// [routeName] - The name of the route to navigate to
  /// [arguments] - Optional arguments to pass to the route
  static Future<T?> replaceWith<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, Object?>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigates to a route and removes all previous routes
  /// 
  /// [context] - The build context
  /// [routeName] - The name of the route to navigate to
  /// [arguments] - Optional arguments to pass to the route
  static Future<T?> navigateAndClearStack<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Goes back to the previous screen
  /// 
  /// [context] - The build context
  /// [result] - Optional result to return
  static void goBack<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }
}

/// Placeholder screens for routes that haven't been implemented yet

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Login Screen - Coming Soon'),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const Center(
        child: Text('Register Screen - Coming Soon'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen - Coming Soon'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen - Coming Soon'),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Notifications Screen - Coming Soon'),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Text('The requested page was not found.'),
      ),
    );
  }
}
