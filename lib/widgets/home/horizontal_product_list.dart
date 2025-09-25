import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';
import '../../models/merchant.dart';
import '../../models/product.dart';
import 'merchant_card.dart';
import 'promo_card.dart';

/// Horizontal scrollable product/merchant list component
/// 
/// This widget displays a horizontal scrollable list that can show
/// either merchants or products using their respective card components.
class HorizontalProductList extends StatelessWidget {
  const HorizontalProductList({
    super.key,
    this.merchants,
    this.products,
    this.onMerchantTapped,
    this.onProductTapped,
    this.onFavoriteTapped,
  });

  /// List of merchants to display (optional)
  final List<Merchant>? merchants;
  
  /// List of products to display (optional)  
  final List<Product>? products;
  
  /// Callback when merchant is tapped
  final Function(String merchantId)? onMerchantTapped;
  
  /// Callback when product is tapped
  final Function(String productId)? onProductTapped;
  
  /// Callback when favorite is tapped
  final Function(String itemId)? onFavoriteTapped;

  @override
  Widget build(BuildContext context) {
    // Determine which list to show
    final bool showMerchants = merchants != null && merchants!.isNotEmpty;
    final bool showProducts = products != null && products!.isNotEmpty;
    
    if (!showMerchants && !showProducts) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 200.h, // Fixed height for horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space5.w),
        itemCount: showMerchants ? merchants!.length : products!.length,
        itemBuilder: (context, index) {
          if (showMerchants) {
            return MerchantCard(
              merchant: merchants![index],
              onTapped: onMerchantTapped,
              onFavoriteTapped: onFavoriteTapped,
            );
          } else {
            return PromoCard(
              product: products![index],
              onTapped: onProductTapped,
              onFavoriteTapped: onFavoriteTapped,
            );
          }
        },
      ),
    );
  }
}
