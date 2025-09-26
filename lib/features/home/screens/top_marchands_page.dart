import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../widgets/home/search_bar_widget.dart';
import '../../../widgets/marchands/top_merchant_card.dart';
import '../../../models/top_merchant.dart';
import '../../../data/sample_data.dart';

/// Top Marchands (Top Merchants) page
/// 
/// This page displays a comprehensive list of top merchants with:
/// - Modern Apple-style header with back navigation
/// - Search functionality for filtering merchants
/// - Grid/list view of merchants with ratings and details
/// - Smooth scrolling and animations
/// - Consistent styling following Apple HIG
/// 
/// Uses modular components with DesignTokens for styling.
class TopMarchandsPage extends StatefulWidget {
  const TopMarchandsPage({super.key});

  @override
  State<TopMarchandsPage> createState() => _TopMarchandsPageState();
}

class _TopMarchandsPageState extends State<TopMarchandsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  
  /// Search query for filtering merchants
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initialize animation controllers and animations
  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
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
          // Unified Top Container (App Bar + Search Bar)
          _buildUnifiedTopContainer(),
          
          // Merchants List
          _buildMerchantsList(),
          
          // Bottom spacing
          SliverToBoxAdapter(
            child: SizedBox(
              height: DesignTokens.space8.h + 
                      MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }

  /// Build unified top container with app bar and search bar
  Widget _buildUnifiedTopContainer() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(DesignTokens.radius2xl.r),
            bottomRight: Radius.circular(DesignTokens.radius2xl.r),
          ),
          boxShadow: DesignTokens.shadowSm,
        ),
        child: Column(
          children: [
            // App Bar Section
            _buildAppBarSection(),
            
            // Search Bar Section
            _buildSearchBarSection(),
          ],
        ),
      ),
    );
  }

  /// Build app bar section within the unified container
  Widget _buildAppBarSection() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + DesignTokens.space4.h,
        left: DesignTokens.space5.w,
        right: DesignTokens.space5.w,
        bottom: DesignTokens.space4.h,
      ),
      child: Row(
        children: [
          // Back Button
          Container(
            decoration: BoxDecoration(
              color: DesignTokens.neutral100,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                size: 20.w,
                color: DesignTokens.neutral700,
              ),
            ),
          ),
          
          // Title
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Top Marchands',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeXl.sp,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: DesignTokens.neutral850,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Spacer to balance the back button
          SizedBox(width: 48.w),
        ],
      ),
    );
  }

  /// Build search bar section within the unified container
  Widget _buildSearchBarSection() {
    return Padding(
      padding: EdgeInsets.only(
        left: DesignTokens.space5.w,
        right: DesignTokens.space5.w,
        bottom: DesignTokens.space5.h,
      ),
      child: Column(
        children: [
          // Search Bar Row
          Row(
            children: [
              // Search Bar (expanded to take most space)
              Expanded(
                child: SearchBarWidget(
                  hintText: 'Rechercher un marchand...',
                  onSearchChanged: _handleSearchChanged,
                  onFilterTapped: _handleFilterTapped,
                ),
              ),
              
              // Spacing between search bar and additional settings icon
              SizedBox(width: DesignTokens.space3.w),
              
              // Additional Settings Icon (outside search bar)
              GestureDetector(
                onTap: _handleAdditionalSettings,
                child: Container(
                  padding: EdgeInsets.all(DesignTokens.space3.w),
                  decoration: BoxDecoration(
                    color: DesignTokens.neutral100,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/search_map.svg',
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      DesignTokens.neutral850,
                      BlendMode.srcIn,
                    ),
                  )
                ),
              ),
            ],
          ),
          
          // Settings Icons Row
          // Padding(
          //   padding: EdgeInsets.only(top: DesignTokens.space4.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       // First Settings Icon
          //       _buildSettingsIcon(
          //         icon: Icons.tune,
          //         label: 'Filtres',
          //         onTap: _handleFilterSettings,
          //       ),
                
          //       // Second Settings Icon
          //       _buildSettingsIcon(
          //         icon: Icons.sort,
          //         label: 'Trier',
          //         onTap: _handleSortSettings,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Build search bar for filtering merchants
  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: DesignTokens.space2.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radius2xl.r),
            boxShadow: DesignTokens.shadowSm,
          ),
          child: Column(
            children: [
              // Search Bar Row
              Padding(
                padding: EdgeInsets.all(DesignTokens.space4.w),
                child: Row(
                  children: [
                    // Search Bar (expanded to take most space)
                    Expanded(
                      child: SearchBarWidget(
                        hintText: 'Rechercher un marchand...',
                        onSearchChanged: _handleSearchChanged,
                        onFilterTapped: _handleFilterTapped,
                      ),
                    ),
                    
                    // Spacing between search bar and additional settings icon
                    SizedBox(width: DesignTokens.space3.w),
                    
                    // Additional Settings Icon (outside search bar)
                    GestureDetector(
                      onTap: _handleAdditionalSettings,
                      child: Container(
                        padding: EdgeInsets.all(DesignTokens.space3.w),
                        decoration: BoxDecoration(
                          color: DesignTokens.neutral100,
                          borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/search_map.svg',
                          width: 20.w,
                          height: 20.h,
                          colorFilter: ColorFilter.mode(
                            DesignTokens.neutral850,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Settings Icons Row
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: DesignTokens.space4.w,
              //     right: DesignTokens.space4.w,
              //     bottom: DesignTokens.space4.w,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       // First Settings Icon
              //       _buildSettingsIcon(
              //         icon: Icons.tune,
              //         label: 'Filtres',
              //         onTap: _handleFilterSettings,
              //       ),
                    
              //       // Second Settings Icon
              //       _buildSettingsIcon(
              //         icon: Icons.sort,
              //         label: 'Trier',
              //         onTap: _handleSortSettings,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build individual settings icon button
  Widget _buildSettingsIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.space4.w,
          vertical: DesignTokens.space3.h,
        ),
        decoration: BoxDecoration(
          color: DesignTokens.neutral100,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.w,
              color: DesignTokens.neutral700,
            ),
            SizedBox(width: DesignTokens.space2.w),
            Text(
              label,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm.sp,
                fontWeight: DesignTokens.fontWeightMedium,
                color: DesignTokens.neutral700,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build merchants list as vertical scrollable cards inside a container
  Widget _buildMerchantsList() {
    final filteredMerchants = _getFilteredMerchants();
    
    if (filteredMerchants.isEmpty) {
      return _buildEmptyState();
    }

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          // horizontal: DesignTokens.space5.w,
          vertical: DesignTokens.space2.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radius2xl.r),
          boxShadow: DesignTokens.shadowSm,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: DesignTokens.space4.w,
            bottom: DesignTokens.space4.w,
            left: DesignTokens.space4.w,
            right: DesignTokens.space4.w,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredMerchants.length,
            itemBuilder: (context, index) {
              final merchant = filteredMerchants[index];
              return TopMerchantCard(
                businessName: merchant.businessName,
                category: merchant.category,
                subcategory: merchant.subcategory,
                priceFrom: merchant.priceFrom,
                distance: merchant.distance,
                duration: merchant.duration,
                rating: merchant.rating,
                imageUrl: merchant.imageUrl,
                isFavorite: merchant.isFavorite,
                onTap: () => _handleMerchantTap(merchant.id),
                onFavoriteTap: () => _handleFavoriteTap(merchant.id),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Build empty state when no merchants found
  Widget _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.space8.w),
        child: Column(
          children: [
            SizedBox(height: DesignTokens.space8.h),
            Icon(
              Icons.search_off,
              size: 64.w,
              color: DesignTokens.neutral400,
            ),
            SizedBox(height: DesignTokens.space4.h),
            Text(
              'Aucun marchand trouvé',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeLg.sp,
                fontWeight: DesignTokens.fontWeightSemiBold,
                color: DesignTokens.neutral600,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
            SizedBox(height: DesignTokens.space2.h),
            Text(
              'Essayez de modifier votre recherche',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase.sp,
                color: DesignTokens.neutral500,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get filtered merchants based on search query
  List<TopMerchant> _getFilteredMerchants() {
    if (_searchQuery.isEmpty) {
      return SampleData.topMerchantsList;
    }
    
    return SampleData.topMerchantsList.where((merchant) {
      final name = merchant.businessName.toLowerCase();
      final category = merchant.category.toLowerCase();
      final subcategory = merchant.subcategory.toLowerCase();
      final query = _searchQuery.toLowerCase();
      
      return name.contains(query) || 
             category.contains(query) || 
             subcategory.contains(query);
    }).toList();
  }

  /// Handle search query change
  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }


  /// Handle merchant card tap
  void _handleMerchantTap(String merchantId) {
    // TODO: Navigate to merchant detail page
    debugPrint('[TopMarchandsPage] Merchant tapped: $merchantId');
  }

  /// Handle favorite tap
  void _handleFavoriteTap(String merchantId) {
    // TODO: Toggle favorite status
    debugPrint('[TopMarchandsPage] Favorite tapped: $merchantId');
  }

  /// Handle filter settings tap
  void _handleFilterSettings() {
    // TODO: Show filter options modal
    debugPrint('[TopMarchandsPage] Filter settings tapped');
  }

  /// Handle sort settings tap
  void _handleSortSettings() {
    // TODO: Show sort options modal
    debugPrint('[TopMarchandsPage] Sort settings tapped');
  }

  /// Handle filter icon tap from search bar
  void _handleFilterTapped() {
    // TODO: Show quick filter options
    debugPrint('[TopMarchandsPage] Filter icon tapped');
  }

  /// Handle additional settings icon tap
  void _handleAdditionalSettings() {
    // TODO: Show additional settings menu
    debugPrint('[TopMarchandsPage] Additional settings tapped');
  }
}
