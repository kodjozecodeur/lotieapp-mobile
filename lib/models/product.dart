import 'package:flutter/foundation.dart';

/// Product model for items in promotions and recommendations
/// 
/// This model represents a product/item with pricing, merchant info,
/// and promotion details. Designed for API integration and real-time
/// pricing updates.
@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.merchantId,
    required this.merchantName,
    this.originalPrice,
    this.discountPercentage,
    this.description,
    this.category,
    this.isAvailable = true,
    this.isFavorite = false,
    this.stockQuantity,
    this.tags = const [],
  });

  /// Unique product identifier for API calls
  final String id;
  
  /// Product display name
  final String name;
  
  /// Remote image URL for product photo
  final String imageUrl;
  
  /// Current price in FCFA
  final double price;
  
  /// ID of merchant selling this product
  final String merchantId;
  
  /// Name of merchant selling this product
  final String merchantName;
  
  /// Original price before discount (for promotions)
  final double? originalPrice;
  
  /// Discount percentage (for promotion badges)
  final int? discountPercentage;
  
  /// Product description
  final String? description;
  
  /// Product category
  final String? category;
  
  /// Whether product is currently available
  final bool isAvailable;
  
  /// Whether user has favorited this product
  final bool isFavorite;
  
  /// Available stock quantity
  final int? stockQuantity;
  
  /// Product tags for filtering
  final List<String> tags;

  /// Whether this product is on promotion
  bool get isOnPromotion => originalPrice != null && originalPrice! > price;

  /// Formatted price string with FCFA currency
  String get formattedPrice => '${price.toInt()} FCFA';

  /// Formatted original price string (for strikethrough)
  String? get formattedOriginalPrice => 
      originalPrice != null ? '${originalPrice!.toInt()} FCFA' : null;

  /// Create Product from API JSON response
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      price: (json['price'] as num).toDouble(),
      merchantId: json['merchant_id'] as String,
      merchantName: json['merchant_name'] as String,
      originalPrice: json['original_price'] != null 
          ? (json['original_price'] as num).toDouble() 
          : null,
      discountPercentage: json['discount_percentage'] as int?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      isAvailable: json['is_available'] as bool? ?? true,
      isFavorite: json['is_favorite'] as bool? ?? false,
      stockQuantity: json['stock_quantity'] as int?,
      tags: json['tags'] != null 
          ? (json['tags'] as List<dynamic>).map((e) => e as String).toList()
          : const [],
    );
  }

  /// Convert Product to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'merchant_id': merchantId,
      'merchant_name': merchantName,
      'original_price': originalPrice,
      'discount_percentage': discountPercentage,
      'description': description,
      'category': category,
      'is_available': isAvailable,
      'is_favorite': isFavorite,
      'stock_quantity': stockQuantity,
      'tags': tags,
    };
  }

  /// Create a copy with updated properties
  Product copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? merchantId,
    String? merchantName,
    double? originalPrice,
    int? discountPercentage,
    String? description,
    String? category,
    bool? isAvailable,
    bool? isFavorite,
    int? stockQuantity,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      description: description ?? this.description,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      isFavorite: isFavorite ?? this.isFavorite,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, '
        'merchantName: $merchantName, isOnPromotion: $isOnPromotion)';
  }
}
