import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/design_tokens.dart';

/// Home header component
///
/// This widget displays the header section of the home page with:
/// - Greeting message "Bonjour, Donald"
/// - Location dropdown "Agoé 2 lions" with red location icon
/// - Pass status chip "01 Pass" with green background
/// - Notification bell icon with red dot indicator
///
/// All styling uses DesignTokens for consistency.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.userName = 'Donald',
    this.location = 'Agoé 2 lions',
    this.passStatus = '01 Pass',
    this.hasNotifications = true,
    this.onLocationTapped,
    this.onPassTapped,
    this.onNotificationsTapped,
  });

  /// User's name for greeting
  final String userName;

  /// Current selected location
  final String location;

  /// Pass status text
  final String passStatus;

  /// Whether user has unread notifications
  final bool hasNotifications;

  /// Callback for location dropdown tap
  final VoidCallback? onLocationTapped;

  /// Callback for pass status tap
  final VoidCallback? onPassTapped;

  /// Callback for notifications bell tap
  final VoidCallback? onNotificationsTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left side - Greeting and location
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Bonjour, $userName',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeLg.sp,
                  fontWeight: DesignTokens.fontWeightSemiBold,
                  color: DesignTokens.neutral850,
                  fontFamily: DesignTokens.fontFamilyPrimary,
                ),
              ),

              SizedBox(height: DesignTokens.space1.h),

              // Location dropdown
              GestureDetector(
                onTap: onLocationTapped,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/location_icon.svg',
                      width: 13.w,
                      height: 13.h,
                      colorFilter: ColorFilter.mode(
                        DesignTokens.error500,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: DesignTokens.space1.w),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm.sp,
                        fontWeight: DesignTokens.fontWeightRegular,
                        color: DesignTokens.neutral700,
                        fontFamily: DesignTokens.fontFamilySecondary,
                      ),
                    ),
                    SizedBox(width: DesignTokens.space1.w),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: DesignTokens.fontSizeBase.w,
                      color: DesignTokens.neutral700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Right side - Pass status and notification
        Row(
          children: [
            // Pass status chip
            GestureDetector(
              onTap: onPassTapped,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.space3.w,
                  vertical: DesignTokens.space2.h,
                ),
                decoration: BoxDecoration(
                  color: DesignTokens.primary500_8,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusFull.r,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/wallet.svg',
                      width: 25.w,
                      height: 25.h,
                      colorFilter: ColorFilter.mode(
                        DesignTokens.primary950,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: DesignTokens.space2.w),
                    Text(
                      passStatus,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm.sp,
                        fontWeight: DesignTokens.fontWeightMedium,
                        color: DesignTokens.neutral900,
                        fontFamily: DesignTokens.fontFamilyPrimary,
                      ),
                    ),
                    SizedBox(width: DesignTokens.space1.w),
                    Icon(
                      Icons.chevron_right,
                      size: DesignTokens.fontSizeBase.w,
                      color: DesignTokens.neutral900,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: DesignTokens.space4.w),

            // Notification bell with indicator
            GestureDetector(
              onTap: onNotificationsTapped,
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: Stack(
                  children: [
                    // Bell icon
                    // The notification bell icon is not displaying because the SizedBox parent is only 24x24,
                    // but the icon is being rendered at 40x40, causing it to be clipped or not visible.
                    // To fix this, set the icon's width and height to match the SizedBox (24.w, 24.h).
                    // Also, ensure the asset path is correct and the SVG is included in pubspec.yaml.
                    SvgPicture.asset(
                      'assets/icons/notif_bell.svg',
                      width: 24.w, // Match parent SizedBox width
                      height: 24.h, // Match parent SizedBox height
                      colorFilter: ColorFilter.mode(
                        DesignTokens.neutral900,
                        BlendMode.srcIn,
                      ),
                    ),

                    // Red notification dot
                    if (hasNotifications)
                      Positioned(
                        top: 2.h,
                        right: 2.w,
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: DesignTokens.error500,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
