import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';

/// Favoris (Favorites) page
/// 
/// This page will contain the user's favorite items:
/// - Favorite merchants
/// - Favorite products
/// - Organized lists and categories
/// - Quick access to favorites
/// 
/// Currently a placeholder for future implementation.
class FavorisPage extends StatelessWidget {
  const FavorisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.neutral50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DesignTokens.space5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 64.w,
                color: DesignTokens.error500,
              ),
              SizedBox(height: DesignTokens.space6.h),
              Text(
                'Favoris',
                style: TextStyle(
                  fontSize: DesignTokens.fontSize2xl.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: DesignTokens.space4.h),
              Text(
                'Page des favoris en cours de développement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase.sp,
                  fontWeight: DesignTokens.fontWeightRegular,
                  color: DesignTokens.neutral650,
                  fontFamily: DesignTokens.fontFamilySecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
