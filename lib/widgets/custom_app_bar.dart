import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/design_tokens.dart';

/// Custom App Bar Widget
/// 
/// A reusable app bar with consistent styling and optional actions.
/// Supports back button, title, and custom actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions = const [],
    this.backgroundColor,
    this.elevation,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget> actions;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? DesignTokens.neutral50,
      elevation: elevation ?? 0,
      surfaceTintColor: Colors.transparent,
      leading: showBackButton
          ? Container(
            decoration: BoxDecoration(
              color: DesignTokens.neutral100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 20.w,
                  color: DesignTokens.neutral900,
                ),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              ),
          )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: DesignTokens.neutral900,
          fontFamily: 'SF Pro Display',
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
