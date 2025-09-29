import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../models/menu_item.dart';

/// Product Detail Modal
///
/// A customizable bottom sheet that opens when user taps on an electronics product.
/// Shows product details with add to cart functionality.
class ProductDetailModal extends StatefulWidget {
  const ProductDetailModal({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  /// The product to display details for
  final MenuItem product;

  /// Callback when product is added to cart
  final Function(MenuItem product) onAddToCart;

  @override
  State<ProductDetailModal> createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends State<ProductDetailModal>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Initialize animation controllers
  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: DesignTokens.space1.h,
        left: DesignTokens.space3.w,
        right: DesignTokens.space3.w,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radius3xl.r),
          topRight: Radius.circular(DesignTokens.radius3xl.r),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Drag handle
              _buildDragHandle(),

              // Header with product image
              _buildHeader(),

              // Product info section
              _buildProductInfo(),

              // Description section
              _buildDescriptionSection(),

              // Bottom action button
              _buildBottomAction(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build drag handle
  Widget _buildDragHandle() {
    return Container(
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
    );
  }

  /// Build header with product image and close button
  Widget _buildHeader() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radius3xl.r),
          topRight: Radius.circular(DesignTokens.radius3xl.r),
        ),
      ),
      child: Stack(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
            child: widget.product.imageUrl != null
                ? widget.product.imageUrl!.startsWith('http')
                      ? Image.network(
                          widget.product.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultProductImage(),
                        )
                      : Image.asset(
                          widget.product.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultProductImage(),
                        )
                : _buildDefaultProductImage(),
          ),

          // Close and favorite buttons
          Positioned(
            top: DesignTokens.space4.h,
            right: DesignTokens.space4.w,
            child: Row(
              children: [
                // Favorite button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: DesignTokens.shadowSm,
                  ),
                  child: IconButton(
                    onPressed: _handleFavoriteTap,
                    icon: Icon(
                      Icons.favorite_border,
                      color: DesignTokens.neutral700,
                      size: 24.w,
                    ),
                  ),
                ),
                
                SizedBox(width: DesignTokens.space2.w),
                
                // Close button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: DesignTokens.shadowSm,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: DesignTokens.neutral700,
                      size: 24.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build default product image
  Widget _buildDefaultProductImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: DesignTokens.neutral100,
      child: Icon(Icons.shopping_bag, size: 60.w, color: DesignTokens.primary500),
    );
  }

  /// Build product info section
  Widget _buildProductInfo() {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.space5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Text(
            widget.product.name,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXl.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral900,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),

          SizedBox(height: DesignTokens.space2.h),

          // Rating and reviews
          Row(
            children: [
              // Stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: DesignTokens.warning500,
                    size: 20.w,
                  );
                }),
              ),

              SizedBox(width: DesignTokens.space2.w),

              // Review count
              Text(
                '(250+ review)',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  color: DesignTokens.neutral600,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ],
          ),

          SizedBox(height: DesignTokens.space2.h),

          // Price
          Text(
            '${widget.product.price.toInt()} FCFA',
            style: TextStyle(
              fontSize: DesignTokens.fontSize2xl.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.success500,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build description section
  Widget _buildDescriptionSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description heading
            Text(
              'À Propos de ce produit',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeXl.sp,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.neutral900,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),

            SizedBox(height: DesignTokens.space4.h),

            // Description text
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase.sp,
                color: DesignTokens.neutral600,
                fontFamily: DesignTokens.fontFamilyPrimary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build bottom action button
  Widget _buildBottomAction() {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.space5.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: () => _handleAddToCart(),
          style: ElevatedButton.styleFrom(
            backgroundColor: DesignTokens.primary950,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Ajouter au panier • ${widget.product.price.toInt()} FCFA',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightMedium,
              color: Colors.white,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ),
      ),
    );
  }

  /// Handle favorite tap
  void _handleFavoriteTap() {
    // TODO: Toggle favorite status
    debugPrint('[ProductDetailModal] Favorite tapped for ${widget.product.name}');
    
    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ajouté aux favoris',
          style: TextStyle(
            fontFamily: DesignTokens.fontFamilyPrimary,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
        backgroundColor: DesignTokens.primary500,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        ),
      ),
    );
  }

  /// Handle add to cart
  void _handleAddToCart() {
    widget.onAddToCart(widget.product);
    Navigator.of(context).pop();
    
    debugPrint('[ProductDetailModal] Added to cart: ${widget.product.name}');
  }
}
