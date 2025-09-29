import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lotieapp/core/utils/logger.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../models/menu_item.dart';
import '../../../providers/cart_provider.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/cart_snackbar.dart';
import '../../cart/screens/cart_screen.dart';
import 'product_detail_modal.dart';

/// Electronics Products Page
/// 
/// Displays a grid of electronics products with search and filtering capabilities.
/// Shows products in a 2-column grid layout similar to the attached image.
class ElectronicsProductsPage extends ConsumerStatefulWidget {
  const ElectronicsProductsPage({super.key});

  @override
  ConsumerState<ElectronicsProductsPage> createState() => _ElectronicsProductsPageState();
}

class _ElectronicsProductsPageState extends ConsumerState<ElectronicsProductsPage> {
  List<MenuItem> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadElectronicsProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Load electronics products data
  Future<void> _loadElectronicsProducts() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _products = _generateElectronicsProducts();
      _isLoading = false;
    });
  }

  /// Generate sample electronics products
  List<MenuItem> _generateElectronicsProducts() {
    final products = [
      {
        'name': 'Playstation 5 DualSense',
        'price': 5000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.4,
        'reviews': 128,
      },
      {
        'name': 'iPhone 15 Pro',
        'price': 450000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.8,
        'reviews': 256,
      },
      {
        'name': 'AirPods Pro',
        'price': 85000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.6,
        'reviews': 189,
      },
      {
        'name': 'MacBook Air M2',
        'price': 650000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.7,
        'reviews': 142,
      },
      {
        'name': 'Samsung Galaxy S24',
        'price': 380000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.5,
        'reviews': 203,
      },
      {
        'name': 'iPad Pro 12.9"',
        'price': 520000.0,
        'image': 'assets/images/ps5.png',
        'rating': 4.9,
        'reviews': 167,
      },
    ];

    return products.map((product) {
      return MenuItem(
        id: 'electronics_${products.indexOf(product) + 1}',
        name: product['name'] as String,
        description: 'High-quality electronics product',
        price: product['price'] as double,
        currency: 'FCFA',
        imageUrl: product['image'] as String,
        category: 'Électroniques',
        isAvailable: true,
        preparationTime: 0,
      );
    }).toList();
  }


  /// Show product detail modal
  void _showProductDetailModal(MenuItem product) {
    logger.debug('[ElectronicsProductsPage] Showing product detail for: ${product.name}');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailModal(
        product: product,
        onAddToCart: _handleAddToCart,
      ),
    );
  }

  /// Handle add to cart
  void _handleAddToCart(MenuItem product) {
    logger.debug('[ElectronicsProductsPage] Add to cart tapped for: ${product.name}');
    
    final cartNotifier = ref.read(cartProvider.notifier);
    
    // Add product to cart using the same system as merchant detail page
    cartNotifier.addItem(
      menuItem: product,
      customizations: {}, // No customizations for electronics products
      basePrice: product.price,
      customizationPrices: {}, // No customization prices
      context: 'supermarket', // Set context to supermarket
    );

    logger.debug('[ElectronicsProductsPage] Product added to cart successfully');

    // Show success feedback using the same cart snackbar
    showCartSnackbar(
      context: context,
      onCheckout: () => _handleCartTap(cartNotifier),
    );
    
    logger.debug('[ElectronicsProductsPage] Cart snackbar shown');
    
    // Add haptic feedback
    HapticFeedback.lightImpact();
    
    logger.debug('[ElectronicsProductsPage] Added to cart: ${product.name}');
  }

  /// Handle cart button tap
  void _handleCartTap(CartNotifier cartNotifier) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }

  /// Build floating cart button
  Widget _buildFloatingCartButton(CartState cartState, CartNotifier cartNotifier) {
    return Positioned(
      bottom: 20.h,
      right: 20.w,
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

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // _buildSearchSection(),
              // _buildFilterSection(),
              Expanded(
                child: _buildProductsGrid(),
              ),
            ],
          ),
          
          // Floating cart button
          if (cartState.items.isNotEmpty)
            _buildFloatingCartButton(cartState, cartNotifier),
        ],
      ),
    );
  }

  /// Build custom app bar
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: 'Électroniques',
      showBackButton: true,
      onBackPressed: () => context.pop(),
    );
  }

  /// Build search section
  // Widget _buildSearchSection() {
  //   return Container(
  //     padding: EdgeInsets.all(DesignTokens.space4.w),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
  //         border: Border.all(color: DesignTokens.neutral200),
  //       ),
  //       child: TextField(
  //         controller: _searchController,
  //         onChanged: _onSearchChanged,
  //         decoration: InputDecoration(
  //           hintText: 'Rechercher des produits...',
  //           hintStyle: TextStyle(
  //             color: DesignTokens.neutral500,
  //             fontFamily: DesignTokens.fontFamilyPrimary,
  //           ),
  //           prefixIcon: Padding(
  //             padding: EdgeInsets.all(12.w),
  //             child: SvgPicture.asset(
  //               'assets/icons/search_icon.svg',
  //               width: 20.w,
  //               height: 20.h,
  //               colorFilter: ColorFilter.mode(
  //                 DesignTokens.neutral600,
  //                 BlendMode.srcIn,
  //               ),
  //             ),
  //           ),
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.symmetric(
  //             horizontal: DesignTokens.space4.w,
  //             vertical: DesignTokens.space3.h,
  //           ),
  //         ),
  //         style: TextStyle(
  //           fontFamily: DesignTokens.fontFamilyPrimary,
  //           fontSize: DesignTokens.fontSizeBase.sp,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // /// Build filter section
  // Widget _buildFilterSection() {
  //   final filters = ['Tous', 'Gaming', 'Audio', 'Smartphones', 'Accessoires'];

  //   return Container(
  //     height: 40.h,
  //     margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4.w),
  //       itemCount: filters.length,
  //       itemBuilder: (context, index) {
  //         final filter = filters[index];
  //         final isSelected = filter == _selectedFilter;
          
  //         return Container(
  //           margin: EdgeInsets.only(right: DesignTokens.space2.w),
  //           child: GestureDetector(
  //             onTap: () => _onFilterSelected(filter),
  //             child: Container(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: DesignTokens.space4.w,
  //                 vertical: DesignTokens.space2.h,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: isSelected ? DesignTokens.primary500 : Colors.white,
  //                 borderRadius: BorderRadius.circular(DesignTokens.radiusFull.r),
  //                 border: Border.all(
  //                   color: isSelected ? DesignTokens.primary500 : DesignTokens.neutral300,
  //                 ),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   filter,
  //                   style: TextStyle(
  //                     color: isSelected ? Colors.white : DesignTokens.neutral700,
  //                     fontWeight: isSelected 
  //                         ? DesignTokens.fontWeightSemiBold 
  //                         : DesignTokens.fontWeightMedium,
  //                     fontFamily: DesignTokens.fontFamilyPrimary,
  //                     fontSize: DesignTokens.fontSizeSm.sp,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  /// Build products grid
  Widget _buildProductsGrid() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_products.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space4.w,
        vertical: DesignTokens.space2.h,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: DesignTokens.space3.w,
        mainAxisSpacing: DesignTokens.space3.h,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return _buildProductCard(product);
      },
    );
  }

  /// Build individual product card
  Widget _buildProductCard(MenuItem product) {
    return GestureDetector(
      onTap: () => _showProductDetailModal(product),
      child: SizedBox(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with add button
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: DesignTokens.neutral500,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DesignTokens.radiusLg.r),
                      topRight: Radius.circular(DesignTokens.radiusLg.r),
                      bottomLeft: Radius.circular(DesignTokens.radiusLg.r),
                      bottomRight: Radius.circular(DesignTokens.radiusLg.r),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      product.imageUrl ?? 'assets/images/ps5.png',
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Add button
                Positioned(
                  bottom: DesignTokens.space2.h,
                  right: DesignTokens.space2.w,
                  child: GestureDetector(
                    onTap: () => _handleAddToCart(product),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: DesignTokens.primary950,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Product details
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(DesignTokens.space3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price
                  Text(
                    '${product.price.toInt()} FCFA',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase.sp,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: DesignTokens.neutral900,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                  
                  // Product name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      fontWeight: DesignTokens.fontWeightMedium,
                      color: DesignTokens.neutral700,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Rating (hardcoded since MenuItem doesn't have rating)
                  Row(
                    children: [
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeXs.sp,
                          fontWeight: DesignTokens.fontWeightMedium,
                          color: DesignTokens.neutral600,
                          fontFamily: DesignTokens.fontFamilyPrimary,
                        ),
                      ),
                      SizedBox(width: DesignTokens.space1.w),
                      ...List.generate(5, (index) => Icon(
                        Icons.star,
                        size: 12.w,
                        color: Colors.amber,
                      )),
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
            'Chargement des produits...',
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
            'Aucun produit trouvé',
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
