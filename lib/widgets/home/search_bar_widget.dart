import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';

/// Search bar widget component
/// 
/// This widget displays a search input field with:
/// - Gray background container
/// - Search icon on the left
/// - Hint text "Rechercher rapide"
/// - Filter/settings icon on the right
/// - Rounded corners and proper padding
/// 
/// All styling uses DesignTokens for consistency.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    this.hintText = 'Rechercher rapide',
    this.onSearchChanged,
    this.onFilterTapped,
    this.onSearchSubmitted,
  });

  /// Hint text for the search field
  final String hintText;
  
  /// Callback when search text changes
  final Function(String)? onSearchChanged;
  
  /// Callback when filter icon is tapped
  final VoidCallback? onFilterTapped;
  
  /// Callback when search is submitted
  final Function(String)? onSearchSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DesignTokens.inputHeight.h,
      decoration: BoxDecoration(
        color: DesignTokens.neutral200,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg.r),
      ),
      child: Row(
        children: [
          // Search icon
          Padding(
            padding: EdgeInsets.only(left: DesignTokens.space4.w),
            child: Icon(
              Icons.search,
              size: 20.w,
              color: DesignTokens.neutral650,
            ),
          ),
          
          // Search input field
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              onSubmitted: onSearchSubmitted,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase.sp,
                fontWeight: DesignTokens.fontWeightRegular,
                color: DesignTokens.neutral850,
                fontFamily: DesignTokens.fontFamilySecondary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightRegular,
                  color: DesignTokens.neutral650,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.space3.w,
                  vertical: DesignTokens.inputPaddingVertical.h,
                ),
              ),
            ),
          ),
          
          // Filter/settings icon
          GestureDetector(
            onTap: onFilterTapped,
            child: Container(
              padding: EdgeInsets.all(DesignTokens.space3.w),
              child: Icon(
                Icons.tune,
                size: 20.w,
                color: DesignTokens.neutral650,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
