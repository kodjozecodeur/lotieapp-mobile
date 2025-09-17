import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Custom button widget following Apple's Human Interface Guidelines
/// 
/// This widget provides a consistent button design throughout the app
/// with modern, sleek styling that matches the iOS design language.

class CustomButton extends StatelessWidget {
  /// The text to display on the button
  final String text;
  
  /// Callback function when the button is pressed
  final VoidCallback? onPressed;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// The button style variant
  final CustomButtonStyle style;
  
  /// Whether the button should expand to fill available width
  final bool isExpanded;
  
  /// The button size
  final ButtonSize size;
  
  /// Custom icon to display before the text
  final IconData? icon;
  
  /// Whether to show a loading indicator
  final bool showLoadingIndicator;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.style = CustomButtonStyle.primary,
    this.isExpanded = false,
    this.size = ButtonSize.medium,
    this.icon,
    this.showLoadingIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(context).resolve({}),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Builds the button content (text, icon, loading indicator)
  Widget _buildButtonContent() {
    if (isLoading && showLoadingIndicator) {
      return SizedBox(
        width: _getLoadingIndicatorSize(),
        height: _getLoadingIndicatorSize(),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: 8),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }

  /// Gets the button height based on size
  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 52;
    }
  }

  /// Gets the icon size based on button size
  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
    }
  }

  /// Gets the loading indicator size based on button size
  double _getLoadingIndicatorSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  /// Gets the text style based on button size
  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.medium:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.large:
        return const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        );
    }
  }

  /// Gets the button style based on the style variant
  WidgetStateProperty<ButtonStyle> _getButtonStyle(BuildContext context) {
    final baseStyle = ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: _getPadding(),
    );

    switch (style) {
      case CustomButtonStyle.primary:
        return WidgetStateProperty.all(baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.gray
                : AppColors.primary,
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ));
      case CustomButtonStyle.secondary:
        return WidgetStateProperty.all(baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.lightGray
                : AppColors.secondary,
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ));
      case CustomButtonStyle.outline:
        return WidgetStateProperty.all(baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.gray
                : AppColors.primary,
          ),
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? AppColors.gray
                  : AppColors.primary,
              width: 1,
            ),
          ),
        ));
      case CustomButtonStyle.text:
        return WidgetStateProperty.all(baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.disabled)
                ? AppColors.gray
                : AppColors.primary,
          ),
          elevation: WidgetStateProperty.all(0),
        ));
    }
  }

  /// Gets the button padding based on size
  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }
}

/// Button style variants
enum CustomButtonStyle {
  primary,
  secondary,
  outline,
  text,
}

/// Button size variants
enum ButtonSize {
  small,
  medium,
  large,
}
