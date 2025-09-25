import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';

/// Commandes (Orders) page
/// 
/// This page will contain the user's order history and tracking:
/// - Current orders with tracking
/// - Order history
/// - Reorder functionality
/// - Order details and status
/// 
/// Currently a placeholder for future implementation.
class CommandesPage extends StatelessWidget {
  const CommandesPage({super.key});

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
                Icons.shopping_bag,
                size: 64.w,
                color: DesignTokens.warning500,
              ),
              SizedBox(height: DesignTokens.space6.h),
              Text(
                'Mes commandes',
                style: TextStyle(
                  fontSize: DesignTokens.fontSize2xl.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: DesignTokens.space4.h),
              Text(
                'Page des commandes en cours de développement',
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
