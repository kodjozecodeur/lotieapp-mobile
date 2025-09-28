import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/design_tokens.dart';
import '../providers/cart_provider.dart';

/// Custom Cart Snackbar Widget
/// 
/// A persistent bottom snackbar that shows cart summary and checkout button.
/// Displays item count, total price, and checkout action in a row layout.
class CartSnackbar extends ConsumerWidget {
  const CartSnackbar({
    super.key,
    required this.onCheckout,
  });

  /// Callback when checkout button is pressed
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space5.w,
        vertical: DesignTokens.space4.h,
      ),
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
      child: Row(
        children: [
          // Left section - Order summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Item count
                Text(
                  '${cartState.totalItems} article${cartState.totalItems > 1 ? 's' : ''} au total',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase.sp,
                    fontWeight: DesignTokens.fontWeightRegular,
                    color: DesignTokens.neutral700,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
                
                SizedBox(height: DesignTokens.space1.h),
                
                // Total price
                Text(
                  '${cartState.totalPrice.toInt()} FCFA',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg.sp,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.primary950,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(width: DesignTokens.space4.w),
          
          // Right section - Checkout button
          SizedBox(
            height: 48.h,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.primary950,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.space5.w,
                  vertical: DesignTokens.space3.h,
                ),
              ),
              child: Text(
                'Passer à la caisse',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  color: Colors.white,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Show cart snackbar
void showCartSnackbar({
  required BuildContext context,
  required VoidCallback onCheckout,
}) {
  // Remove any existing snackbar
  ScaffoldMessenger.of(context).clearSnackBars();
  
  // Show new cart snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CartSnackbar(
        onCheckout: () {
          // Hide the snackbar first
          ScaffoldMessenger.of(context).clearSnackBars();
          // Then navigate to cart
          onCheckout();
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(days: 1), // Persistent until dismissed
      padding: EdgeInsets.zero,
    ),
  );
}

/// Hide cart snackbar
void hideCartSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
