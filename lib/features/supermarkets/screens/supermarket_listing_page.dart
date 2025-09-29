import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../data/sample_data.dart';
import '../../../models/top_merchant.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/search_bar.dart' as custom;
import '../../../widgets/filter_chips.dart' as custom;
import '../../../widgets/merchant_card.dart';

/// Supermarket Listing Page
/// 
/// Displays a list of available supermarkets with search and filtering capabilities.
/// Similar to restaurant listings but adapted for retail/shopping experience.
class SupermarketListingPage extends ConsumerStatefulWidget {
  const SupermarketListingPage({super.key});

  @override
  ConsumerState<SupermarketListingPage> createState() => _SupermarketListingPageState();
}

class _SupermarketListingPageState extends ConsumerState<SupermarketListingPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  List<TopMerchant> _filteredSupermarkets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSupermarkets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Load supermarkets data
  Future<void> _loadSupermarkets() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _filteredSupermarkets = SampleData.supermarketsList;
      _isLoading = false;
    });
  }

  /// Handle search query changes
  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory.isEmpty) {
        _filteredSupermarkets = SampleData.supermarketsList;
      } else if (query.isNotEmpty && _selectedCategory.isEmpty) {
        _filteredSupermarkets = SampleData.searchSupermarkets(query);
      } else if (query.isEmpty && _selectedCategory.isNotEmpty) {
        _filteredSupermarkets = SampleData.filterSupermarketsByCategory(_selectedCategory);
      } else {
        // Both search and category filter
        final searchResults = SampleData.searchSupermarkets(query);
        _filteredSupermarkets = searchResults.where((supermarket) {
          return supermarket.productCategories.contains(_selectedCategory);
        }).toList();
      }
    });
  }

  /// Handle category filter selection
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? '' : category;
      _onSearchChanged(_searchController.text);
    });
  }

  /// Handle supermarket card tap
  void _onSupermarketTap(TopMerchant supermarket) {
    print('[SupermarketListingPage] Navigating to supermarket: ${supermarket.businessName}');
    // Navigate to merchant detail page (reuse existing flow)
    context.push('/merchant/${supermarket.id}');
  }

  /// Handle favorite toggle
  void _onFavoriteToggle(TopMerchant supermarket) {
    setState(() {
      final index = _filteredSupermarkets.indexWhere((s) => s.id == supermarket.id);
      if (index != -1) {
        _filteredSupermarkets[index] = supermarket.copyWith(
          isFavorite: !supermarket.isFavorite,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchSection(),
          // _buildFilterSection(),
          Expanded(
            child: _buildSupermarketsList(),
          ),
        ],
      ),
    );
  }

  /// Build custom app bar with back button and location
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: 'Supermarchés',
      showBackButton: true,
      onBackPressed: () => context.pop(),
      actions: [
        _buildLocationSelector(),
      ],
    );
  }

  /// Build location selector with pin icon
  Widget _buildLocationSelector() {
    return Container(
      margin: EdgeInsets.only(right: DesignTokens.space4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/location_icon.svg',
            width: 16.w,
            height: 16.h,
            colorFilter: const ColorFilter.mode(
              DesignTokens.error500,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: DesignTokens.space1.w),
          Text(
            'Agoè 2 lions',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
          SizedBox(width: DesignTokens.space1.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16.w,
            color: DesignTokens.neutral600,
          ),
        ],
      ),
    );
  }

  /// Build search section
  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(DesignTokens.space4.w),
      child: custom.SearchBar(
        controller: _searchController,
        hintText: 'Bien être, électroniques',
        onChanged: _onSearchChanged,
        prefixIcon: Icons.search,
      ),
    );
  }

  /// Build filter chips section
  Widget _buildFilterSection() {
    final categories = [
      'Tous',
      'Alimentation',
      'Bien être',
      'Électroniques',
      'Maison',
      'Mode',
      'Bébé',
      'Sport',
    ];

    return Container(
      height: 40.h,
      margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == 'Tous' 
              ? _selectedCategory.isEmpty 
              : _selectedCategory == category;
          
          return Container(
            margin: EdgeInsets.only(right: DesignTokens.space2.w),
            child: custom.FilterChip(
              label: Text(
                category,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXs.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: isSelected ? Colors.white : DesignTokens.neutral700,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (category == 'Tous') {
                  _onCategorySelected('');
                } else {
                  _onCategorySelected(category);
                }
              },
              backgroundColor: Colors.white,
              selectedColor: DesignTokens.primary500,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? DesignTokens.primary500 : DesignTokens.neutral200,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusXl.r),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build supermarkets list
  Widget _buildSupermarketsList() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_filteredSupermarkets.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4.w),
      itemCount: _filteredSupermarkets.length,
      itemBuilder: (context, index) {
        final supermarket = _filteredSupermarkets[index];
        return Container(
          margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
          child: MerchantCard(
            merchant: supermarket,
            onTap: () => _onSupermarketTap(supermarket),
            onFavoriteToggle: () => _onFavoriteToggle(supermarket),
          ),
        );
      },
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary500),
          ),
          SizedBox(height: DesignTokens.space4.h),
          Text(
            'Chargement des supermarchés...',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/supermarket.svg',
            width: 80.w,
            height: 80.h,
            colorFilter: const ColorFilter.mode(
              DesignTokens.neutral400,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: DesignTokens.space4.h),
          Text(
            'Aucun supermarché trouvé',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
          SizedBox(height: DesignTokens.space2.h),
          Text(
            'Essayez de modifier votre recherche\nou vos filtres',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
