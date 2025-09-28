import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/design_tokens.dart';

/// Simple Search Bar Widget
/// 
/// A reusable search input field with consistent styling.
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: DesignTokens.neutral200,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd.r),
        border: Border.all(
          color: DesignTokens.neutral300,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: DesignTokens.fontSizeSm.sp,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.neutral900,
          fontFamily: DesignTokens.fontFamilyPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: DesignTokens.fontSizeSm.sp,
            fontWeight: DesignTokens.fontWeightRegular,
            color: DesignTokens.neutral600,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20.w,
                  color: DesignTokens.neutral600,
                )
              : null,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: DesignTokens.space4.w,
            vertical: DesignTokens.space3.h,
          ),
        ),
      ),
    );
  }
}
