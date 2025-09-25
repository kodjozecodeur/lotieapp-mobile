import '../../models/nav_item.dart';

/// Navigation configuration for the app
/// 
/// This file defines the core navigation structure for the bottom nav bar.
/// Unlike sample data, this is part of the app's permanent configuration.
class NavigationConfig {
  // Private constructor to prevent instantiation
  NavigationConfig._();

  /// Bottom navigation items
  static const List<NavItem> bottomNavItems = [
    NavItem(
      id: 'accueil',
      route: '/home/accueil',
      iconPath: 'assets/icons/home.svg',
      label: 'Accueil',
    ),
    NavItem(
      id: 'rechercher',
      route: '/home/rechercher',
      iconPath: 'assets/icons/search_icon.svg',
      label: 'Rechercher',
    ),
    NavItem(
      id: 'favoris',
      route: '/home/favoris',
      iconPath: 'assets/icons/favorite_icon.svg',
      label: 'Favoris',
    ),
    NavItem(
      id: 'commandes',
      route: '/home/commandes',
      iconPath: 'assets/icons/order.svg',
      label: 'Commandes',
    ),
    NavItem(
      id: 'profil',
      route: '/home/profil',
      iconPath: 'assets/icons/profile.svg',
      label: 'Profil',
    ),
  ];

  /// Get navigation item by route
  static NavItem? getNavItemByRoute(String route) {
    try {
      return bottomNavItems.firstWhere((item) => item.route == route);
    } catch (e) {
      return null;
    }
  }

  /// Get navigation item by ID
  static NavItem? getNavItemById(String id) {
    try {
      return bottomNavItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
