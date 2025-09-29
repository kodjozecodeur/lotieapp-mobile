import '../data/sample_data.dart';

/// Search result types
enum SearchResultType {
  merchant,
  product,
  category,
}

/// Search result model
class SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final SearchResultType type;
  final dynamic data; // The actual data object

  const SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.type,
    required this.data,
  });
}

/// Search service for handling search functionality
/// 
/// This service provides search capabilities across:
/// - Merchants (restaurants, supermarkets)
/// - Products (menu items)
/// - Categories
/// 
/// Uses fuzzy matching and keyword-based search.
class SearchService {
  static final SearchService _instance = SearchService._internal();
  factory SearchService() => _instance;
  SearchService._internal();

  /// Search across all available data
  List<SearchResult> search(String query) {
    if (query.trim().isEmpty) return [];

    final normalizedQuery = query.toLowerCase().trim();
    final results = <SearchResult>[];

    // Search merchants
    results.addAll(_searchMerchants(normalizedQuery));
    
    // Search products
    results.addAll(_searchProducts(normalizedQuery));
    
    // Search categories
    results.addAll(_searchCategories(normalizedQuery));

    // Sort by relevance (exact matches first, then partial matches)
    results.sort((a, b) {
      final aExact = a.title.toLowerCase() == normalizedQuery;
      final bExact = b.title.toLowerCase() == normalizedQuery;
      
      if (aExact && !bExact) return -1;
      if (!aExact && bExact) return 1;
      
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });

    return results;
  }

  /// Search through merchants
  List<SearchResult> _searchMerchants(String query) {
    final results = <SearchResult>[];
    
    // Search top merchants
    for (final merchant in SampleData.topMerchantsList) {
      if (_matchesQuery(merchant.businessName, query) ||
          _matchesQuery(merchant.category, query) ||
          _matchesQuery(merchant.subcategory, query)) {
        results.add(SearchResult(
          id: 'merchant_${merchant.id}',
          title: merchant.businessName,
          subtitle: '${merchant.category} • ${merchant.duration}',
          imageUrl: merchant.imageUrl,
          type: SearchResultType.merchant,
          data: merchant,
        ));
      }
    }

    // Search supermarkets
    for (final merchant in SampleData.supermarketsList) {
      if (_matchesQuery(merchant.businessName, query) ||
          _matchesQuery(merchant.category, query) ||
          _matchesQuery(merchant.subcategory, query)) {
        results.add(SearchResult(
          id: 'merchant_${merchant.id}',
          title: merchant.businessName,
          subtitle: '${merchant.category} • ${merchant.duration}',
          imageUrl: merchant.imageUrl,
          type: SearchResultType.merchant,
          data: merchant,
        ));
      }
    }

    return results;
  }

  /// Search through products
  List<SearchResult> _searchProducts(String query) {
    final results = <SearchResult>[];
    
    // Get all menu items from all merchants
    final allMerchants = [...SampleData.topMerchantsList, ...SampleData.supermarketsList];
    
    for (final merchant in allMerchants) {
      final menuItems = SampleData.getMenuItemsForMerchant(merchant.id);
      
      for (final item in menuItems) {
        if (_matchesQuery(item.name, query) ||
            _matchesQuery(item.description ?? '', query) ||
            _matchesQuery(item.category ?? '', query) ||
            _matchesQuery(item.tags.join(' '), query)) {
          results.add(SearchResult(
            id: 'product_${item.id}',
            title: item.name,
            subtitle: '${merchant.businessName} • ${item.price} ${item.currency}',
            imageUrl: item.imageUrl,
            type: SearchResultType.product,
            data: item,
          ));
        }
      }
    }

    return results;
  }

  /// Search through categories
  List<SearchResult> _searchCategories(String query) {
    final results = <SearchResult>[];
    
    for (final category in SampleData.categories) {
      if (_matchesQuery(category.name, query)) {
        results.add(SearchResult(
          id: 'category_${category.id}',
          title: category.name,
          subtitle: '${category.productCount} produits',
          imageUrl: category.iconPath,
          type: SearchResultType.category,
          data: category,
        ));
      }
    }

    return results;
  }

  /// Check if text matches query (fuzzy matching)
  bool _matchesQuery(String text, String query) {
    final normalizedText = text.toLowerCase();
    
    // Exact match
    if (normalizedText == query) return true;
    
    // Contains match
    if (normalizedText.contains(query)) return true;
    
    // Word boundary match
    final words = normalizedText.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.startsWith(query)) return true;
    }
    
    // Partial word match
    for (final word in words) {
      if (word.contains(query)) return true;
    }
    
    return false;
  }

  /// Get search suggestions based on query
  List<String> getSuggestions(String query) {
    if (query.trim().isEmpty) return _getPopularSearches();
    
    final normalizedQuery = query.toLowerCase().trim();
    final suggestions = <String>{};
    
    // Add exact matches first
    final results = search(query);
    for (final result in results.take(5)) {
      suggestions.add(result.title);
    }
    
    // Add popular searches that contain the query
    for (final popular in _getPopularSearches()) {
      if (popular.toLowerCase().contains(normalizedQuery)) {
        suggestions.add(popular);
      }
    }
    
    return suggestions.take(8).toList();
  }

  /// Get popular search terms
  List<String> _getPopularSearches() {
    return [
      'iPhone 17 Pro Max',
      'Riz frit',
      'Parfum Zara',
      'Salade de fruits',
      'Pizza',
      'Burger',
      'Chicken',
      'Poulet',
      'Restaurant',
      'Supermarché',
      'Pharmacie',
      'Livraison',
    ];
  }

  /// Get trending searches
  List<String> getTrendingSearches() {
    return [
      'iPhone 17 Pro Max',
      'Riz frit',
      'Parfum Zara',
      'Salade de fruits',
    ];
  }
}
