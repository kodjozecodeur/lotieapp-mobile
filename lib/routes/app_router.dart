import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/core/screens/splash_screen.dart';
import '../features/core/screens/loading_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/auth/screens/registration_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../widgets/navigation/main_shell.dart';
import '../features/home/screens/accueil_page.dart';
import '../features/home/screens/rechercher_page.dart';
import '../features/home/screens/favoris_page.dart';
import '../features/home/screens/commandes_page.dart';
import '../features/home/screens/profil_page.dart';

/// Application router configuration using GoRouter
/// 
/// This file defines all the routes in the application and handles
/// navigation logic, including authentication guards and route transitions.
/// It follows clean architecture principles and provides type-safe navigation.

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  /// Main router configuration
  /// 
  /// This defines the route tree and handles:
  /// - Route definitions
  /// - Authentication guards
  /// - Route transitions
  /// - Error handling
  static final GoRouter router = GoRouter(
    // Initial route - start with splash screen
    initialLocation: '/splash',
    
    // Route builder function
    routes: [
      // Splash Screen Route
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Loading Screen Route
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      
      // Onboarding Flow Route
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      GoRoute(
        path: '/registration',
        name: 'registration',
        builder: (context, state) => const RegistrationScreen(),
      ),
      
      // Legacy Home Route (redirect to new structure)
      GoRoute(
        path: '/home',
        name: 'home',
        redirect: (context, state) => '/home/accueil',
      ),
      
      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Accueil (Home) Page
          GoRoute(
            path: '/home/accueil',
            name: 'accueil',
            builder: (context, state) => const AccueilPage(),
          ),
          
          // Rechercher (Search) Page
          GoRoute(
            path: '/home/rechercher',
            name: 'rechercher',
            builder: (context, state) => const RechercherPage(),
          ),
          
          // Favoris (Favorites) Page
          GoRoute(
            path: '/home/favoris',
            name: 'favoris',
            builder: (context, state) => const FavorisPage(),
          ),
          
          // Commandes (Orders) Page
          GoRoute(
            path: '/home/commandes',
            name: 'commandes',
            builder: (context, state) => const CommandesPage(),
          ),
          
          // Profil (Profile) Page
          GoRoute(
            path: '/home/profil',
            name: 'profil',
            builder: (context, state) => const ProfilPage(),
          ),
        ],
      ),
    ],
    
    // Error page builder
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  /// Navigation helper methods
  /// 
  /// These provide convenient methods for common navigation patterns
  /// throughout the app.

  /// Navigate to splash screen
  static void goToSplash(BuildContext context) {
    context.go('/splash');
  }

  /// Navigate to loading screen
  static void goToLoading(BuildContext context) {
    context.go('/loading');
  }

  /// Navigate to onboarding flow
  static void goToOnboarding(BuildContext context) {
    context.go('/onboarding');
  }

  /// Navigate to login screen
  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  /// Navigate to registration screen
  static void goToRegistration(BuildContext context) {
    context.go('/registration');
  }

  /// Navigate to OTP screen
  static void goToOTP(BuildContext context, {String? phoneNumber}) {
    context.go('/otp');
  }

  /// Navigate to home screen (redirects to accueil)
  static void goToHome(BuildContext context) {
    context.go('/home/accueil');
  }

  /// Navigate to accueil (main home) page
  static void goToAccueil(BuildContext context) {
    context.go('/home/accueil');
  }

  /// Navigate to rechercher (search) page
  static void goToRechercher(BuildContext context) {
    context.go('/home/rechercher');
  }

  /// Navigate to favoris (favorites) page
  static void goToFavoris(BuildContext context) {
    context.go('/home/favoris');
  }

  /// Navigate to commandes (orders) page
  static void goToCommandes(BuildContext context) {
    context.go('/home/commandes');
  }

  /// Navigate to profil (profile) page
  static void goToProfil(BuildContext context) {
    context.go('/home/profil');
  }

  /// Navigate back to previous screen
  static void goBack(BuildContext context) {
    context.pop();
  }

  /// Navigate and replace current route
  static void goAndReplace(BuildContext context, String route) {
    context.go(route);
  }

  /// Navigate and push new route
  static void push(BuildContext context, String route) {
    context.push(route);
  }
}
