import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/design_tokens.dart';
import '../../models/product.dart';

/// Promotion card component
/// 
/// This widget displays individual product promotion with:
/// - Product image with discount badge overlay
/// - Merchant info with icon
/// - Product name, current price, crossed-out original price
/// - Heart favorite icon
/// - FCFA currency formatting
class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.product,
    this.onTapped,
    this.onFavoriteTapped,
    this.width = 200.0,
  });

  /// Product data to display
  final Product product;
  
  /// Callback when card is tapped
  final Function(String productId)? onTapped;
  
  /// Callback when favorite icon is tapped
  final Function(String productId)? onFavoriteTapped;
  
  /// Card width
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapped?.call(product.id),
      child: Container(
        width: width.w,
        margin: EdgeInsets.only(right: DesignTokens.space4.w),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(DesignTokens.cardBorderRadius.r),
        //   boxShadow: DesignTokens.shadowBase,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with discount badge and favorite
            _buildImageSection(),
            
            // Content section
            Padding(
              padding: EdgeInsets.all(DesignTokens.space3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Merchant name with icon
                  _buildMerchantInfo(),
                  
                  SizedBox(height: DesignTokens.space2.h),
                  
                  // Product name
                  _buildProductName(),
                  
                  SizedBox(height: DesignTokens.space2.h),
                  
                  // Price info
                  _buildPriceInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build image section with discount badge and favorite
  Widget _buildImageSection() {
    return Container(
      height: 120.h,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      // ),
      child: Stack(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(
              DesignTokens.cardBorderRadius.r,
            ),
            child: Image.asset(
              product.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: DesignTokens.neutral200,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 32.w,
                      color: DesignTokens.neutral650,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Discount badge (if on promotion)
          if (product.isOnPromotion && product.discountPercentage != null)
            Positioned(
              top: DesignTokens.space2.h,
              left: DesignTokens.space2.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.space2.w,
                  vertical: DesignTokens.space1.h,
                ),
                decoration: BoxDecoration(
                  color: DesignTokens.secondary950,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusFull.r),
                ),
                child: Text(
                  '${product.discountPercentage}% de réduction',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXs.sp,
                    fontWeight: DesignTokens.fontWeightMedium,
                    color: DesignTokens.neutral850,
                    fontFamily: DesignTokens.fontFamilySecondary,
                  ),
                ),
              ),
            ),
          
          // Favorite heart icon
          Positioned(
            top: DesignTokens.space2.h,
            right: DesignTokens.space2.w,
            child: GestureDetector(
              onTap: () => onFavoriteTapped?.call(product.id),
              child: Container(
                padding: EdgeInsets.all(DesignTokens.space2.w),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/favorite_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    DesignTokens.neutral850,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build merchant info with icon
  Widget _buildMerchantInfo() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/shop_merchant_icon.svg',
          width: 10.w,
          height: 10.h,
          colorFilter: ColorFilter.mode(
            DesignTokens.neutral650,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: DesignTokens.space1.w),
        Expanded(
          child: Text(
            product.merchantName,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs.sp,
              fontWeight: DesignTokens.fontWeightRegular,
              color: DesignTokens.neutral650,
              fontFamily: DesignTokens.fontFamilySecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Build product name
  Widget _buildProductName() {
    return Text(
      product.name,
      style: TextStyle(
        fontSize: DesignTokens.fontSizeSm.sp,
        fontWeight: DesignTokens.fontWeightSemiBold,
        color: DesignTokens.neutral850,
        fontFamily: DesignTokens.fontFamilyPrimary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Build price information
  Widget _buildPriceInfo() {
    return Row(
      children: [
        // Current price
        Text(
          product.formattedPrice,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.primary950,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        
        // Original price (if on promotion)
        if (product.isOnPromotion && product.formattedOriginalPrice != null) ...[
          SizedBox(width: DesignTokens.space2.w),
          Text(
            product.formattedOriginalPrice!,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs.sp,
              fontWeight: DesignTokens.fontWeightRegular,
              color: DesignTokens.neutral650,
              fontFamily: DesignTokens.fontFamilyPrimary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
