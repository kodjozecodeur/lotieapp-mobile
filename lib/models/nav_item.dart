import 'package:flutter/foundation.dart';

/// Navigation item model for bottom navigation bar
/// 
/// This model represents a tab in the bottom navigation with
/// icon, label, and route information for Go Router navigation.
@immutable
class NavItem {
  const NavItem({
    required this.id,
    required this.route,
    required this.iconPath,
    required this.label,
    this.isActive = false,
  });

  /// Unique identifier for the nav item
  final String id;
  
  /// Go Router route path
  final String route;
  
  /// Path to SVG icon in assets
  final String iconPath;
  
  /// Display label for the tab
  final String label;
  
  /// Whether this tab is currently active
  final bool isActive;

  /// Create a copy with updated active state
  NavItem copyWith({
    String? id,
    String? route,
    String? iconPath,
    String? label,
    bool? isActive,
  }) {
    return NavItem(
      id: id ?? this.id,
      route: route ?? this.route,
      iconPath: iconPath ?? this.iconPath,
      label: label ?? this.label,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'NavItem(id: $id, route: $route, label: $label, isActive: $isActive)';
  }
}
