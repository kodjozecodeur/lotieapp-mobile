import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/design_tokens.dart';

/// Section header component
/// 
/// This widget displays a reusable section header with:
/// - Section title on the left
/// - Arrow icon on the right for navigation
/// - Consistent styling across all sections
/// 
/// Used for "Top Marchands", "Promotions", "Recommandés pour vous"
/// All styling uses DesignTokens for consistency.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTapped,
    this.showArrow = true,
  });

  /// Section title text
  final String title;
  
  /// Callback when "see all" arrow is tapped
  final VoidCallback? onSeeAllTapped;
  
  /// Whether to show the arrow icon
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        Text(
          title,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg.sp,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.neutral850,
            fontFamily: DesignTokens.fontFamilyPrimary,
          ),
        ),
        
        // Arrow button (if enabled)
        if (showArrow)
          GestureDetector(
            onTap: onSeeAllTapped,
            child: Container(
              padding: EdgeInsets.all(DesignTokens.space2.w),
              child: Icon(
                Icons.arrow_forward,
                size: 20.w,
                color: DesignTokens.neutral700,
              ),
            ),
          ),
      ],
    );
  }
}
