import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/design_tokens.dart';
import '../models/top_merchant.dart';

/// Merchant Card Widget
/// 
/// A reusable merchant card component that displays merchant information
/// with image, name, rating, and other details.
class MerchantCard extends StatelessWidget {
  const MerchantCard({
    super.key,
    required this.merchant,
    this.onTap,
    this.onFavoriteToggle,
  });

  final TopMerchant merchant;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
          boxShadow: [
            BoxShadow(
              color: DesignTokens.neutral200.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  /// Build the image section with heart icon overlay
  Widget _buildImageSection() {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Main image
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(DesignTokens.radiusMd.r),
                topRight: Radius.circular(DesignTokens.radiusMd.r),
              ),
              color: DesignTokens.neutral200,
            ),
            child: merchant.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DesignTokens.radiusMd.r),
                      topRight: Radius.circular(DesignTokens.radiusMd.r),
                    ),
                    child: _buildImageWidget(merchant.imageUrl!),
                  )
                : _buildPlaceholderImage(),
          ),
          
          // Heart icon positioned over top-right of image
          Positioned(
            top: 12.h,
            right: 12.w,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  merchant.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20.w,
                  color: merchant.isFavorite ? Colors.red : DesignTokens.neutral600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build image widget that handles both local assets and network URLs
  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      // Network image
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
      );
    } else {
      // Local asset image
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
      );
    }
  }

  /// Build placeholder image when no image is provided
  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusMd.r),
          topRight: Radius.circular(DesignTokens.radiusMd.r),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DesignTokens.primary100,
            DesignTokens.primary200,
          ],
        ),
      ),
      child: Icon(
        merchant.merchantType == MerchantType.supermarket 
            ? Icons.store 
            : Icons.restaurant,
        size: 48.w,
        color: DesignTokens.primary950,
      ),
    );
  }

  /// Build the content section
  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.space4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business name and star rating row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Business name (large, bold text)
              Expanded(
                child: Text(
                  merchant.businessName,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg.sp,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // Star rating with yellow star icon and rating number
              Container(
                padding: EdgeInsets.symmetric(horizontal: DesignTokens.space2.w, vertical: DesignTokens.space1.h),
                decoration: BoxDecoration(
                  color: DesignTokens.warning50,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16.w,
                      color: DesignTokens.warning500,
                    ),
                    SizedBox(width: DesignTokens.space1.w),
                    Text(
                      merchant.rating.toString(),
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm.sp,
                        fontWeight: DesignTokens.fontWeightSemiBold,
                        color: DesignTokens.neutral900,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: DesignTokens.space2.h),
          
          // Category/type (smaller gray text below name)
          Text(
            '${merchant.category} • ${merchant.subcategory}',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm.sp,
              fontWeight: DesignTokens.fontWeightRegular,
              color: DesignTokens.neutral600,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: DesignTokens.space3.h),
          
          // Price starting from (green text, prominent)
          Text(
            merchant.priceFrom,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase.sp,
              fontWeight: DesignTokens.fontWeightSemiBold,
              color: DesignTokens.primary500,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
          
          SizedBox(height: DesignTokens.space2.h),
          
          // Distance and time info (small gray text)
          Text(
            '${merchant.distance} • ${merchant.duration}',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXs.sp,
              fontWeight: DesignTokens.fontWeightRegular,
              color: DesignTokens.neutral500,
              fontFamily: DesignTokens.fontFamilyPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
