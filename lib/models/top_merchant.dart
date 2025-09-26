import 'package:flutter/foundation.dart';

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
