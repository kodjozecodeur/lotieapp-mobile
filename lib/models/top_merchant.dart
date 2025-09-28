import 'package:flutter/foundation.dart';

/// Merchant types enum
enum MerchantType {
  restaurant,
  supermarket,
  pharmacy,
  electronics,
  clothing,
  other,
}

/// Top Merchant model for the Top Marchands page
/// 
/// This model represents merchants displayed in the top merchants list
/// with specific properties required for the card layout.
@immutable
class TopMerchant {
  const TopMerchant({
    required this.id,
    required this.businessName,
    required this.category,
    required this.subcategory,
    required this.priceFrom,
    required this.distance,
    required this.duration,
    required this.rating,
    this.imageUrl,
    this.isFavorite = false,
    this.merchantType = MerchantType.restaurant,
    this.productCategories = const [],
  });

  /// Unique identifier
  final String id;
  
  /// Business name (e.g., "Restaurant les 2A")
  final String businessName;
  
  /// Main category (e.g., "Southern", "Bien-être")
  final String category;
  
  /// Subcategory (e.g., "Fried Chicken", "Habits")
  final String subcategory;
  
  /// Price starting from text (e.g., "À partir de 2 000 FCFA")
  final String priceFrom;
  
  /// Distance (e.g., "3km")
  final String distance;
  
  /// Duration (e.g., "5 min")
  final String duration;
  
  /// Star rating (e.g., 4.4)
  final double rating;
  
  /// Optional image URL
  final String? imageUrl;
  
  /// Whether merchant is favorited
  final bool isFavorite;
  
  /// Type of merchant (restaurant, supermarket, etc.)
  final MerchantType merchantType;
  
  /// Product categories for search (supermarkets, electronics, etc.)
  final List<String> productCategories;

  /// Create TopMerchant from JSON
  factory TopMerchant.fromJson(Map<String, dynamic> json) {
    return TopMerchant(
      id: json['id'] as String,
      businessName: json['business_name'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      priceFrom: json['price_from'] as String,
      distance: json['distance'] as String,
      duration: json['duration'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      merchantType: MerchantType.values.firstWhere(
        (type) => type.name == json['merchant_type'],
        orElse: () => MerchantType.restaurant,
      ),
      productCategories: (json['product_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
  }

  /// Convert TopMerchant to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': businessName,
      'category': category,
      'subcategory': subcategory,
      'price_from': priceFrom,
      'distance': distance,
      'duration': duration,
      'rating': rating,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
      'merchant_type': merchantType.name,
      'product_categories': productCategories,
    };
  }

  /// Create a copy with updated properties
  TopMerchant copyWith({
    String? id,
    String? businessName,
    String? category,
    String? subcategory,
    String? priceFrom,
    String? distance,
    String? duration,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
    MerchantType? merchantType,
    List<String>? productCategories,
  }) {
    return TopMerchant(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      priceFrom: priceFrom ?? this.priceFrom,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      merchantType: merchantType ?? this.merchantType,
      productCategories: productCategories ?? this.productCategories,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TopMerchant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TopMerchant(id: $id, businessName: $businessName, '
        'category: $category, rating: $rating)';
  }
}
