import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../widgets/home/home_header.dart';
import '../../../widgets/home/search_bar_widget.dart';
import '../../../widgets/home/category_grid.dart';
import '../../../widgets/home/section_header.dart';
import '../../../widgets/home/horizontal_product_list.dart';
import '../../../data/sample_data.dart';

/// Accueil (Home) page - main dashboard of the app
/// 
/// This page displays the main home screen with:
/// - Header with greeting, location, pass status
/// - Search bar
/// - Category grid
/// - Top merchants section
/// - Promotions section
/// - Recommended products section
/// 
/// Uses modular components with DesignTokens for styling.
class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Home Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: DesignTokens.space4.h,
                left: DesignTokens.space5.w,
                right: DesignTokens.space5.w,
              ),
              child: const HomeHeader(),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: DesignTokens.space2.w,),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radius2xl.r),
                  boxShadow: DesignTokens.shadowSm,
                ),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: EdgeInsets.all(DesignTokens.space4.w),
                      child: const SearchBarWidget(),
                    ),
                    
                    // Spacing between search bar and category grid
                    SizedBox(height: DesignTokens.space6.h),
                    
                    // Category Grid
                    Padding(
                      padding: EdgeInsets.only(
                        left: DesignTokens.space4.w,
                        right: DesignTokens.space4.w,
                        bottom: DesignTokens.space4.w,
                      ),
                      child: CategoryGrid(
                        categories: SampleData.categories,
                        onCategoryTapped: _handleCategoryTap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(height: DesignTokens.space4.h),
          ),

          // Top Marchands Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: DesignTokens.space2.w,),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DesignTokens.radius2xl.r),
                  boxShadow: DesignTokens.shadowSm,
                ),
                child: Column(
                  children: [
                    // Section Header
                    Padding(
                      padding: EdgeInsets.all(DesignTokens.space4.w),
                      child: SectionHeader(
                        title: 'Top Marchands',
                        onSeeAllTapped: _handleSeeAllMerchants,
                      ),
                    ),
                    
                    // Horizontal Product List
                    Padding(
                      padding: EdgeInsets.only(
                        left: DesignTokens.space4.w,
                        right: DesignTokens.space4.w,
                        bottom: DesignTokens.space4.w,
                      ),
                      child: HorizontalProductList(
                        merchants: SampleData.topMerchants,
                        onMerchantTapped: _handleMerchantTap,
                        onFavoriteTapped: _handleFavoriteTap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(height: DesignTokens.space6.h),
          ),

          // Promotions Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
              child: SectionHeader(
                title: 'Promotions',
                onSeeAllTapped: _handleSeeAllPromotions,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: DesignTokens.space4.h),
          ),

          SliverToBoxAdapter(
            child: HorizontalProductList(
              products: SampleData.promotionProducts,
              onProductTapped: _handleProductTap,
              onFavoriteTapped: _handleFavoriteTap,
            ),
          ),

          // Spacing
          SliverToBoxAdapter(
            child: SizedBox(height: DesignTokens.space6.h),
          ),

          // Recommended Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
              child: SectionHeader(
                title: 'Recommandés pour vous',
                onSeeAllTapped: _handleSeeAllRecommended,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: DesignTokens.space4.h),
          ),

          SliverToBoxAdapter(
            child: HorizontalProductList(
              products: SampleData.recommendedProducts,
              onProductTapped: _handleProductTap,
              onFavoriteTapped: _handleFavoriteTap,
            ),
          ),

          // Bottom spacing for floating navbar
          SliverToBoxAdapter(
            child: SizedBox(
              height: DesignTokens.bottomNavHeight.h + 
                      DesignTokens.space8.h + 
                      MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }

  /// Handle category tap
  void _handleCategoryTap(String categoryId) {
    // TODO: Navigate to category page or filter products
    debugPrint('Category tapped: $categoryId');
  }

  /// Handle see all merchants
  void _handleSeeAllMerchants() {
    // TODO: Navigate to merchants list page
    debugPrint('See all merchants tapped');
  }

  /// Handle see all promotions
  void _handleSeeAllPromotions() {
    // TODO: Navigate to promotions page
    debugPrint('See all promotions tapped');
  }

  /// Handle see all recommended
  void _handleSeeAllRecommended() {
    // TODO: Navigate to recommended products page
    debugPrint('See all recommended tapped');
  }

  /// Handle merchant tap
  void _handleMerchantTap(String merchantId) {
    // TODO: Navigate to merchant detail page
    debugPrint('Merchant tapped: $merchantId');
  }

  /// Handle product tap
  void _handleProductTap(String productId) {
    // TODO: Navigate to product detail page
    debugPrint('Product tapped: $productId');
  }

  /// Handle favorite tap
  void _handleFavoriteTap(String itemId) {
    // TODO: Toggle favorite status
    debugPrint('Favorite tapped: $itemId');
  }
}
