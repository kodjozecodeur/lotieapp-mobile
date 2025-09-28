import '../models/merchant.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../models/top_merchant.dart';
import '../models/menu_item.dart';

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
      iconPath: 'assets/icons/promotion.svg',
      color: 'success500', // Green percentage icon
      sortOrder: 1,
      productCount: 45,
    ),
    Category(
      id: 'epicerie',
      name: 'Épicerie',
      iconPath: 'assets/icons/epicerie.svg',
      color: 'warning500', // Orange basket icon
      sortOrder: 2,
      productCount: 120,
    ),
    Category(
      id: 'restaurants',
      name: 'Restaurants',
      iconPath: 'assets/icons/restaurant.svg',
      color: 'error500', // Orange building icon
      sortOrder: 3,
      productCount: 78,
    ),
    Category(
      id: 'supermarche',
      name: 'Supermarché',
      iconPath: 'assets/icons/supermarket.svg',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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
      imageUrl: 'assets/images/product_1.png',
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

  /// Top merchants data for the Top Marchands page
  static const List<TopMerchant> topMerchantsList = [
    TopMerchant(
      id: 'restaurant_2a',
      businessName: 'Restaurant les 2A',
      category: 'Southern',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Fried Chicken',
      priceFrom: 'À partir de 2 000 FCFA',
      distance: '3km',
      duration: '5 min',
      rating: 4.4,
      isFavorite: false,
    ),
    TopMerchant(
      id: 'shop_zara',
      businessName: 'Shop Zara',
      category: 'Bien-être',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Habits',
      priceFrom: 'À partir de 1 500 FCFA',
      distance: '2.5km',
      duration: '8 min',
      rating: 4.2,
      isFavorite: true,
    ),
    TopMerchant(
      id: 'parfumerie_ville',
      businessName: 'Parfumerie en Ville',
      category: 'Bien-être',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Parfumerie',
      priceFrom: 'À partir de 3 500 FCFA',
      distance: '1.8km',
      duration: '3 min',
      rating: 4.6,
      isFavorite: false,
    ),
    TopMerchant(
      id: 'pharmacie_avepozo',
      businessName: 'Pharmacie Avepozo',
      category: 'Santé',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Pharmacie',
      priceFrom: 'À partir de 500 FCFA',
      distance: '4.2km',
      duration: '12 min',
      rating: 4.5,
      isFavorite: false,
    ),
    TopMerchant(
      id: 'togo_mall',
      businessName: 'Togo Mall',
      category: 'Shopping',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Centre Commercial',
      priceFrom: 'À partir de 1 000 FCFA',
      distance: '5.5km',
      duration: '15 min',
      rating: 4.3,
      isFavorite: true,
    ),
    TopMerchant(
      id: 'restaurant_delice',
      businessName: 'Restaurant Délice',
      category: 'International',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Cuisine Française',
      priceFrom: 'À partir de 4 500 FCFA',
      distance: '2.2km',
      duration: '6 min',
      rating: 4.7,
      isFavorite: false,
    ),
    TopMerchant(
      id: 'supermarche_champion',
      businessName: 'Supermarché Champion',
      category: 'Alimentation',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Supermarché',
      priceFrom: 'À partir de 800 FCFA',
      distance: '3.8km',
      duration: '10 min',
      rating: 4.1,
      isFavorite: false,
    ),
    TopMerchant(
      id: 'boulangerie_moderne',
      businessName: 'Boulangerie Moderne',
      category: 'Alimentation',
      imageUrl: 'assets/images/product_1.png',
      subcategory: 'Boulangerie',
      priceFrom: 'À partir de 300 FCFA',
      distance: '1.5km',
      duration: '4 min',
      rating: 4.8,
      isFavorite: true,
    ),
  ];

  /// Sample menu items for different merchants
  static const List<MenuItem> menuItems = [
    // Restaurant les 2A items
    MenuItem(
      id: 'resto_2a_noodles',
      name: 'Grand combo de nouilles',
      price: 1600,
      currency: 'FCFA',
      description: 'Nouilles sautées avec légumes et viande',
      imageUrl: 'assets/images/product_1.png',
      category: 'Noodles',
      preparationTime: 15,
      tags: ['populaire', 'épicé'],
    ),
    MenuItem(
      id: 'resto_2a_chicken',
      name: 'Poulet sésame',
      price: 1600,
      currency: 'FCFA',
      description: 'Poulet frit au sésame avec riz',
      imageUrl: 'assets/images/product_img_1.jpg',
      category: 'Riz',
      preparationTime: 20,
      tags: ['croustillant'],
    ),
    MenuItem(
      id: 'resto_2a_vegetables',
      name: 'Légumes sautés',
      price: 1600,
      currency: 'FCFA',
      description: 'Mélange de légumes frais sautés',
      imageUrl: 'assets/images/logo.png',
      category: 'Légumes',
      preparationTime: 10,
      tags: ['végétarien', 'santé'],
    ),
    MenuItem(
      id: 'resto_2a_drink',
      name: 'Jus de fruits frais',
      price: 500,
      currency: 'FCFA',
      description: 'Jus naturel de fruits de saison',
      imageUrl: 'assets/images/product_1.png',
      category: 'Boissons',
      preparationTime: 5,
      tags: ['rafraîchissant'],
    ),

    // Shop Zara items
    MenuItem(
      id: 'zara_tshirt',
      name: 'T-shirt coton bio',
      price: 2500,
      currency: 'FCFA',
      description: 'T-shirt 100% coton biologique',
      imageUrl: 'assets/images/product_img_1.jpg',
      category: 'Vêtements',
      tags: ['bio', 'confort'],
    ),
    MenuItem(
      id: 'zara_jeans',
      name: 'Jean slim fit',
      price: 4500,
      currency: 'FCFA',
      description: 'Jean coupe slim moderne',
      imageUrl: 'assets/images/product_1.png',
      category: 'Vêtements',
      tags: ['moderne', 'tendance'],
    ),
    MenuItem(
      id: 'zara_shoes',
      name: 'Chaussures sport',
      price: 6000,
      currency: 'FCFA',
      description: 'Baskets de sport confortables',
      imageUrl: 'assets/images/logo.png',
      category: 'Chaussures',
      tags: ['sport', 'confort'],
    ),

    // Parfumerie en Ville items
    MenuItem(
      id: 'parfum_chanel',
      name: 'Parfum Chanel No.5',
      price: 15000,
      currency: 'FCFA',
      description: 'Parfum classique et élégant',
      imageUrl: 'assets/images/product_1.png',
      category: 'Parfums',
      tags: ['luxe', 'classique'],
    ),
    MenuItem(
      id: 'parfum_lotion',
      name: 'Lotion hydratante',
      price: 3500,
      currency: 'FCFA',
      description: 'Crème hydratante pour visage',
      imageUrl: 'assets/images/product_img_1.jpg',
      category: 'Soins',
      tags: ['hydratant', 'naturel'],
    ),

    // Pharmacie Avepozo items
    MenuItem(
      id: 'pharma_paracetamol',
      name: 'Paracétamol 500mg',
      price: 800,
      currency: 'FCFA',
      description: 'Antalgique et antipyrétique',
      imageUrl: 'assets/images/logo.png',
      category: 'Médicaments',
      tags: ['ordonnance-libre'],
    ),
    MenuItem(
      id: 'pharma_vitamins',
      name: 'Vitamines C + D',
      price: 2500,
      currency: 'FCFA',
      description: 'Complément vitaminique',
      imageUrl: 'assets/images/product_1.png',
      category: 'Compléments',
      tags: ['santé', 'immunité'],
    ),
  ];

  /// Get menu items for a specific merchant
  static List<MenuItem> getMenuItemsForMerchant(String merchantId) {
    switch (merchantId) {
      case 'restaurant_2a':
        return menuItems.where((item) => item.id.startsWith('resto_2a')).toList();
      case 'shop_zara':
        return menuItems.where((item) => item.id.startsWith('zara')).toList();
      case 'parfumerie_ville':
        return menuItems.where((item) => item.id.startsWith('parfum')).toList();
      case 'pharmacie_avepozo':
        return menuItems.where((item) => item.id.startsWith('pharma')).toList();
      default:
        // Return a default set for other merchants
        return [
          const MenuItem(
            id: 'default_item_1',
            name: 'Produit 1',
            price: 1000,
            currency: 'FCFA',
            description: 'Produit de qualité',
            category: 'Général',
          ),
          const MenuItem(
            id: 'default_item_2',
            name: 'Produit 2',
            price: 1500,
            currency: 'FCFA',
            description: 'Excellent choix',
            category: 'Général',
          ),
        ];
    }
  }

  /// Get a specific menu item by ID
  static MenuItem? getMenuItemById(String itemId) {
    try {
      return menuItems.firstWhere((item) => item.id == itemId);
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

  /// Supermarket listings data
  static List<TopMerchant> get supermarketsList {
    return [
      TopMerchant(
        id: 'champion_baguida',
        businessName: 'Le Champion Baguida',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '15 km',
        duration: '15-20 min',
        rating: 4.4,
        imageUrl: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
        isFavorite: false,
        merchantType: MerchantType.supermarket,
        productCategories: ['Bien être', 'Électroniques', 'Alimentation', 'Hygiène'],
      ),
      TopMerchant(
        id: 'carrefour_lome',
        businessName: 'Carrefour Lomé',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '8 km',
        duration: '10-15 min',
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400',
        isFavorite: true,
        merchantType: MerchantType.supermarket,
        productCategories: ['Alimentation', 'Électroniques', 'Maison', 'Mode'],
      ),
      TopMerchant(
        id: 'shoprite_akodessewa',
        businessName: 'Shoprite Akodessewa',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '12 km',
        duration: '12-18 min',
        rating: 4.2,
        imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400',
        isFavorite: false,
        merchantType: MerchantType.supermarket,
        productCategories: ['Alimentation', 'Bien être', 'Bébé', 'Maison'],
      ),
      TopMerchant(
        id: 'casino_tokoin',
        businessName: 'Casino Tokoin',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '6 km',
        duration: '8-12 min',
        rating: 4.3,
        imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
        isFavorite: false,
        merchantType: MerchantType.supermarket,
        productCategories: ['Alimentation', 'Électroniques', 'Mode', 'Sport'],
      ),
      TopMerchant(
        id: 'jumbo_plaza',
        businessName: 'Jumbo Plaza',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '20 km',
        duration: '20-25 min',
        rating: 4.1,
        imageUrl: 'https://images.unsplash.com/photo-1555529902-1c8b2c4c0e8b?w=400',
        isFavorite: false,
        merchantType: MerchantType.supermarket,
        productCategories: ['Alimentation', 'Maison', 'Jardin', 'Auto'],
      ),
      TopMerchant(
        id: 'super_u_agbalepedo',
        businessName: 'Super U Agbalepedo',
        category: 'Supermarché',
        subcategory: 'Général',
        priceFrom: 'Livraison gratuite',
        distance: '10 km',
        duration: '10-15 min',
        rating: 4.5,
        imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400',
        isFavorite: true,
        merchantType: MerchantType.supermarket,
        productCategories: ['Alimentation', 'Bien être', 'Bébé', 'Électroniques'],
      ),
    ];
  }

  /// Get supermarkets by search query
  static List<TopMerchant> searchSupermarkets(String query) {
    if (query.isEmpty) return supermarketsList;
    
    final lowercaseQuery = query.toLowerCase();
    return supermarketsList.where((supermarket) {
      return supermarket.businessName.toLowerCase().contains(lowercaseQuery) ||
             supermarket.productCategories.any((category) => 
               category.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  /// Get supermarkets by category filter
  static List<TopMerchant> filterSupermarketsByCategory(String category) {
    if (category.isEmpty) return supermarketsList;
    
    return supermarketsList.where((supermarket) {
      return supermarket.productCategories.contains(category);
    }).toList();
  }
}
