import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../models/top_merchant.dart';
import '../../../models/menu_item.dart';
import '../../../data/sample_data.dart';
import '../../../providers/cart_provider.dart';
import 'item_detail_modal.dart';
import '../../../widgets/cart_snackbar.dart';
import '../../cart/screens/cart_screen.dart';

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
class MerchantDetailPage extends ConsumerStatefulWidget {
  const MerchantDetailPage({super.key, required this.merchant});

  /// The merchant to display details for
  final TopMerchant merchant;

  @override
  ConsumerState<MerchantDetailPage> createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends ConsumerState<MerchantDetailPage>
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

  /// Draggable bottom sheet state
  double _bottomSheetHeight = 0.6; // 60% of screen initially
  bool _isTopInfoVisible = true;
  bool _isDragging = false;
  double _initialDragHeight = 0.0;

  /// Animation controllers for smooth transitions
  late AnimationController _topInfoAnimationController;
  late AnimationController _bottomSheetAnimationController;
  late Animation<double> _topInfoOpacityAnimation;

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

    // New animation controllers for draggable bottom sheet
    _topInfoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _bottomSheetAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Top info animations (only opacity, no sliding)
    _topInfoOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _topInfoAnimationController,
      curve: Curves.easeInOut,
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
    _topInfoAnimationController.dispose();
    _bottomSheetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          _buildBlurredBackground(),

          // Floating action buttons
          _buildFloatingActions(),

          // Floating cart button
          if (cartState.items.isNotEmpty)
            _buildFloatingCartButton(cartState, cartNotifier),

          // Fixed top info card (only visibility changes)
          _buildDetachedInfoCard(),

