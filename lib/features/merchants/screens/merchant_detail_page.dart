import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../models/top_merchant.dart';
import '../../../models/menu_item.dart';
import '../../../data/sample_data.dart';

/// Merchant Detail Page
/// 
/// This page displays detailed information about a merchant with:
/// - Blurred background image
/// - Modal-style white container overlay
/// - Merchant info, status, stats
/// - Search and filter functionality
/// - Menu/product items list
/// 
/// Flexible design works for all merchant types:
/// - Restaurants (food items)
/// - Shops (products)
/// - Pharmacies (medicines)
/// - Any other merchant type
class MerchantDetailPage extends StatefulWidget {
  const MerchantDetailPage({
    super.key,
    required this.merchant,
  });

  /// The merchant to display details for
  final TopMerchant merchant;

  @override
  State<MerchantDetailPage> createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends State<MerchantDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  /// Current search query
  String _searchQuery = '';
  
  /// Selected category filter
  String _selectedCategory = 'Tout';
  
  
  /// Current menu items
  List<MenuItem> _menuItems = [];
  
  /// Cart items with quantities
  Map<String, int> _cartItems = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadMerchantData();
  }

  /// Initialize animation controllers
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

  /// Load merchant-specific data
  void _loadMerchantData() {
    // Get menu items for this merchant from sample data
    _menuItems = SampleData.getMenuItemsForMerchant(widget.merchant.id);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          _buildBlurredBackground(),
          
          // Floating action buttons
          _buildFloatingActions(),
          
          // Floating cart button
          _buildFloatingCartButton(),
          
          // Detached top info card
          _buildDetachedInfoCard(),
          
          // Bottom sheet only
          _buildBottomSheet(),
        ],
      ),
    );
  }

  /// Build blurred background image with enhanced cooking pan effect and white gradient
  Widget _buildBlurredBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.merchant.imageUrl != null && widget.merchant.imageUrl!.startsWith('http')
              ? NetworkImage(widget.merchant.imageUrl!)
              : AssetImage(widget.merchant.imageUrl ?? 'assets/images/product_1.png') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, // Start from top
                  end: Alignment.bottomCenter, // End at bottom
                  colors: [
                    Colors.transparent, // Top: Completely transparent (0% opacity)
                    Colors.white.withValues(alpha: 0.0), // Top area: Clear image detail
                    Colors.white.withValues(alpha: 0.3), // Middle: Gradual fade transition
                    Colors.white.withValues(alpha: 0.6), // Middle-bottom: Stronger fade
                    Colors.white.withValues(alpha: 0.8), // Bottom: Strong white overlay (80% opacity)
                  ],
                  stops: const [0.0, 0.2, 0.5, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build floating action buttons (back and heart)
  Widget _buildFloatingActions() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.space5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: DesignTokens.shadowSm,
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: DesignTokens.neutral700,
                  size: 24.w,
                ),
              ),
            ),
            
            // Heart button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: DesignTokens.shadowSm,
              ),
              child: IconButton(
                onPressed: _handleFavoriteTap,
                icon: Icon(
                  widget.merchant.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.merchant.isFavorite ? Colors.red : DesignTokens.neutral700,
                  size: 24.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build detached top info card
  Widget _buildDetachedInfoCard() {
    return Positioned(
      top: 100.h, // Position closer to floating action buttons
      left: DesignTokens.space5.w,
      right: DesignTokens.space5.w,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DesignTokens.radius2xl.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: _buildFixedInfoCard(),
          ),
        ),
      ),
    );
  }

  /// Build bottom sheet only (without top card)
  Widget _buildBottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DesignTokens.radius3xl.r),
              topRight: Radius.circular(DesignTokens.radius3xl.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // Drag handle
                  Container(
                      padding: EdgeInsets.symmetric(vertical: DesignTokens.space3.h),
                      child: Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: DesignTokens.neutral300,
                            borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                  
                  // Scrollable content
                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                  // Search section
                  _buildSearchSection(),
                  
                  // Filter chips
                  _buildFilterChips(),
                  
                  // Menu items list
                  _buildMenuList(),
                  
                  // Bottom spacing
                  SliverToBoxAdapter(
                    child: SizedBox(height: DesignTokens.space8.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build fixed info card at top of modal
  Widget _buildFixedInfoCard() {
    return Container(
      padding: EdgeInsets.all(DesignTokens.space5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Merchant logo/icon
                Container(
                width: 70.w,
                height: 70.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignTokens.neutral100,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  ),
                  child: widget.merchant.imageUrl != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(35.r),
                          child: widget.merchant.imageUrl!.startsWith('http')
                              ? Image.network(
                                  widget.merchant.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => _buildDefaultIcon(),
                                )
                              : Image.asset(
                                  widget.merchant.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => _buildDefaultIcon(),
                                ),
                        )
                      : _buildDefaultIcon(),
                ),
                
                SizedBox(width: DesignTokens.space4.w),
                
                // Merchant info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Merchant name
                      Text(
                      'Restaurant les 2A', // Using Figma design name
                        style: TextStyle(
                          fontSize: DesignTokens.fontSize2xl.sp,
                          fontWeight: DesignTokens.fontWeightBold,
                          color: DesignTokens.neutral900,
                          fontFamily: DesignTokens.fontFamilyPrimary,
                        ),
                      ),
                      
                    SizedBox(height: DesignTokens.space2.h),
                    
                    // Status with green color
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.space3.w,
                        vertical: DesignTokens.space1.h,
                      ),
                      decoration: BoxDecoration(
                        color: DesignTokens.success50,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
                      ),
                      child: Text(
                        'Ouvert actuellement',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm.sp,
                          fontWeight: DesignTokens.fontWeightMedium,
                          color: DesignTokens.success700,
                          fontFamily: DesignTokens.fontFamilyPrimary,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: DesignTokens.space4.h),
            
          // Location and Rating row
          Row(
            children: [
            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16.w,
                  color: Colors.red,
                ),
                SizedBox(width: DesignTokens.space2.w),
                Text(
                  'Nukafu, Nukafu',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    color: DesignTokens.neutral600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
            
              SizedBox(width: DesignTokens.space6.w),
            
            // Rating
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16.w,
                  color: DesignTokens.warning500,
                ),
                SizedBox(width: DesignTokens.space2.w),
                Text(
                  '${widget.merchant.rating}',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.neutral900,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                SizedBox(width: DesignTokens.space1.w),
                Text(
                  '(250+ avis)',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    color: DesignTokens.neutral500,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
          
          SizedBox(height: DesignTokens.space4.h),
          
          // Stats row
          _buildStatsRow(),
        ],
      ),
    );
  }


  /// Build default merchant icon
  Widget _buildDefaultIcon() {
    return Icon(
      Icons.store,
      size: 32.w,
      color: DesignTokens.primary500,
    );
  }

  /// Build stats row (price, distance, time) - clean version
  Widget _buildStatsRow() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn('200', 'FCFA', 'Achat min'),
            _buildStatDivider(),
            _buildStatColumn('1,5', 'km', 'Distance'),
            _buildStatDivider(),
            _buildStatColumn('25', 'min', 'Temps de livraison'),
          ],
    );
  }

  /// Build individual stat column
  Widget _buildStatColumn(String value, String unit, String label) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXl.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral900,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightMedium,
                  color: DesignTokens.neutral900,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DesignTokens.space1.h),
        Text(
          label,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            color: DesignTokens.neutral500,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
      ],
    );
  }

  /// Build stat divider
  Widget _buildStatDivider() {
    return Container(
      width: 1.w,
      height: 40.h,
      color: DesignTokens.neutral200,
    );
  }

  /// Build enhanced search section
  Widget _buildSearchSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.space5.w,
          vertical: DesignTokens.space4.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: DesignTokens.neutral50,
            borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
            border: Border.all(color: DesignTokens.neutral200),
          ),
          child: TextField(
            onChanged: _handleSearchChanged,
            decoration: InputDecoration(
          hintText: 'Recherche rapide',
              hintStyle: TextStyle(
                color: DesignTokens.neutral500,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: DesignTokens.neutral500,
                size: 20.w,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DesignTokens.space4.w,
                vertical: DesignTokens.space3.h,
              ),
            ),
            style: TextStyle(
              fontFamily: DesignTokens.fontFamilyPrimary,
              fontSize: DesignTokens.fontSizeBase.sp,
            ),
          ),
        ),
      ),
    );
  }

  /// Build enhanced filter chips matching Figma design
  Widget _buildFilterChips() {
    // Use Figma design categories
    final figmaCategories = ['Tout', 'Noodles', 'Riz', 'Boissons'];
    
    return SliverToBoxAdapter(
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
          itemCount: figmaCategories.length,
          itemBuilder: (context, index) {
            final category = figmaCategories[index];
            final isSelected = category == _selectedCategory;
            
            return Container(
              margin: EdgeInsets.only(right: DesignTokens.space3.w),
              child: GestureDetector(
                onTap: () => _handleCategorySelected(category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.space4.w,
                    vertical: DesignTokens.space2.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? DesignTokens.primary500 : Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: isSelected ? DesignTokens.primary500 : DesignTokens.neutral300,
                      width: isSelected ? 0 : 1.5, // No border when selected
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: DesignTokens.primary500.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ] : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                  color: isSelected ? Colors.white : DesignTokens.neutral700,
                        fontWeight: isSelected ? DesignTokens.fontWeightSemiBold : DesignTokens.fontWeightMedium,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                        fontSize: DesignTokens.fontSizeSm.sp,
                      ),
                ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build menu items list
  Widget _buildMenuList() {
    final filteredItems = _getFilteredItems();
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = filteredItems[index];
          return _buildMenuItem(item);
        },
        childCount: filteredItems.length,
      ),
    );
  }

  /// Build individual menu item with Figma design
  Widget _buildMenuItem(MenuItem item) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: DesignTokens.space5.w,
        vertical: DesignTokens.space3.h,
      ),
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Square item image
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
              color: DesignTokens.neutral100,
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
                    child: item.imageUrl!.startsWith('http')
                        ? Image.network(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildDefaultFoodIcon(),
                          )
                        : Image.asset(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildDefaultFoodIcon(),
                          ),
                  )
                : _buildDefaultFoodIcon(),
          ),
          
          SizedBox(width: DesignTokens.space4.w),
          
          // Item info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg.sp,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.neutral900,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                SizedBox(height: DesignTokens.space2.h),
                Text(
                  '1 600 FCFA', // Using Figma design price format
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg.sp,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.success500, // Green color for price
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
          ),
          
          // Add button with enhanced design
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DesignTokens.primary500,
              boxShadow: [
                BoxShadow(
                  color: DesignTokens.primary500.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => _handleAddItem(item),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build default food icon
  Widget _buildDefaultFoodIcon() {
    return Icon(
      Icons.restaurant,
      size: 40.w,
      color: DesignTokens.primary500,
    );
  }

  /// Get filtered menu items
  List<MenuItem> _getFilteredItems() {
    var items = _menuItems;
    
    // Filter by category
    if (_selectedCategory != 'Tout') {
      items = items.where((item) => item.category == _selectedCategory).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      items = items.where((item) {
        return item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               (item.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }
    
    return items;
  }

  /// Handle search query change
  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  /// Handle category selection
  void _handleCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  /// Handle favorite tap
  void _handleFavoriteTap() {
    // TODO: Toggle favorite status
    debugPrint('[MerchantDetailPage] Favorite tapped for ${widget.merchant.id}');
  }

  /// Handle add item to cart
  void _handleAddItem(MenuItem item) {
    setState(() {
      _cartItems[item.id] = (_cartItems[item.id] ?? 0) + 1;
    });
    
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item.name} ajouté au panier',
          style: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
        backgroundColor: DesignTokens.success500,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        ),
      ),
    );
    
    debugPrint('[MerchantDetailPage] Add item: ${item.name} - Quantity: ${_cartItems[item.id]}');
  }
  
  /// Get total cart items count
  int get _totalCartItems {
    return _cartItems.values.fold(0, (sum, quantity) => sum + quantity);
  }
  
  /// Build floating cart button
  Widget _buildFloatingCartButton() {
    if (_totalCartItems == 0) return const SizedBox.shrink();
    
    return Positioned(
      bottom: 120.h, // Position above the bottom sheet
      right: DesignTokens.space5.w,
      child: Container(
        decoration: BoxDecoration(
          color: DesignTokens.primary500,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: DesignTokens.primary500.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            IconButton(
              onPressed: _handleCartTap,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 24.w,
              ),
            ),
            if (_totalCartItems > 0)
              Positioned(
                right: 8.w,
                top: 8.h,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20.w,
                    minHeight: 20.w,
                  ),
                  child: Center(
                    child: Text(
                      '$_totalCartItems',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: DesignTokens.fontWeightBold,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  /// Handle cart button tap
  void _handleCartTap() {
    // TODO: Navigate to cart screen
    debugPrint('[MerchantDetailPage] Cart tapped - Items: $_totalCartItems');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Panier: $_totalCartItems articles',
          style: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
        backgroundColor: DesignTokens.primary500,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        ),
      ),
    );
  }
}
