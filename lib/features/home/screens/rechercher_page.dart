import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';

/// Rechercher (Search) page
/// 
/// This page will contain the search functionality with:
/// - Advanced search interface
/// - Filters and categories
/// - Search results display
/// - Search history and suggestions
/// 
/// Currently a placeholder for future implementation.
class RechercherPage extends StatelessWidget {
  const RechercherPage({super.key});

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
                Icons.search,
                size: 64.w,
                color: DesignTokens.primary700,
              ),
              SizedBox(height: DesignTokens.space6.h),
              Text(
                'Rechercher',
                style: TextStyle(
                  fontSize: DesignTokens.fontSize2xl.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: DesignTokens.space4.h),
              Text(
                'Page de recherche en cours de développement',
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
