import 'package:flutter/foundation.dart';

/// Menu Item model for products/food items
/// 
/// This model represents items available from merchants (food, products, services)
/// with flexible properties that work for restaurants, shops, pharmacies, etc.
@immutable
class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    this.description,
    this.imageUrl,
    this.category,
    this.isAvailable = true,
    this.preparationTime,
    this.tags = const [],
    this.nutritionInfo,
    this.ingredients = const [],
    this.allergens = const [],
    this.isPopular = false,
    this.discount,
    this.originalPrice,
  });

  /// Unique identifier
  final String id;
  
  /// Item name (e.g., "Grand combo de nouilles", "Paracétamol 500mg")
  final String name;
  
  /// Current price
  final double price;
  
  /// Currency (e.g., "FCFA", "€")
  final String currency;
  
  /// Optional description
  final String? description;
  
  /// Optional image URL
  final String? imageUrl;
  
  /// Category (e.g., "Noodles", "Medicines", "Electronics")
  final String? category;
  
  /// Whether item is currently available
  final bool isAvailable;
  
  /// Preparation/delivery time in minutes
  final int? preparationTime;
  
  /// Tags (e.g., ["spicy", "vegetarian", "prescription-required"])
  final List<String> tags;
  
  /// Nutrition information (for food items)
  final String? nutritionInfo;
  
  /// Ingredients list (for food/medicine items)
  final List<String> ingredients;
  
  /// Allergen information
  final List<String> allergens;
  
  /// Whether this is a popular item
  final bool isPopular;
  
  /// Discount percentage (if any)
  final double? discount;
  
  /// Original price before discount
  final double? originalPrice;

  /// Get formatted price string
  String get formattedPrice => '$price $currency';
  
  /// Get formatted original price if discount exists
  String? get formattedOriginalPrice => 
      originalPrice != null ? '$originalPrice $currency' : null;
  
  /// Calculate discounted price
  double get discountedPrice {
    if (discount != null && originalPrice != null) {
      return originalPrice! * (1 - discount! / 100);
    }
    return price;
  }

  /// Create MenuItem from JSON
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'FCFA',
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String?,
      isAvailable: json['is_available'] as bool? ?? true,
      preparationTime: json['preparation_time'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      nutritionInfo: json['nutrition_info'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      allergens: (json['allergens'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      isPopular: json['is_popular'] as bool? ?? false,
      discount: json['discount'] != null ? (json['discount'] as num).toDouble() : null,
      originalPrice: json['original_price'] != null ? (json['original_price'] as num).toDouble() : null,
    );
  }

  /// Convert MenuItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'description': description,
      'image_url': imageUrl,
      'category': category,
      'is_available': isAvailable,
      'preparation_time': preparationTime,
      'tags': tags,
      'nutrition_info': nutritionInfo,
      'ingredients': ingredients,
      'allergens': allergens,
      'is_popular': isPopular,
      'discount': discount,
      'original_price': originalPrice,
    };
  }

  /// Create a copy with updated properties
  MenuItem copyWith({
    String? id,
    String? name,
    double? price,
    String? currency,
    String? description,
    String? imageUrl,
    String? category,
    bool? isAvailable,
    int? preparationTime,
    List<String>? tags,
    String? nutritionInfo,
    List<String>? ingredients,
    List<String>? allergens,
    bool? isPopular,
    double? discount,
    double? originalPrice,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      preparationTime: preparationTime ?? this.preparationTime,
      tags: tags ?? this.tags,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      isPopular: isPopular ?? this.isPopular,
      discount: discount ?? this.discount,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MenuItem(id: $id, name: $name, price: $price $currency)';
  }
}
