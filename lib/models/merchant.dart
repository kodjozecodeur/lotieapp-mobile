import 'package:flutter/foundation.dart';

/// Merchant model for restaurant/store data
/// 
/// This model represents a merchant in the app with all necessary
/// properties for display and API integration. It includes proper
/// serialization methods for API communication.
@immutable
class Merchant {
  const Merchant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    required this.isAvailable,
    required this.categories,
    this.description,
    this.minimumOrder,
    this.deliveryFee,
    this.isPromoted = false,
    this.isFavorite = false,
  });

  /// Unique identifier for API calls
  final String id;
  
  /// Merchant display name
  final String name;
  
  /// Remote image URL for merchant logo/photo
  final String imageUrl;
  
  /// Average rating (0.0 to 5.0)
  final double rating;
  
  /// Estimated delivery time in minutes
  final int deliveryTime;
  
  /// Distance from user in kilometers
  final double distance;
  
  /// Whether merchant is currently accepting orders
  final bool isAvailable;
  
  /// List of category IDs this merchant belongs to
  final List<String> categories;
  
  /// Optional merchant description
  final String? description;
  
  /// Minimum order amount in FCFA
  final double? minimumOrder;
  
  /// Delivery fee in FCFA
  final double? deliveryFee;
  
  /// Whether merchant is promoted/featured
  final bool isPromoted;
  
  /// Whether user has favorited this merchant
  final bool isFavorite;

  /// Create Merchant from API JSON response
  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      deliveryTime: json['delivery_time'] as int,
      distance: (json['distance'] as num).toDouble(),
      isAvailable: json['is_available'] as bool,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      minimumOrder: json['minimum_order'] != null 
          ? (json['minimum_order'] as num).toDouble() 
          : null,
      deliveryFee: json['delivery_fee'] != null 
          ? (json['delivery_fee'] as num).toDouble() 
          : null,
      isPromoted: json['is_promoted'] as bool? ?? false,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  /// Convert Merchant to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'delivery_time': deliveryTime,
      'distance': distance,
      'is_available': isAvailable,
      'categories': categories,
      'description': description,
      'minimum_order': minimumOrder,
      'delivery_fee': deliveryFee,
      'is_promoted': isPromoted,
      'is_favorite': isFavorite,
    };
  }

  /// Create a copy with updated properties
  Merchant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? rating,
    int? deliveryTime,
    double? distance,
    bool? isAvailable,
    List<String>? categories,
    String? description,
    double? minimumOrder,
    double? deliveryFee,
    bool? isPromoted,
    bool? isFavorite,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      distance: distance ?? this.distance,
      isAvailable: isAvailable ?? this.isAvailable,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      isPromoted: isPromoted ?? this.isPromoted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Merchant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Merchant(id: $id, name: $name, rating: $rating, '
        'deliveryTime: $deliveryTime, distance: $distance)';
  }
}
