import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';
import '../../models/merchant.dart';

/// Merchant card component
/// 
/// This widget displays individual merchant information with:
/// - Rounded image container with favorite heart icon overlay
/// - Merchant name, distance, delivery time
/// - Star rating with number
/// - Restaurant icon prefix
/// - Proper shadows and spacing
/// 
/// All styling uses DesignTokens for consistency.
class MerchantCard extends StatelessWidget {
  const MerchantCard({
    super.key,
    required this.merchant,
    this.onTapped,
    this.onFavoriteTapped,
    this.width = 200.0,
  });

  /// Merchant data to display
  final Merchant merchant;
  
  /// Callback when card is tapped
  final Function(String merchantId)? onTapped;
  
  /// Callback when favorite icon is tapped
  final Function(String merchantId)? onFavoriteTapped;
  
  /// Card width
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapped?.call(merchant.id),
      child: Container(
        width: width.w,
        margin: EdgeInsets.only(right: DesignTokens.space4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.cardBorderRadius.r),
          boxShadow: DesignTokens.shadowBase,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite overlay
            _buildImageSection(),
            
            // Content section
            Padding(
              padding: EdgeInsets.all(DesignTokens.space3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Merchant name with restaurant icon
                  _buildMerchantName(),
                  
                  SizedBox(height: DesignTokens.space2.h),
                  
                  // Distance and delivery time
                  _buildDeliveryInfo(),
                  
                  SizedBox(height: DesignTokens.space2.h),
                  
                  // Rating
                  _buildRating(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build image section with favorite overlay
  Widget _buildImageSection() {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.cardBorderRadius.r),
          topRight: Radius.circular(DesignTokens.cardBorderRadius.r),
        ),
      ),
      child: Stack(
        children: [
          // Merchant image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DesignTokens.cardBorderRadius.r),
              topRight: Radius.circular(DesignTokens.cardBorderRadius.r),
            ),
            child: Image.asset(
              merchant.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback placeholder
                return Container(
                  color: DesignTokens.neutral200,
                  child: Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 32.w,
                      color: DesignTokens.neutral650,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Favorite heart icon overlay
          Positioned(
            top: DesignTokens.space2.h,
            right: DesignTokens.space2.w,
            child: GestureDetector(
              onTap: () => onFavoriteTapped?.call(merchant.id),
              child: Container(
                padding: EdgeInsets.all(DesignTokens.space2.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  merchant.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  size: 16.w,
                  color: merchant.isFavorite 
                      ? DesignTokens.error500 
                      : DesignTokens.neutral650,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build merchant name with restaurant icon
  Widget _buildMerchantName() {
    return Row(
      children: [
        Icon(
          Icons.restaurant,
          size: 14.w,
          color: DesignTokens.neutral650,
        ),
        SizedBox(width: DesignTokens.space1.w),
        Expanded(
          child: Text(
            merchant.name,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.neutral850,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Build delivery info (distance and time)
  Widget _buildDeliveryInfo() {
    return Text(
      '${merchant.distance.toStringAsFixed(1)} km • ${merchant.deliveryTime} min',
      style: TextStyle(
        fontSize: DesignTokens.fontSizeXs.sp,
        fontWeight: DesignTokens.fontWeightRegular,
        color: DesignTokens.neutral650,
        fontFamily: DesignTokens.fontFamilySecondary,
      ),
    );
  }

  /// Build rating with stars
  Widget _buildRating() {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 14.w,
          color: DesignTokens.warning500,
        ),
        SizedBox(width: DesignTokens.space1.w),
        Text(
          merchant.rating.toString(),
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXs.sp,
            fontWeight: DesignTokens.fontWeightMedium,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilySecondary,
          ),
        ),
      ],
    );
  }
}
