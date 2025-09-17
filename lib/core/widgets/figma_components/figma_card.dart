import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/design_tokens.dart';

/// Figma Card Component
/// 
/// This component implements your Figma card design exactly.
/// Update the styling to match your Figma specifications.

class FigmaCard extends StatelessWidget {
  /// Card content
  final Widget child;
  
  /// Card variant from Figma
  final FigmaCardVariant variant;
  
  /// Card elevation
  final double? elevation;
  
  /// Card padding
  final EdgeInsets? padding;
  
  /// Card margin
  final EdgeInsets? margin;
  
  /// Card border radius
  final double? borderRadius;
  
  /// Card background color
  final Color? backgroundColor;
  
  /// Card border
  final Border? border;
  
  /// Whether the card is clickable
  final bool isClickable;
  
  /// Callback when card is tapped
  final VoidCallback? onTap;

  const FigmaCard({
    super.key,
    required this.child,
    this.variant = FigmaCardVariant.elevated,
    this.elevation,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.isClickable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(
          (borderRadius ?? DesignTokens.cardBorderRadius).r,
        ),
        border: border ?? _getBorder(),
        boxShadow: _getBoxShadow(),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(DesignTokens.cardPadding.w),
        child: child,
      ),
    );

    if (isClickable) {
      return GestureDetector(
        onTap: onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }

  /// Gets background color based on variant
  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    
    switch (variant) {
      case FigmaCardVariant.elevated:
        return Colors.white;
      case FigmaCardVariant.outlined:
        return Colors.white;
      case FigmaCardVariant.filled:
        return DesignTokens.neutral50;
      case FigmaCardVariant.ghost:
        return Colors.transparent;
    }
  }

  /// Gets border based on variant
  Border? _getBorder() {
    if (border != null) return border;
    
    switch (variant) {
      case FigmaCardVariant.elevated:
        return null;
      case FigmaCardVariant.outlined:
        return Border.all(
          color: DesignTokens.neutral200,
          width: 1,
        );
      case FigmaCardVariant.filled:
        return null;
      case FigmaCardVariant.ghost:
        return null;
    }
  }

  /// Gets box shadow based on variant
  List<BoxShadow>? _getBoxShadow() {
    if (elevation != null) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          offset: const Offset(0, 2),
          blurRadius: elevation! * 2,
          spreadRadius: 0,
        ),
      ];
    }
    
    switch (variant) {
      case FigmaCardVariant.elevated:
        return DesignTokens.shadowBase;
      case FigmaCardVariant.outlined:
        return null;
      case FigmaCardVariant.filled:
        return null;
      case FigmaCardVariant.ghost:
        return null;
    }
  }
}

/// Card variants from Figma
enum FigmaCardVariant {
  elevated,
  outlined,
  filled,
  ghost,
}

/// Figma Card Header Component
class FigmaCardHeader extends StatelessWidget {
  /// Header title
  final String title;
  
  /// Header subtitle
  final String? subtitle;
  
  /// Header action widget
  final Widget? action;
  
  /// Header padding
  final EdgeInsets? padding;

  const FigmaCardHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: DesignTokens.space4.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeLg.sp,
                    fontWeight: DesignTokens.fontWeightSemiBold,
                    color: DesignTokens.neutral900,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: DesignTokens.space1.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm.sp,
                      fontWeight: DesignTokens.fontWeightRegular,
                      color: DesignTokens.neutral600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// Figma Card Content Component
class FigmaCardContent extends StatelessWidget {
  /// Content widget
  final Widget child;
  
  /// Content padding
  final EdgeInsets? padding;

  const FigmaCardContent({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}

/// Figma Card Footer Component
class FigmaCardFooter extends StatelessWidget {
  /// Footer content
  final Widget child;
  
  /// Footer padding
  final EdgeInsets? padding;

  const FigmaCardFooter({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: DesignTokens.space4.h),
      child: child,
    );
  }
}
