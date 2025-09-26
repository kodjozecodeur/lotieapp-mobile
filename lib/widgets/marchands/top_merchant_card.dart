import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/design_tokens.dart';

/// Top Merchant Card Widget
/// 
/// This widget displays a merchant card with:
/// - Left side: Square image (store/business photo)
/// - Right side: Business information in column layout
/// - Heart icon (favorite button) positioned over top-right of image
/// - Rounded rectangle container with subtle shadow
/// 
/// Visual specifications:
/// - White background with rounded corners
/// - Green color for pricing text
/// - Gray color for secondary information
/// - Yellow/gold color for star ratings
/// - Heart icon as outline style overlay
class TopMerchantCard extends StatelessWidget {
  const TopMerchantCard({
    super.key,
    required this.businessName,
    required this.category,
    required this.subcategory,
    required this.priceFrom,
    required this.distance,
    required this.duration,
    required this.rating,
    this.imageUrl,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  /// Business name (large, bold text)
  final String businessName;
  
  /// Category/type (smaller gray text below name)
  final String category;
  
  /// Subcategory (smaller gray text below name)
  final String subcategory;
  
  /// Price starting from text
  final String priceFrom;
  
  /// Distance text (e.g., "3km")
  final String distance;
  
  /// Duration text (e.g., "5 min")
  final String duration;
  
  /// Star rating number (e.g., 4.4)
  final double rating;
  
  /// Image URL (optional)
  final String? imageUrl;
  
  /// Whether this merchant is favorited
  final bool isFavorite;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;
  
  /// Callback when favorite button is tapped
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: DesignTokens.space2.h,
        ),
        // decoration: BoxDecoration(
        //   color: Colors.white,
          
        // ),
        child: Padding(
          padding: EdgeInsets.only(
            top: DesignTokens.space3.w,
            // bottom: DesignTokens.space8.w,
            left: DesignTokens.space0.w,
            right: DesignTokens.space0.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Square image with heart icon overlay
              _buildImageSection(),
              
              // Spacing between image and content
              SizedBox(width: DesignTokens.space4.w),
              
              // Right side: Business information
              Expanded(
                child: _buildBusinessInfo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the image section with heart icon overlay
  Widget _buildImageSection() {
    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: Stack(
        children: [
          // Square image
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
              color: DesignTokens.neutral200,
            ),
            child: imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
                    child: _buildImageWidget(imageUrl!),
                  )
                : _buildPlaceholderImage(),
          ),
          
          // Heart icon positioned over top-right of image
          Positioned(
            top: 4.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 16.w,
                  color: isFavorite ? Colors.red : DesignTokens.neutral600,
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
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
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
        Icons.store,
        size: 32.w,
        color: DesignTokens.primary950,
      ),
    );
  }

  /// Build the business information section
  Widget _buildBusinessInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Business name and star rating row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Business name (large, bold text)
            Expanded(
              child: Text(
                businessName,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeLg.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Star rating with yellow star icon and rating number
            Container(
              padding: EdgeInsets.all(DesignTokens.space1.w),
              decoration: BoxDecoration(
                color: DesignTokens.secondarykbackground950,
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 14.w,
                    height: 14.h,
                    colorFilter: ColorFilter.mode(
                      DesignTokens.warning950,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: DesignTokens.space1.w),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      fontWeight: DesignTokens.fontWeightMedium,
                      color: DesignTokens.neutral700,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        SizedBox(height: DesignTokens.space1.h),
        
        // Category/type (smaller gray text below name)
        Text(
          '$category, $subcategory',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: DesignTokens.neutral600,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        SizedBox(height: DesignTokens.space2.h),
        
        // Price starting from (green text, prominent)
        Text(
          priceFrom,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeBase.sp,
            fontWeight: DesignTokens.fontWeightSemiBold,
            color: DesignTokens.primary950,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        
        SizedBox(height: DesignTokens.space2.h),
        
        // Distance and time info (small gray text)
        Text(
          '$distance • $duration',
          style: TextStyle(
            fontSize: DesignTokens.fontSizeXs.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: DesignTokens.neutral650,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
      ],
    );
  }
}
