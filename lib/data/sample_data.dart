import '../models/merchant.dart';
import '../models/product.dart';
import '../models/category.dart';

/// Sample data for testing and development
/// 
/// This file contains realistic sample data that matches the design
/// reference. In production, this data will come from API endpoints.
/// All data is structured to be API-ready for easy migration.
class SampleData {
  // Private constructor to prevent instantiation
  SampleData._();


  /// Category grid items (matching the design)
  static const List<Category> categories = [
    Category(
      id: 'promotions',
      name: 'Promotions',
      iconPath: 'assets/icons/promotions_icon.svg',
      color: 'success500', // Green percentage icon
      sortOrder: 1,
      productCount: 45,
    ),
    Category(
      id: 'epicerie',
      name: 'Épicerie',
      iconPath: 'assets/icons/epicerie_icon.svg',
      color: 'warning500', // Orange basket icon
      sortOrder: 2,
      productCount: 120,
    ),
    Category(
      id: 'restaurants',
      name: 'Restaurants',
      iconPath: 'assets/icons/restaurants_icon.svg',
      color: 'error500', // Orange building icon
      sortOrder: 3,
      productCount: 78,
    ),
    Category(
      id: 'supermarche',
      name: 'Supermarché',
      iconPath: 'assets/icons/supermarche_icon.svg',
      color: 'info500', // Blue shopping cart icon
      sortOrder: 4,
      productCount: 95,
    ),
  ];

  /// Sample merchants for "Top Marchands" section
  static const List<Merchant> topMerchants = [
    Merchant(
      id: 'restaurant-1',
      name: 'Restaurants les 2A',
      imageUrl: 'assets/images/restaurant_2a.jpg',
      rating: 4.8,
      deliveryTime: 20,
      distance: 15.0,
      isAvailable: true,
      categories: ['restaurants'],
      description: 'Cuisine traditionnelle et moderne',
      minimumOrder: 5000,
      deliveryFee: 500,
      isPromoted: true,
    ),
    Merchant(
      id: 'restaurant-2',
      name: 'Chez Mama Africa',
      imageUrl: 'assets/images/mama_africa.jpg',
      rating: 4.6,
      deliveryTime: 25,
      distance: 12.5,
      isAvailable: true,
      categories: ['restaurants'],
      description: 'Plats africains authentiques',
      minimumOrder: 3000,
      deliveryFee: 500,
    ),
    Merchant(
      id: 'restaurant-3',
      name: 'Le Gourmet',
      imageUrl: 'assets/images/le_gourmet.jpg',
      rating: 4.9,
      deliveryTime: 18,
      distance: 8.2,
      isAvailable: true,
      categories: ['restaurants'],
      description: 'Cuisine française raffinée',
      minimumOrder: 8000,
      deliveryFee: 1000,
      isPromoted: true,
    ),
  ];

  /// Sample products for "Promotions" section
  static const List<Product> promotionProducts = [
    Product(
      id: 'promo-1',
      name: 'Grand Combo Nouilles',
      imageUrl: 'assets/images/combo_nouilles.jpg',
      price: 2000,
      originalPrice: 2500,
      discountPercentage: 10,
      merchantId: 'restaurant-han-noui',
      merchantName: 'Restaurant Han-noui',
      description: 'Délicieux combo de nouilles avec légumes',
      category: 'restaurants',
      isAvailable: true,
      tags: ['combo', 'nouilles', 'promotion'],
    ),
    Product(
      id: 'promo-2',
      name: 'Parfum Dior Sauvage',
      imageUrl: 'assets/images/parfum_dior.jpg',
      price: 15000,
      originalPrice: 18000,
      discountPercentage: 10,
      merchantId: 'zara-fils',
      merchantName: 'Zara & Fils',
      description: 'Parfum masculin de luxe',
      category: 'beaute',
      isAvailable: true,
      tags: ['parfum', 'luxe', 'promotion'],
    ),
    Product(
      id: 'promo-3',
      name: 'Pizza Margherita',
      imageUrl: 'assets/images/pizza_margherita.jpg',
      price: 3500,
      originalPrice: 4000,
      discountPercentage: 10,
      merchantId: 'pizzeria-bella',
      merchantName: 'Pizzeria Bella',
      description: 'Pizza classique aux tomates et mozzarella',
      category: 'restaurants',
      isAvailable: true,
      tags: ['pizza', 'italien', 'promotion'],
    ),
  ];

  /// Sample products for "Recommandés pour vous" section
  static const List<Product> recommendedProducts = [
    Product(
      id: 'rec-1',
      name: 'Salade César',
      imageUrl: 'assets/images/salade_cesar.jpg',
      price: 2500,
      merchantId: 'healthy-food',
      merchantName: 'Healthy Food',
      description: 'Salade fraîche avec poulet grillé',
      category: 'restaurants',
      isAvailable: true,
      tags: ['salade', 'healthy', 'poulet'],
    ),
    Product(
      id: 'rec-2',
      name: 'Smartphone Samsung',
      imageUrl: 'assets/images/samsung_phone.jpg',
      price: 85000,
      merchantId: 'tech-store',
      merchantName: 'Tech Store',
      description: 'Dernier modèle Samsung Galaxy',
      category: 'electronique',
      isAvailable: true,
      tags: ['smartphone', 'samsung', 'tech'],
    ),
    Product(
      id: 'rec-3',
      name: 'Burger Deluxe',
      imageUrl: 'assets/images/burger_deluxe.jpg',
      price: 4000,
      merchantId: 'burger-king',
      merchantName: 'Burger King',
      description: 'Burger avec double steak et fromage',
      category: 'restaurants',
      isAvailable: true,
      tags: ['burger', 'fast-food', 'steak'],
    ),
  ];

  /// All sample data combined for easy access
  static Map<String, dynamic> get allData => {
    'categories': categories,
    'topMerchants': topMerchants,
    'promotionProducts': promotionProducts,
    'recommendedProducts': recommendedProducts,
  };

  /// Get category by ID
  static Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get merchant by ID
  static Merchant? getMerchantById(String id) {
    try {
      return topMerchants.firstWhere((merchant) => merchant.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get product by ID
  static Product? getProductById(String id) {
    try {
      return [...promotionProducts, ...recommendedProducts]
          .firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Simulate API loading delay for testing
  static Future<T> simulateApiCall<T>(T data, {Duration delay = const Duration(milliseconds: 800)}) async {
    await Future.delayed(delay);
    return data;
  }

  /// Simulate API error for testing
  static Future<T> simulateApiError<T>({Duration delay = const Duration(milliseconds: 500)}) async {
    await Future.delayed(delay);
    throw Exception('Simulated API error for testing');
  }
}
