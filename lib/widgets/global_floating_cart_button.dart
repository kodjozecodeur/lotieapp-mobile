import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/design_tokens.dart';
import '../providers/cart_provider.dart';
import '../features/cart/screens/cart_screen.dart';

/// Global Floating Cart Button
/// 
/// A floating cart button that appears on all pages when there are items in the cart.
/// Provides consistent cart access throughout the app.
class GlobalFloatingCartButton extends ConsumerWidget {
  const GlobalFloatingCartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    // Only show if cart has items
    if (cartState.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 100.h, // Position above bottom navigation
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
              onPressed: () => _handleCartTap(context, cartNotifier),
              icon: Icon(Icons.shopping_cart, color: Colors.white, size: 24.w),
            ),
            // Cart item count badge
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
  void _handleCartTap(BuildContext context, CartNotifier cartNotifier) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }
}
