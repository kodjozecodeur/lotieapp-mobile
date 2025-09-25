import 'package:flutter/foundation.dart';

/// Category model for navigation and filtering
/// 
/// This model represents a category in the app with icon, color,
/// and navigation information. Designed for both local categories
/// and API-driven dynamic categories.
@immutable
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
    this.description,
    this.isActive = true,
    this.sortOrder = 0,
    this.productCount,
  });

  /// Unique category identifier
  final String id;
  
  /// Category display name
  final String name;
  
  /// Path to SVG icon in assets
  final String iconPath;
  
  /// Category brand color (from DesignTokens)
  final String color; // Store as color name, resolve at runtime
  
  /// Optional category description
  final String? description;
  
  /// Whether category is active/visible
  final bool isActive;
  
  /// Sort order for display (lower numbers first)
  final int sortOrder;
  
  /// Number of products in this category (API-driven)
  final int? productCount;

  /// Create Category from API JSON response
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      iconPath: json['icon_path'] as String,
      color: json['color'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
      productCount: json['product_count'] as int?,
    );
  }

  /// Convert Category to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_path': iconPath,
      'color': color,
      'description': description,
      'is_active': isActive,
      'sort_order': sortOrder,
      'product_count': productCount,
    };
  }

  /// Create a copy with updated properties
  Category copyWith({
    String? id,
    String? name,
    String? iconPath,
    String? color,
    String? description,
    bool? isActive,
    int? sortOrder,
    int? productCount,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      productCount: productCount ?? this.productCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, color: $color, '
        'sortOrder: $sortOrder, isActive: $isActive)';
  }
}
