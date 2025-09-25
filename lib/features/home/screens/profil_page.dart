import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/design_tokens.dart';

/// Profil (Profile) page
/// 
/// This page will contain the user's profile information and settings:
/// - User profile information
/// - Account settings
/// - Preferences and notifications
/// - Help and support
/// 
/// Currently a placeholder for future implementation.
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
                Icons.person,
                size: 64.w,
                color: DesignTokens.info500,
              ),
              SizedBox(height: DesignTokens.space6.h),
              Text(
                'Mon profil',
                style: TextStyle(
                  fontSize: DesignTokens.fontSize2xl.sp,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),
              SizedBox(height: DesignTokens.space4.h),
              Text(
                'Page du profil en cours de développement',
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