          // Draggable bottom sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * _bottomSheetHeight,
            child: GestureDetector(
              onPanStart: _onDragStart,
              onPanUpdate: _onDragUpdate,
              onPanEnd: _onDragEnd,
              child: _buildDraggableBottomSheet(),
            ),
          ),
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
          image:
              widget.merchant.imageUrl != null &&
                  widget.merchant.imageUrl!.startsWith('http')
              ? NetworkImage(widget.merchant.imageUrl!)
              : AssetImage(
                      widget.merchant.imageUrl ?? 'assets/images/product_1.png',
                    )
                    as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4)),
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
                    Colors
                        .transparent, // Top: Completely transparent (0% opacity)
                    Colors.white.withValues(
                      alpha: 0.0,
                    ), // Top area: Clear image detail
                    Colors.white.withValues(
                      alpha: 0.3,
                    ), // Middle: Gradual fade transition
                    Colors.white.withValues(
                      alpha: 0.6,
                    ), // Middle-bottom: Stronger fade
                    Colors.white.withValues(
                      alpha: 0.8,
                    ), // Bottom: Strong white overlay (80% opacity)
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
                  widget.merchant.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.merchant.isFavorite
                      ? Colors.red
                      : DesignTokens.neutral700,
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
      top: 130.h, // Increased spacing from floating action buttons
      left: DesignTokens.space5.w,
      right: DesignTokens.space5.w,
      child: AnimatedBuilder(
        animation: _topInfoAnimationController,
        builder: (context, child) {
          return Opacity(
            opacity: _topInfoOpacityAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
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
          );
        },
      ),
    );
  }


  /// Build fixed info card at top of modal
  Widget _buildFixedInfoCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space5.w,
        vertical: DesignTokens.space4.h, // Further reduced vertical padding
      ),
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
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildDefaultIcon(),
                              )
                            : Image.asset(
                                widget.merchant.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildDefaultIcon(),
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
                      widget.merchant.businessName, // Dynamic merchant name
                      style: TextStyle(
                        fontSize: DesignTokens.fontSize2xl.sp,
                        fontWeight: DesignTokens.fontWeightBold,
                        color: DesignTokens.neutral900,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),

                    // Status with green color
                    Text(
                      widget.merchant.merchantType == MerchantType.supermarket 
                          ? 'Ouvert maintenant' 
                          : 'Ouvert actuellement',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm.sp,
                        fontWeight: DesignTokens.fontWeightMedium,
                        color: DesignTokens.success700,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: DesignTokens.space2.h), // Reduced spacing
          // gray separator
          Container(
            width: double.infinity,
            height: 1.w,
            color: DesignTokens.neutral200,
          ),
          SizedBox(
            height: DesignTokens.space2.h,
          ), // Reduced spacing to prevent overlap
          // Location and Rating row
          Column(
            children: [
              // Location
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.w, color: Colors.red),
                  SizedBox(width: DesignTokens.space2.w),
                  Text(
                    '${widget.merchant.distance} • ${widget.merchant.duration}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      color: DesignTokens.neutral600,
                      fontWeight: DesignTokens.fontWeightRegular,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: DesignTokens.space2.h),

              // Rating
              Row(
                children: [
                  Icon(Icons.star, size: 16.w, color: DesignTokens.warning500),
                  SizedBox(width: DesignTokens.space2.w),
                  Text(
                    '${widget.merchant.rating}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral900,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                  SizedBox(width: DesignTokens.space1.w),
                  Text(
                    '(250+ avis)',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral700,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: DesignTokens.space2.h), // Reduced spacing
          // gray separator
          Container(
            width: double.infinity,
            height: 1.w,
            color: DesignTokens.neutral200,
          ),
          SizedBox(
            height: DesignTokens.space4.h,
          ), // Reduced spacing to prevent overlap
          // Stats row
          _buildStatsRow(),
        ],
      ),
    );
  }

  /// Build default merchant icon
  Widget _buildDefaultIcon() {
    return Icon(Icons.store, size: 32.w, color: DesignTokens.primary500);
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
                  fontWeight: DesignTokens.fontWeightRegular,
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
            fontSize: DesignTokens.fontSizeBase.sp,
            color: DesignTokens.neutral700,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
      ],
    );
  }

  /// Build stat divider
  Widget _buildStatDivider() {
    return Container(width: 1.w, height: 40.h, color: DesignTokens.neutral200);
  }

  /// Build enhanced search section
  Widget _buildSearchSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space5.w,
        vertical: DesignTokens.space4.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: DesignTokens.neutral500,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
          // border: Border.all(color: DesignTokens.neutral200),
        ),
        child: TextField(
          onChanged: _handleSearchChanged,
          decoration: InputDecoration(
            hintText: widget.merchant.merchantType == MerchantType.supermarket 
                ? 'Rechercher des produits...' 
                : 'Recherche rapide',
            hintStyle: TextStyle(
              color: DesignTokens.neutral700,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
             prefixIcon: Padding(
               padding: EdgeInsets.all(12.w),
               child: SvgPicture.asset(
                 'assets/icons/search_icon.svg',
                 width: 20.w,
                 height: 20.h,
                 colorFilter: ColorFilter.mode(
                   DesignTokens.neutral850,
                   BlendMode.srcIn,
                 ),
               ),
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
    );
  }

  /// Build enhanced filter chips matching Figma design
  Widget _buildFilterChips() {
    // Use different categories based on merchant type
    final isSupermarket = widget.merchant.merchantType == MerchantType.supermarket;
    final categories = isSupermarket 
        ? ['Tout', 'Jouet', 'Electronique', 'Hygiene', 'Divers']
        : ['Tout', 'Noodles', 'Riz', 'Boissons'];

    return Container(
        height: 50.h,
        margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category == _selectedCategory;

            return Container(
              margin: EdgeInsets.only(right: DesignTokens.space2.w),
              child: GestureDetector(
                onTap: () => _handleCategorySelected(category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.space5.w,
                    vertical: DesignTokens.space2.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? DesignTokens.primary500 : Colors.white,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusFull.r,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? DesignTokens.primary600
                          : DesignTokens.neutral300,
                      width: isSelected ? 0 : 1, // No border when selected
                    ),
                    // boxShadow: isSelected
                    //     ? [
                    //         BoxShadow(
                    //           color: DesignTokens.primary500.withValues(
                    //             alpha: 0.3,
                    //           ),
                    //           blurRadius: 12,
                    //           offset: const Offset(0, 3),
                    //         ),
                    //       ]
                    //     : [
                    //         BoxShadow(
                    //           color: Colors.black.withValues(alpha: 0.05),
                    //           blurRadius: 4,
                    //           offset: const Offset(0, 1),
                    //         ),
                    //       ],
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : DesignTokens.neutral700,
                        fontWeight: isSelected
                            ? DesignTokens.fontWeightSemiBold
                            : DesignTokens.fontWeightMedium,
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
    );
  }

  /// Build menu items list
  Widget _buildMenuList() {
    final filteredItems = _getFilteredItems();
    
    // Check if this is a supermarket to use grid layout
    final isSupermarket = widget.merchant.merchantType == MerchantType.supermarket;
 
    if (isSupermarket) {
      // Grid layout for supermarkets
      return GridView.builder(
        padding: EdgeInsets.only(
          bottom: DesignTokens.space8.h,
          left: DesignTokens.space4.w,
          right: DesignTokens.space4.w,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: DesignTokens.space2.w,
          mainAxisSpacing: DesignTokens.space2.h,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return _buildSupermarketProduct(item);
        },
      );
    } else {
      // List layout for restaurants
      return ListView.builder(
        padding: EdgeInsets.only(
          bottom: DesignTokens.space8.h,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return _buildMenuItem(item);
        },
      );
    }
  }

  /// Build individual menu item with Figma design
  Widget _buildMenuItem(MenuItem item) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: DesignTokens.space3.w,
        vertical: DesignTokens.space3.h,
      ),
      padding: EdgeInsets.all(DesignTokens.space4.w),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withValues(alpha: 0.05),
      //       blurRadius: 10,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      child: Row(
        children: [
          // Square item image
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
              color: DesignTokens.neutral100,
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMd.r,
                    ),
                    child: item.imageUrl!.startsWith('http')
                        ? Image.network(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultFoodIcon(),
                          )
                        : Image.asset(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultFoodIcon(),
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
                    fontWeight: DesignTokens.fontWeightMedium,
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
                    color: DesignTokens.primary900, // Green color for price
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
              color: DesignTokens.neutral500,
              // boxShadow: [
              //   BoxShadow(
              //     color: DesignTokens.primary500.withValues(alpha: 0.3),
              //     blurRadius: 8,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
            ),
            child: IconButton(
              onPressed: () => _handleAddItem(item),
              icon: Icon(Icons.add, color: DesignTokens.neutral850, size: 30.w),
            ),
          ),
        ],
      ),
    );
  }

  /// Build supermarket product card for grid layout
  Widget _buildSupermarketProduct(MenuItem item) {
    return GestureDetector(
      onTap: () => print('[SupermarketProduct] Tapped on ${item.name}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DesignTokens.radiusLg.r),
                    topRight: Radius.circular(DesignTokens.radiusLg.r),
                  ),
                  color: DesignTokens.neutral100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DesignTokens.radiusLg.r),
                    topRight: Radius.circular(DesignTokens.radiusLg.r),
                  ),
                  child: item.imageUrl != null
                      ? Image.asset(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildDefaultProductIcon(),
                        )
                      : _buildDefaultProductIcon(),
                ),
              ),
            ),
            
            // Product info
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(DesignTokens.space2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeXs.sp,
                        fontWeight: DesignTokens.fontWeightSemiBold,
                        color: DesignTokens.neutral900,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const Spacer(),
                    
                    // Price and add button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Text(
                          '${item.price} ${item.currency}',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeXs.sp,
                            fontWeight: DesignTokens.fontWeightBold,
                            color: DesignTokens.primary500,
                            fontFamily: DesignTokens.fontFamilyPrimary,
                          ),
                        ),
                        
                        // Add button
                        GestureDetector(
                          onTap: () => _handleAddSupermarketItem(item),
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: DesignTokens.primary500,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 14.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get category color for badges
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Jouet':
        return DesignTokens.warning500;
      case 'Electronique':
        return DesignTokens.info500;
      case 'Hygiene':
        return DesignTokens.success500;
      case 'Divers':
        return DesignTokens.neutral600;
      default:
        return DesignTokens.primary500;
    }
  }

  /// Build default product icon
  Widget _buildDefaultProductIcon() {
    return Icon(Icons.shopping_bag, size: 40.w, color: DesignTokens.primary500);
  }

  /// Build default food icon
  Widget _buildDefaultFoodIcon() {
    return Icon(Icons.restaurant, size: 40.w, color: DesignTokens.primary500);
  }

  /// Get filtered menu items
  List<MenuItem> _getFilteredItems() {
    var items = _menuItems;

    // Filter by category
    if (_selectedCategory != 'Tout') {
      items = items
          .where((item) => item.category == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      items = items.where((item) {
        return item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (item.description?.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ??
                false);
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
    debugPrint(
      '[MerchantDetailPage] Favorite tapped for ${widget.merchant.id}',
    );
  }

  /// Handle add item to cart - now shows modal for customization
  void _handleAddItem(MenuItem item) {
    final cartNotifier = ref.read(cartProvider.notifier);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ItemDetailModal(
        menuItem: item,
        onAddToCart: (item, supplements) {
          _handleAddToCartWithSupplements(item, supplements, cartNotifier);
          // Show snackbar after modal closes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showCartSnackbar();
          });
        },
      ),
    );
    
    debugPrint('[MerchantDetailPage] Opening item detail modal for: ${item.name}');
  }

  /// Handle direct add to cart for supermarket items (no modal)
  void _handleAddSupermarketItem(MenuItem item) {
    final cartNotifier = ref.read(cartProvider.notifier);
    
    // Add item directly to cart without customization modal
    cartNotifier.addItem(
      menuItem: item,
      customizations: {}, // No customizations for supermarket items
      basePrice: item.price,
      customizationPrices: {}, // No customization prices
      context: 'supermarket', // Set context to supermarket
    );

    // Show success feedback
    _showCartSnackbar();
    
    // Add haptic feedback
    HapticFeedback.lightImpact();
    
    debugPrint('[MerchantDetailPage] Added supermarket item to cart: ${item.name}');
  }

  /// Handle drag start for bottom sheet
  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
    _initialDragHeight = _bottomSheetHeight;
    print('[MerchantDetailPage] Drag started, initial height: $_initialDragHeight');
  }

  /// Handle drag update for bottom sheet
  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final screenHeight = MediaQuery.of(context).size.height;
    final deltaY = -details.delta.dy / screenHeight; // Negative because we're dragging up
    final newHeight = (_bottomSheetHeight + deltaY).clamp(0.3, 1.0);
    
    setState(() {
      _bottomSheetHeight = newHeight;
      
      // Hide top info when sheet is > 70% of screen (earlier for better UX)
      final shouldHideTopInfo = _bottomSheetHeight > 0.7;
      if (shouldHideTopInfo != !_isTopInfoVisible) {
        _isTopInfoVisible = !shouldHideTopInfo;
        if (shouldHideTopInfo) {
          _topInfoAnimationController.forward();
        } else {
          _topInfoAnimationController.reverse();
        }
      }
    });
  }

  /// Handle drag end for bottom sheet with snap behavior
  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    
    _isDragging = false;
    print('[MerchantDetailPage] Drag ended, final height: $_bottomSheetHeight');
    
    // Snap to nearest position
    double targetHeight;
    if (_bottomSheetHeight > 0.65) {
      targetHeight = 1.0; // Full screen
      _isTopInfoVisible = false;
      _topInfoAnimationController.forward();
    } else if (_bottomSheetHeight > 0.45) {
      targetHeight = 0.6; // Default
      _isTopInfoVisible = true;
      _topInfoAnimationController.reverse();
    } else {
      targetHeight = 0.3; // Minimal
      _isTopInfoVisible = true;
      _topInfoAnimationController.reverse();
    }
    
    // Animate to target height
    _animateToHeight(targetHeight);
  }

  /// Animate bottom sheet to target height
  void _animateToHeight(double targetHeight) {
    _bottomSheetAnimationController.reset();
    _bottomSheetAnimationController.forward().then((_) {
      setState(() {
        _bottomSheetHeight = targetHeight;
      });
    });
  }

  /// Build draggable bottom sheet with drag handle
  Widget _buildDraggableBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusXl.r),
          topRight: Radius.circular(DesignTokens.radiusXl.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          _buildDragHandle(),
          
          // Bottom sheet content
          Expanded(
            child: _buildBottomSheetContent(),
          ),
        ],
      ),
    );
  }

  /// Build drag handle for bottom sheet
  Widget _buildDragHandle() {
    return Container(
      margin: EdgeInsets.only(top: DesignTokens.space3.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: DesignTokens.neutral300,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  /// Build bottom sheet content (menu/products)
  Widget _buildBottomSheetContent() {
    return Column(
      children: [
        // Search and filter section
        _buildSearchAndFilterSection(),
        
        // Menu/products list
        Expanded(
          child: _buildMenuList(),
        ),
      ],
    );
  }

  /// Build combined search and filter section
  Widget _buildSearchAndFilterSection() {
    return Column(
      children: [
        // Search section
        _buildSearchSection(),
        
        // Filter chips
        _buildFilterChips(),
      ],
    );
  }

  /// Handle add to cart with supplements
  void _handleAddToCartWithSupplements(MenuItem item, Map<String, int> supplements, CartNotifier cartNotifier) {
    // Create customization prices map (simplified for now)
    final customizationPrices = <String, double>{};
    supplements.forEach((supplement, quantity) {
      customizationPrices[supplement] = 200.0; // Default supplement price
    });
    
    cartNotifier.addItem(
      menuItem: item,
      customizations: supplements,
      basePrice: item.price,
      customizationPrices: customizationPrices,
      context: 'restaurant', // Set context to restaurant
    );

    debugPrint(
      '[MerchantDetailPage] Added to cart: ${item.name} with supplements: $supplements',
    );
  }

  /// Show custom cart snackbar
  void _showCartSnackbar() {
    final cartNotifier = ref.read(cartProvider.notifier);
    
    showCartSnackbar(
      context: context,
      onCheckout: () => _handleCartTap(cartNotifier), // Navigate to cart screen
    );
  }


  /// Build floating cart button
  Widget _buildFloatingCartButton(CartState cartState, CartNotifier cartNotifier) {
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
              onPressed: () => _handleCartTap(cartNotifier),
              icon: Icon(Icons.shopping_cart, color: Colors.white, size: 24.w),
            ),
            if (cartState.totalItems > 0)
              Positioned(
                right: 8.w,
                top: 8.h,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
                  child: Center(
                    child: Text(
                      '${cartState.totalItems}',
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
  void _handleCartTap(CartNotifier cartNotifier) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }
}

