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
          color: DesignTokens.neutral500, // Light gray/off-white background
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
          boxShadow: DesignTokens.shadowMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            _buildCombinedImageAndBottomSection(),
          ],
        ),
      ),
    );
  }

  /// Build the header section with logo, name, and heart icon
  Widget _buildHeaderSection() {
    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.neutral100, // Light gray background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusMd.r),
          topRight: Radius.circular(DesignTokens.radiusMd.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.space4.w),
        child: Row(
          children: [
            // Circular logo with yellow background
            Container(
              width: 40.w,
              height: 40.w,
              // decoration: BoxDecoration(
              //   color: DesignTokens.warning950, // Yellow background
              //   shape: BoxShape.circle,
              // ),
              child: Center(
                child: Image.asset(
                  'assets/images/champion_logo.png',
                  width: 40.w,
                  height: 40.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.store,
                      size: 20.w,
                      color: DesignTokens.neutral900,
                    );
                  },
                ),
              ),
            ),

            SizedBox(width: DesignTokens.space3.w),

            // Business name (expanded to take remaining space)
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

            SizedBox(width: DesignTokens.space2.w),

            // Heart icon (outline style)
            GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                padding: EdgeInsets.all(DesignTokens.space1.w),
                child: Icon(
                  merchant.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20.w,
                  color: merchant.isFavorite
                      ? Colors.red
                      : DesignTokens.neutral600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the combined image and bottom section with shared background
  Widget _buildCombinedImageAndBottomSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white, // White background color
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
      ),
      child: Column(
        children: [
          // Image section
          Container(
            height: 150.h,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: DesignTokens.space4.w,
              left: DesignTokens.space4.w,
              right: DesignTokens.space4.w,
            ),
            child: merchant.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                    child: _buildImageWidget(merchant.imageUrl!),
                  )
                : _buildPlaceholderImage(),
          ),
          
          // Bottom info section
          Padding(
            padding: EdgeInsets.all(DesignTokens.space4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Distance and time info (left side)
                Text(
                  '${merchant.distance} • ${merchant.duration}',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm.sp,
                    fontWeight: DesignTokens.fontWeightRegular,
                    color: DesignTokens.neutral600,
                    fontFamily: DesignTokens.fontFamilyPrimary,
                  ),
                ),

                // Rating with yellow star icon (right side)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.space2.w,
                    vertical: DesignTokens.space1.h,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.warning50, // Light orange background
                    borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.w,
                        color: DesignTokens.warning500, // Yellow star
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
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [DesignTokens.primary100, DesignTokens.primary200],
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

}
