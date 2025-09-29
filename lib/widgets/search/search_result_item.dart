import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/design_tokens.dart';
import '../../services/search_service.dart';

/// Search result item widget
/// 
/// Displays individual search results with:
/// - Image/icon
/// - Title and subtitle
/// - Type indicator
/// - Tap handling
class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.result,
    this.onTap,
  });

  final SearchResult result;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: DesignTokens.space3.h),
        padding: EdgeInsets.all(DesignTokens.space4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
          border: Border.all(
            color: DesignTokens.neutral200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image/Icon
            _buildImage(),
            
            SizedBox(width: DesignTokens.space4.w),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    result.title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase.sp,
                      fontWeight: DesignTokens.fontWeightSemiBold,
                      color: DesignTokens.neutral900,
                      fontFamily: DesignTokens.fontFamilyPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: DesignTokens.space1.h),
                  
                  // Subtitle
                  Text(
                    result.subtitle,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral600,
                      fontFamily: DesignTokens.fontFamilySecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: DesignTokens.space2.h),
                  
                  // Type badge
                  _buildTypeBadge(),
                ],
              ),
            ),
            
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: DesignTokens.neutral400,
            ),
          ],
        ),
      ),
    );
  }

  /// Build image/icon
  Widget _buildImage() {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: _getTypeColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
      ),
      child: Center(
        child: _buildImageContent(),
      ),
    );
  }

  /// Build image content based on type
  Widget _buildImageContent() {
    switch (result.type) {
      case SearchResultType.merchant:
        return Icon(
          Icons.store,
          size: 24.w,
          color: _getTypeColor(),
        );
      case SearchResultType.product:
        return Icon(
          Icons.shopping_bag,
          size: 24.w,
          color: _getTypeColor(),
        );
      case SearchResultType.category:
        return SvgPicture.asset(
          result.imageUrl ?? 'assets/icons/promotion.svg',
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            _getTypeColor(),
            BlendMode.srcIn,
          ),
        );
    }
  }

  /// Build type badge
  Widget _buildTypeBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space2.w,
        vertical: DesignTokens.space1.h,
      ),
      decoration: BoxDecoration(
        color: _getTypeColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm.r),
      ),
      child: Text(
        _getTypeLabel(),
        style: TextStyle(
          fontSize: DesignTokens.fontSizeXs.sp,
          fontWeight: DesignTokens.fontWeightMedium,
          color: _getTypeColor(),
          fontFamily: DesignTokens.fontFamilySecondary,
        ),
      ),
    );
  }

  /// Get type color
  Color _getTypeColor() {
    switch (result.type) {
      case SearchResultType.merchant:
        return DesignTokens.primary500;
      case SearchResultType.product:
        return DesignTokens.success500;
      case SearchResultType.category:
        return DesignTokens.warning500;
    }
  }

  /// Get type label
  String _getTypeLabel() {
    switch (result.type) {
      case SearchResultType.merchant:
        return 'Marchand';
      case SearchResultType.product:
        return 'Produit';
      case SearchResultType.category:
        return 'Catégorie';
    }
  }
}
