import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../services/search_service.dart';

part 'search_provider.freezed.dart';

/// Search state
@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String query,
    @Default([]) List<SearchResult> results,
    @Default([]) List<String> suggestions,
    @Default([]) List<String> trendingSearches,
    @Default(false) bool isLoading,
    @Default(false) bool hasSearched,
    String? error,
  }) = _SearchState;
}

/// Search notifier
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState()) {
    _initializeTrendingSearches();
  }

  final SearchService _searchService = SearchService();

  /// Initialize trending searches
  void _initializeTrendingSearches() {
    state = state.copyWith(
      trendingSearches: _searchService.getTrendingSearches(),
    );
  }

  /// Update search query
  void updateQuery(String query) {
    state = state.copyWith(
      query: query,
      hasSearched: query.isNotEmpty,
    );

    if (query.isEmpty) {
      state = state.copyWith(
        results: [],
        suggestions: [],
      );
    } else {
      _updateSuggestions(query);
    }
  }

  /// Perform search
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(
        query: '',
        results: [],
        hasSearched: false,
        isLoading: false,
        error: null,
      );
      return;
    }

    state = state.copyWith(
      query: query,
      isLoading: true,
      error: null,
    );

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      final results = _searchService.search(query);
      
      state = state.copyWith(
        results: results,
        isLoading: false,
        hasSearched: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erreur lors de la recherche: ${e.toString()}',
      );
    }
  }

  /// Update suggestions
  void _updateSuggestions(String query) {
    final suggestions = _searchService.getSuggestions(query);
    state = state.copyWith(suggestions: suggestions);
  }

  /// Clear search
  void clearSearch() {
    state = state.copyWith(
      query: '',
      results: [],
      suggestions: [],
      hasSearched: false,
      error: null,
    );
  }

  /// Search trending item
  void searchTrending(String trendingItem) {
    search(trendingItem);
  }

  /// Search suggestion
  void searchSuggestion(String suggestion) {
    search(suggestion);
  }

  /// Search category
  void searchCategory(String categoryName) {
    search(categoryName);
  }
}

/// Search provider
final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
