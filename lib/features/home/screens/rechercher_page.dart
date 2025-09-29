import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../widgets/home/search_bar_widget.dart';
import '../../../widgets/home/category_grid.dart';
import '../../../widgets/search/search_results_list.dart';
import '../../../data/sample_data.dart';
import '../../../providers/search_provider.dart';
import '../../../services/search_service.dart';

/// Rechercher (Search) page
/// 
/// This page contains the search functionality with:
/// - Header with back arrow and title
/// - Search bar with magnifying glass icon
/// - Trending searches section with pill-shaped buttons
/// - Categories section with horizontal scrollable cards
class RechercherPage extends ConsumerStatefulWidget {
  const RechercherPage({super.key});

  @override
  ConsumerState<RechercherPage> createState() => _RechercherPageState();
}

class _RechercherPageState extends ConsumerState<RechercherPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Handle search text changes with debouncing
  void _handleSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchProvider.notifier).updateQuery(query);
      if (query.isNotEmpty) {
        ref.read(searchProvider.notifier).search(query);
      }
    });
  }

  /// Handle search submission
  void _handleSearchSubmitted(String query) {
    _debounceTimer?.cancel();
    ref.read(searchProvider.notifier).search(query);
  }

  /// Handle filter button tap
  void _handleFilterTapped() {
    print('[RechercherPage] Filter tapped');
    // TODO: Implement filter functionality
  }

  /// Handle category tap
  void _handleCategoryTap(String categoryId) {
    final category = SampleData.getCategoryById(categoryId);
    if (category != null) {
      ref.read(searchProvider.notifier).searchCategory(category.name);
    }
  }

  /// Handle trending search tap
  void _handleTrendingSearchTap(String trendingItem) {
    _searchController.text = trendingItem;
    ref.read(searchProvider.notifier).searchTrending(trendingItem);
  }

  /// Handle search result tap
  void _handleSearchResultTap(SearchResult result) {
    switch (result.type) {
      case SearchResultType.merchant:
        final merchant = result.data;
        context.push('/merchant/${merchant.id}');
        break;
      case SearchResultType.product:
        final product = result.data;
        // Find the merchant that has this product
        final allMerchants = [...SampleData.topMerchantsList, ...SampleData.supermarketsList];
        for (final merchant in allMerchants) {
          final menuItems = SampleData.getMenuItemsForMerchant(merchant.id);
          if (menuItems.any((item) => item.id == product.id)) {
            context.push('/merchant/${merchant.id}');
            break;
          }
        }
        break;
      case SearchResultType.category:
        final category = result.data;
        // Navigate to category page or filter by category
        print('[RechercherPage] Navigate to category: ${category.name}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            SizedBox(height: DesignTokens.space6.h),
            
            // Search Bar
            _buildSearchBar(),
            
            SizedBox(height: DesignTokens.space6.h),
            
            // Content based on search state
            Expanded(
              child: searchState.hasSearched || searchState.query.isNotEmpty
                  ? SearchResultsList(
                      results: searchState.results,
                      isLoading: searchState.isLoading,
                      hasSearched: searchState.hasSearched,
                      onResultTap: _handleSearchResultTap,
                    )
                  : _buildInitialContent(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build initial content (trending searches and categories)
  Widget _buildInitialContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending Searches Section
          _buildTrendingSearches(),
          
          SizedBox(height: DesignTokens.space8.h),
          
          // Categories Section
          _buildCategoriesSection(),
          
          SizedBox(height: DesignTokens.space8.h),
        ],
      ),
    );
  }

  /// Build header with back arrow and title
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space5.w,
        vertical: DesignTokens.space4.h,
      ),
      child: Row(
        children: [
          // Back arrow button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: DesignTokens.neutral200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20.w,
                color: DesignTokens.neutral800,
              ),
            ),
          ),
          
          // Title
          Expanded(
            child: Text(
              'Recherche',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: DesignTokens.fontSize2xl.sp,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.neutral900,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ),
          
          // Spacer to balance the back button
          SizedBox(width: 40.w),
        ],
      ),
    );
  }

  /// Build search bar using the existing SearchBarWidget
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
      child: SearchBarWidget(
        hintText: 'Restaurants, pharmacies, etc.',
        onSearchChanged: _handleSearchChanged,
        onSearchSubmitted: _handleSearchSubmitted,
        onFilterTapped: _handleFilterTapped,
      ),
    );
  }

  /// Build trending searches section
  Widget _buildTrendingSearches() {
    final searchState = ref.watch(searchProvider);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Recherche tendance',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeLg.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
          
          SizedBox(height: DesignTokens.space4.h),
          
          // Trending search pills in 2x2 grid
          Row(
            children: [
              Expanded(
                child: Column(
                  children: searchState.trendingSearches.take(2).map((trendingItem) {
                    return Column(
                      children: [
                        _buildTrendingPill(trendingItem),
                        if (searchState.trendingSearches.indexOf(trendingItem) < 1)
                          SizedBox(height: DesignTokens.space3.h),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: DesignTokens.space3.w),
              Expanded(
                child: Column(
                  children: searchState.trendingSearches.skip(2).take(2).map((trendingItem) {
                    return Column(
                      children: [
                        _buildTrendingPill(trendingItem),
                        if (searchState.trendingSearches.indexOf(trendingItem) < 3)
                          SizedBox(height: DesignTokens.space3.h),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build individual trending search pill
  Widget _buildTrendingPill(String text) {
    return GestureDetector(
      onTap: () => _handleTrendingSearchTap(text),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.space4.w,
          vertical: DesignTokens.space3.h,
        ),
        decoration: BoxDecoration(
          color: DesignTokens.neutral50,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: DesignTokens.neutral400,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trending icon
            SvgPicture.asset(
              'assets/icons/trending.svg',
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: DesignTokens.space2.w),
            // Text
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: DesignTokens.neutral900,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build categories section using the existing CategoryGrid
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
          child: Text(
            'Par catégories',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeLg.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ),
        
        SizedBox(height: DesignTokens.space4.h),
        
        // Category grid using existing component
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
          child: CategoryGrid(
            categories: SampleData.categories,
            onCategoryTapped: _handleCategoryTap,
          ),
        ),
      ],
    );
  }

}
