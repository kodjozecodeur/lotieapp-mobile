import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/design_tokens.dart';

/// Figma Button Component
/// 
/// This component implements your Figma button design exactly.
/// Update the styling to match your Figma specifications.

class FigmaButton extends StatelessWidget {
  /// Button text
  final String text;
  
  /// Button variant from Figma
  final FigmaButtonVariant variant;
  
  /// Button size from Figma
  final FigmaButtonSize size;
  
  /// Whether the button is enabled
  final bool enabled;
  
  /// Whether the button is in loading state
  final bool isLoading;
  
  /// Whether the button should expand to fill width
  final bool isExpanded;
  
  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Custom icon
  final IconData? icon;
  
  /// Icon position
  final FigmaButtonIconPosition iconPosition;

  const FigmaButton({
    super.key,
    required this.text,
    this.variant = FigmaButtonVariant.primary,
    this.size = FigmaButtonSize.medium,
    this.enabled = true,
    this.isLoading = false,
    this.isExpanded = false,
    this.onPressed,
    this.icon,
    this.iconPosition = FigmaButtonIconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: _getButtonStyle(),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Builds the button content
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: _getLoadingIndicatorSize(),
        height: _getLoadingIndicatorSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
        ),
      );
    }

    if (icon != null) {
      return _buildButtonWithIcon();
    }

    return Text(
      text,
      style: _getTextStyle(),
    );
  }

  /// Builds button with icon
  Widget _buildButtonWithIcon() {
    final iconWidget = Icon(
      icon,
      size: _getIconSize(),
      color: _getTextColor(),
    );

    final textWidget = Text(
      text,
      style: _getTextStyle(),
    );

    if (iconPosition == FigmaButtonIconPosition.left) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          SizedBox(width: DesignTokens.space2),
          textWidget,
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          textWidget,
          SizedBox(width: DesignTokens.space2),
          iconWidget,
        ],
      );
    }
  }

  /// Gets button height based on size
  double _getButtonHeight() {
    switch (size) {
      case FigmaButtonSize.small:
        return DesignTokens.buttonHeightSm;
      case FigmaButtonSize.medium:
        return DesignTokens.buttonHeightBase;
      case FigmaButtonSize.large:
        return DesignTokens.buttonHeightLg;
    }
  }

  /// Gets icon size based on button size
  double _getIconSize() {
    switch (size) {
      case FigmaButtonSize.small:
        return 16.sp;
      case FigmaButtonSize.medium:
        return 20.sp;
      case FigmaButtonSize.large:
        return 24.sp;
    }
  }

  /// Gets loading indicator size
  double _getLoadingIndicatorSize() {
    switch (size) {
      case FigmaButtonSize.small:
        return 16.sp;
      case FigmaButtonSize.medium:
        return 20.sp;
      case FigmaButtonSize.large:
        return 24.sp;
    }
  }

  /// Gets text style based on size
  TextStyle _getTextStyle() {
    double fontSize;
    FontWeight fontWeight;

    switch (size) {
      case FigmaButtonSize.small:
        fontSize = DesignTokens.fontSizeSm;
        fontWeight = DesignTokens.fontWeightMedium;
        break;
      case FigmaButtonSize.medium:
        fontSize = DesignTokens.fontSizeBase;
        fontWeight = DesignTokens.fontWeightSemiBold;
        break;
      case FigmaButtonSize.large:
        fontSize = DesignTokens.fontSizeLg;
        fontWeight = DesignTokens.fontWeightSemiBold;
        break;
    }

    return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: _getTextColor(),
      letterSpacing: DesignTokens.letterSpacingNormal,
    );
  }

  /// Gets text color based on variant
  Color _getTextColor() {
    switch (variant) {
      case FigmaButtonVariant.primary:
        return Colors.white;
      case FigmaButtonVariant.secondary:
        return DesignTokens.primary500;
      case FigmaButtonVariant.outline:
        return DesignTokens.primary500;
      case FigmaButtonVariant.ghost:
        return DesignTokens.primary500;
      case FigmaButtonVariant.danger:
        return Colors.white;
    }
  }

  /// Gets button style based on variant
  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.buttonPaddingHorizontal.w,
        vertical: DesignTokens.buttonPaddingVertical.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
        side: _getBorderSide(),
      ),
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      disabledBackgroundColor: _getDisabledBackgroundColor(),
      disabledForegroundColor: _getDisabledTextColor(),
    );
  }

  /// Gets background color based on variant
  Color _getBackgroundColor() {
    switch (variant) {
      case FigmaButtonVariant.primary:
        return DesignTokens.primary500;
      case FigmaButtonVariant.secondary:
        return DesignTokens.primary50;
      case FigmaButtonVariant.outline:
        return Colors.transparent;
      case FigmaButtonVariant.ghost:
        return Colors.transparent;
      case FigmaButtonVariant.danger:
        return DesignTokens.error500;
    }
  }

  /// Gets disabled background color
  Color _getDisabledBackgroundColor() {
    switch (variant) {
      case FigmaButtonVariant.primary:
        return DesignTokens.neutral300;
      case FigmaButtonVariant.secondary:
        return DesignTokens.neutral100;
      case FigmaButtonVariant.outline:
        return Colors.transparent;
      case FigmaButtonVariant.ghost:
        return Colors.transparent;
      case FigmaButtonVariant.danger:
        return DesignTokens.neutral300;
    }
  }

  /// Gets disabled text color
  Color _getDisabledTextColor() {
    return DesignTokens.neutral500;
  }

  /// Gets border side based on variant
  BorderSide _getBorderSide() {
    switch (variant) {
      case FigmaButtonVariant.primary:
        return BorderSide.none;
      case FigmaButtonVariant.secondary:
        return BorderSide.none;
      case FigmaButtonVariant.outline:
        return BorderSide(
          color: DesignTokens.primary500,
          width: DesignTokens.inputBorderWidth,
        );
      case FigmaButtonVariant.ghost:
        return BorderSide.none;
      case FigmaButtonVariant.danger:
        return BorderSide.none;
    }
  }
}

/// Button variants from Figma
enum FigmaButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
}

/// Button sizes from Figma
enum FigmaButtonSize {
  small,
  medium,
  large,
}

/// Icon positions
enum FigmaButtonIconPosition {
  left,
  right,
}
