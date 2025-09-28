import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../models/menu_item.dart';

/// Item Detail Modal
///
/// A customizable bottom sheet that opens when user taps on a menu item.
/// Shows item details with customization options and dynamic pricing.
class ItemDetailModal extends StatefulWidget {
  const ItemDetailModal({
    super.key,
    required this.menuItem,
    required this.onAddToCart,
  });

  /// The menu item to display details for
  final MenuItem menuItem;

  /// Callback when item is added to cart with customizations
  final Function(MenuItem item, Map<String, int> supplements) onAddToCart;

  @override
  State<ItemDetailModal> createState() => _ItemDetailModalState();
}

class _ItemDetailModalState extends State<ItemDetailModal>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  /// Selected supplements with quantities
  Map<String, int> _selectedSupplements = {};

  /// Base price of the item
  final double _basePrice = 1600.0;

  /// Available supplements with their prices
  final Map<String, double> _supplements = {
    'Boulettes de viande': 200.0,
    'Mayonnaise': 100.0,
    'Fromage': 150.0,
    'Sauce piquante': 50.0,
  };

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

              // Header with food image
              _buildHeader(),

              // Item info section
              _buildItemInfo(),

              // Supplements section
              _buildSupplementsSection(),

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

  /// Build header with food image and close button
  Widget _buildHeader() {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radius3xl.r),
          topRight: Radius.circular(DesignTokens.radius3xl.r),
        ),
      ),
      child: Stack(
        children: [
          // Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
            child: widget.menuItem.imageUrl != null
                ? widget.menuItem.imageUrl!.startsWith('http')
                      ? Image.network(
                          widget.menuItem.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultFoodImage(),
                        )
                      : Image.asset(
                          widget.menuItem.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultFoodImage(),
                        )
                : _buildDefaultFoodImage(),
          ),

          // Close button
          Positioned(
            top: DesignTokens.space4.h,
            right: DesignTokens.space4.w,
            child: Container(
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
          ),
        ],
      ),
    );
  }

  /// Build default food image
  Widget _buildDefaultFoodImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: DesignTokens.neutral100,
      child: Icon(Icons.restaurant, size: 60.w, color: DesignTokens.primary500),
    );
  }

  /// Build item info section
  Widget _buildItemInfo() {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.space5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item name with favorite icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Item name
              Expanded(
                child: Text(
                  widget.menuItem.name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXl.sp,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ),
              
              // Favorite icon
              Container(
                decoration: BoxDecoration(
                  color: DesignTokens.neutral100,
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
            ],
          ),

          SizedBox(height: DesignTokens.space1.h),

          // Rating and reviews - separated with space between
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stars on the left
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: DesignTokens.warning500,
                    size: 20.w,
                  );
                }),
              ),

              // Review count on the right
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

          SizedBox(height: DesignTokens.space1.h),

          // Price
          Text(
            '${_basePrice.toInt()} FCFA',
            style: TextStyle(
              fontSize: DesignTokens.fontSize2xl.sp,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.primary800,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build supplements section
  Widget _buildSupplementsSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supplements heading
            Text(
              'Suppléments',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeXl.sp,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.neutral900,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),

            SizedBox(height: DesignTokens.space4.h),

            // Supplements list
            Expanded(
              child: ListView.builder(
                itemCount: _supplements.length,
                itemBuilder: (context, index) {
                  final supplement = _supplements.keys.elementAt(index);
                  final price = _supplements[supplement]!;
                  final quantity = _selectedSupplements[supplement] ?? 0;

                  return _buildSupplementItem(supplement, price, quantity);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual supplement item
  Widget _buildSupplementItem(String name, double price, int quantity) {
    return Container(
      margin: EdgeInsets.only(bottom: DesignTokens.space4.h),
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
        border: Border.all(color: DesignTokens.neutral200),
      ),
      child: Row(
        children: [
          // Supplement info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    fontWeight: DesignTokens.fontWeightMedium,
                    color: DesignTokens.neutral900,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                SizedBox(height: DesignTokens.space1.h),
                Text(
                  '+ ${price.toInt()} FCFA',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    color: DesignTokens.neutral600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Quantity selector or add button
          if (quantity == 0)
            _buildAddButton(name)
          else
            _buildQuantitySelector(name, quantity),
        ],
      ),
    );
  }

  /// Build add button for supplement
  Widget _buildAddButton(String supplement) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: DesignTokens.primary500,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => _addSupplement(supplement),
        icon: Icon(Icons.add, color: Colors.white, size: 20.w),
      ),
    );
  }

  /// Build quantity selector for supplement
  Widget _buildQuantitySelector(String supplement, int quantity) {
    return Row(
      children: [
        // Minus button
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: DesignTokens.neutral200,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => _removeSupplement(supplement),
            icon: Icon(
              Icons.remove,
              color: DesignTokens.neutral700,
              size: 16.w,
            ),
          ),
        ),

        SizedBox(width: DesignTokens.space3.w),

        // Quantity
        Container(
          width: 40.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: DesignTokens.primary500,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                color: Colors.white,
                fontSize: DesignTokens.fontSizeBase.sp,
                fontWeight: DesignTokens.fontWeightBold,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ),
        ),

        SizedBox(width: DesignTokens.space3.w),

        // Plus button
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: DesignTokens.neutral200,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => _addSupplement(supplement),
            icon: Icon(Icons.add, color: DesignTokens.neutral700, size: 16.w),
          ),
        ),
      ],
    );
  }

  /// Build bottom action button
  Widget _buildBottomAction() {
    final totalPrice = _calculateTotalPrice();

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
            'Ajouter au panier • ${totalPrice.toInt()} FCFA',
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

  /// Add supplement
  void _addSupplement(String supplement) {
    setState(() {
      _selectedSupplements[supplement] =
          (_selectedSupplements[supplement] ?? 0) + 1;
    });
  }

  /// Remove supplement
  void _removeSupplement(String supplement) {
    setState(() {
      if (_selectedSupplements[supplement]! > 1) {
        _selectedSupplements[supplement] =
            _selectedSupplements[supplement]! - 1;
      } else {
        _selectedSupplements.remove(supplement);
      }
    });
  }

  /// Calculate total price including supplements
  double _calculateTotalPrice() {
    double total = _basePrice;

    _selectedSupplements.forEach((supplement, quantity) {
      if (_supplements.containsKey(supplement)) {
        total += _supplements[supplement]! * quantity;
      }
    });

    return total;
  }

  /// Handle favorite tap
  void _handleFavoriteTap() {
    // TODO: Toggle favorite status
    debugPrint('[ItemDetailModal] Favorite tapped for ${widget.menuItem.name}');
    
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
    widget.onAddToCart(widget.menuItem, Map.from(_selectedSupplements));
    Navigator.of(context).pop();
    
    debugPrint('[ItemDetailModal] Added to cart: ${widget.menuItem.name} with supplements: $_selectedSupplements');
  }
}
