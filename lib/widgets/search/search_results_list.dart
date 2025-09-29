import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/design_tokens.dart';
import '../../services/search_service.dart';
import '../../models/top_merchant.dart';
import '../../models/menu_item.dart';
import '../../models/category.dart';
import 'search_result_item.dart';

/// Search results list widget
/// 
/// Displays search results with:
/// - Loading state
/// - Empty state
/// - Results grouped by type
/// - Navigation handling
class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    super.key,
    required this.results,
    required this.isLoading,
    required this.hasSearched,
    this.onResultTap,
  });

  final List<SearchResult> results;
  final bool isLoading;
  final bool hasSearched;
  final Function(SearchResult)? onResultTap;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (!hasSearched) {
      return _buildEmptyState();
    }

    if (results.isEmpty) {
      return _buildNoResultsState();
    }

    return _buildResultsList();
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary500),
            ),
          ),
          SizedBox(height: DesignTokens.space4.h),
          Text(
            'Recherche en cours...',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state (no search yet)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64.w,
            color: DesignTokens.neutral300,
          ),
          SizedBox(height: DesignTokens.space4.h),
          Text(
            'Recherchez des produits, marchands ou catégories',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build no results state
  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.w,
            color: DesignTokens.neutral300,
          ),
          SizedBox(height: DesignTokens.space4.h),
          Text(
            'Aucun résultat trouvé',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeLg.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral700,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
          SizedBox(height: DesignTokens.space2.h),
          Text(
            'Essayez avec d\'autres mots-clés',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightRegular,
              color: DesignTokens.neutral500,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build results list
  Widget _buildResultsList() {
    // Group results by type
    final merchants = results.where((r) => r.type == SearchResultType.merchant).toList();
    final products = results.where((r) => r.type == SearchResultType.product).toList();
    final categories = results.where((r) => r.type == SearchResultType.category).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(DesignTokens.space5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results count
          Text(
            '${results.length} résultat${results.length > 1 ? 's' : ''} trouvé${results.length > 1 ? 's' : ''}',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
          ),
          
          SizedBox(height: DesignTokens.space4.h),
          
          // Merchants section
          if (merchants.isNotEmpty) ...[
            _buildSectionHeader('Marchands', merchants.length),
            SizedBox(height: DesignTokens.space3.h),
            ...merchants.map((result) => SearchResultItem(
              result: result,
              onTap: () => _handleResultTap(result),
            )),
            SizedBox(height: DesignTokens.space6.h),
          ],
          
          // Products section
          if (products.isNotEmpty) ...[
            _buildSectionHeader('Produits', products.length),
            SizedBox(height: DesignTokens.space3.h),
            ...products.map((result) => SearchResultItem(
              result: result,
              onTap: () => _handleResultTap(result),
            )),
            SizedBox(height: DesignTokens.space6.h),
          ],
          
          // Categories section
          if (categories.isNotEmpty) ...[
            _buildSectionHeader('Catégories', categories.length),
            SizedBox(height: DesignTokens.space3.h),
            ...categories.map((result) => SearchResultItem(
              result: result,
              onTap: () => _handleResultTap(result),
            )),
          ],
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral900,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        SizedBox(width: DesignTokens.space2.w),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.space2.w,
            vertical: DesignTokens.space1.h,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.primary500,
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: Colors.white,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Handle result tap
  void _handleResultTap(SearchResult result) {
    if (onResultTap != null) {
      onResultTap!(result);
      return;
    }

    // Default navigation behavior
    switch (result.type) {
      case SearchResultType.merchant:
        final merchant = result.data as TopMerchant;
        // Navigate to merchant detail page
        // This would need to be implemented with proper context
        print('[SearchResultsList] Navigate to merchant: ${merchant.businessName}');
        break;
      case SearchResultType.product:
        final product = result.data as MenuItem;
        // Navigate to product detail or merchant with product
        print('[SearchResultsList] Navigate to product: ${product.name}');
        break;
      case SearchResultType.category:
        final category = result.data as Category;
        // Navigate to category page
        print('[SearchResultsList] Navigate to category: ${category.name}');
        break;
    }
  }
}
