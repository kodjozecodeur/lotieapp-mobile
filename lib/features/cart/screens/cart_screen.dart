import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../providers/cart_provider.dart';
import '../../../models/cart_item.dart';

/// Cart Screen
/// 
/// Displays the user's shopping cart with items, quantities, and checkout functionality.
/// Includes both populated and empty states.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      appBar: _buildAppBar(context, cartNotifier),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCartContent(context, ref, cartState, cartNotifier),
    );
  }

  /// Build app bar with back button, title, and clear cart button
  PreferredSizeWidget _buildAppBar(BuildContext context, CartNotifier cartNotifier) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: DesignTokens.neutral900,
          size: 20.sp,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Mon panier',
        style: TextStyle(
          fontSize: DesignTokens.fontSizeXl.sp,
          color: DesignTokens.neutral900,
          fontWeight: FontWeight.w600,
          fontFamily: DesignTokens.fontFamilyPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 24.sp,
          ),
          onPressed: () => _showClearCartDialog(context, cartNotifier),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  /// Build empty cart state
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
                'assets/icons/empty_cart.svg',
                width: 100.w,
                height: 100.h,
                // colorFilter: ColorFilter.mode(
                //   DesignTokens.neutral500,
                //   BlendMode.srcIn,
                // ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Votre panier est vide',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXl.sp,
                  color: DesignTokens.neutral900,
                  fontWeight: FontWeight.w600,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Ajoutez des articles pour commencer',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  color: DesignTokens.neutral500,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignTokens.primary950,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
                  ),
                ),
                child: Text(
                  'Retour à l\'accueil',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  /// Build cart content with items and checkout
  Widget _buildCartContent(
    BuildContext context,
    WidgetRef ref,
    CartState cartState,
    CartNotifier cartNotifier,
  ) {
    return Column(
      children: [
        // Delivery address card - always visible
        _buildDeliveryAddressCard(context),
        
        // Main content area
        Expanded(
          child: cartState.items.isEmpty
              ? _buildEmptyState(context)
              : _buildCartItemsList(context, ref, cartState, cartNotifier),
        ),
        
        // Bottom section - only show when cart has items
        if (cartState.items.isNotEmpty) ...[
          // Add more items button
          _buildAddMoreItemsButton(context),
          
          // Checkout footer
          _buildCheckoutFooter(context, ref, cartState, cartNotifier),
        ],
      ],
    );
  }

  /// Build cart items list
  Widget _buildCartItemsList(
    BuildContext context,
    WidgetRef ref,
    CartState cartState,
    CartNotifier cartNotifier,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(DesignTokens.space4.w),
      itemCount: cartState.items.length,
      itemBuilder: (context, index) {
        final cartItem = cartState.items.values.elementAt(index);
        return _buildCartItemCard(context, ref, cartItem, cartNotifier);
      },
    );
  }

  /// Build delivery address card
  Widget _buildDeliveryAddressCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(DesignTokens.space4.w),
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: DesignTokens.neutral200,
              borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
            ),
            child: SvgPicture.asset(
              'assets/icons/location_cart.svg',
              width: 20.w,
              height: 20.h,
              
            )
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adresse de livraison',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXs.sp,
                    color: DesignTokens.neutral600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '500 Fifth Avenue, NYC',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm.sp,
                    color: DesignTokens.neutral900,
                    fontWeight: DesignTokens.fontWeightMedium,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement address change
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: DesignTokens.space3.w,
                vertical: DesignTokens.space1.h,
              ),
              decoration: BoxDecoration(
                color: DesignTokens.neutral100,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull.r),
              ),
              child: Text(
                'Change',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXs .sp,
                  color: DesignTokens.neutral900,
                  fontWeight: DesignTokens.fontWeightMedium,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual cart item card
  Widget _buildCartItemCard(
    BuildContext context,
    WidgetRef ref,
    CartItem cartItem,
    CartNotifier cartNotifier,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: DesignTokens.space3.w),
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
            child: Image.network(
              cartItem.menuItem.imageUrl ?? '',
              width: 60.w,
              height: 60.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60.w,
                  height: 60.w,
                  color: DesignTokens.neutral100,
                  child: Icon(
                    Icons.fastfood,
                    color: DesignTokens.neutral500,
                    size: 24.sp,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.menuItem.name,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    color: DesignTokens.neutral900,
                    fontWeight: FontWeight.w600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                
                // Customizations
                if (cartItem.hasCustomizations)
                  Text(
                    cartItem.customizationSummary,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      color: DesignTokens.neutral500,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                
                SizedBox(height: 8.h),
                
                // Price and quantity controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.formattedPrice,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase.sp,
                        color: DesignTokens.primary950,
                        fontWeight: FontWeight.w600,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),
                    _buildQuantityControls(cartItem, cartNotifier),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build quantity controls
  Widget _buildQuantityControls(CartItem cartItem, CartNotifier cartNotifier) {
    return Row(
      children: [
        // Decrease button
        GestureDetector(
          onTap: () => cartNotifier.updateQuantity(
            cartItem.id,
            cartItem.quantity - 1,
          ),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: DesignTokens.neutral100,
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
              border: Border.all(
                color: DesignTokens.neutral300,
                width: 1,
              ),
            ),
            child: Icon(
              Icons.remove,
              size: 16.sp,
              color: DesignTokens.neutral900,
            ),
          ),
        ),
        
        // Quantity display
        Container(
          width: 40.w,
          height: 32.w,
          alignment: Alignment.center,
          child: Text(
            '${cartItem.quantity}',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              color: DesignTokens.neutral900,
              fontWeight: FontWeight.w600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ),
        
        // Increase button
        GestureDetector(
          onTap: () => cartNotifier.updateQuantity(
            cartItem.id,
            cartItem.quantity + 1,
          ),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: DesignTokens.primary950,
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
            ),
            child: Icon(
              Icons.add,
              size: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// Build add more items button
  Widget _buildAddMoreItemsButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DesignTokens.space4.w),
      child: OutlinedButton.icon(
        onPressed: () => context.go('/home/top-marchands'),
        icon: Icon(
          Icons.add,
          color: DesignTokens.primary950,
          size: 20.sp,
        ),
        label: Text(
          'Ajouter plus d\'articles',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            color: DesignTokens.primary950,
            fontWeight: FontWeight.w600,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: DesignTokens.primary950,
            width: 1.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
          ),
        ),
      ),
    );
  }

  /// Build checkout footer
  Widget _buildCheckoutFooter(
    BuildContext context,
    WidgetRef ref,
    CartState cartState,
    CartNotifier cartNotifier,
  ) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.space4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Total summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cartState.totalItems} articles au total',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  color: DesignTokens.neutral900,
                  fontWeight: FontWeight.w500,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              Text(
                '${cartState.totalPrice.toInt()} FCFA',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeXl.sp,
                  color: DesignTokens.primary950,
                  fontWeight: FontWeight.w700,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Checkout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement checkout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Checkout functionality coming soon!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.primary950,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
                ),
              ),
              child: Text(
                'Finaliser la commande',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show clear cart confirmation dialog
  void _showClearCartDialog(BuildContext context, CartNotifier cartNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Vider le panier',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXl.sp,
            color: DesignTokens.neutral900,
            fontWeight: FontWeight.w600,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer tous les articles de votre panier ?',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Annuler',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase.sp,
                color: DesignTokens.neutral500,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              cartNotifier.clearCart();
              Navigator.of(context).pop();
            },
            child: Text(
              'Vider',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontFamily: DesignTokens.fontFamilyPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

}