import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/design_tokens.dart';

/// Filter Chips Widget
/// 
/// A reusable filter chip component with consistent styling.
class FilterChip extends StatelessWidget {
  const FilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.backgroundColor,
    this.selectedColor,
    this.checkmarkColor,
    this.side,
    this.shape,
  });

  final Widget label;
  final bool selected;
  final Function(bool) onSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? checkmarkColor;
  final BorderSide? side;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    final borderRadius = shape is RoundedRectangleBorder 
        ? (shape as RoundedRectangleBorder).borderRadius 
        : BorderRadius.circular(DesignTokens.radiusXl.r);
    
    return Material(
      color: selected 
          ? (selectedColor ?? DesignTokens.primary500)
          : (backgroundColor ?? Colors.white),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () => onSelected(!selected),
        borderRadius: borderRadius as BorderRadius?,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.space4.w,
            vertical: DesignTokens.space2.h,
          ),
          decoration: BoxDecoration(
            color: selected 
                ? (selectedColor ?? DesignTokens.primary500)
                : (backgroundColor ?? Colors.white),
            borderRadius: borderRadius,
            border: side != null 
                ? Border.all(
                    color: selected 
                        ? (selectedColor ?? DesignTokens.primary500)
                        : side!.color,
                    width: side!.width,
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              label,
              if (selected) ...[
                SizedBox(width: DesignTokens.space1.w),
                Icon(
                  Icons.check,
                  size: 16.w,
                  color: checkmarkColor ?? Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
