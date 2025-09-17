import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/design_tokens.dart';

/// Figma Input Component
/// 
/// This component implements your Figma input design exactly.
/// Update the styling to match your Figma specifications.

class FigmaInput extends StatefulWidget {
  /// Input label
  final String? label;
  
  /// Input hint text
  final String? hint;
  
  /// Input value
  final String? value;
  
  /// Input type from Figma
  final FigmaInputType type;
  
  /// Input size from Figma
  final FigmaInputSize size;
  
  /// Input state from Figma
  final FigmaInputState state;
  
  /// Whether the input is enabled
  final bool enabled;
  
  /// Whether the input is required
  final bool required;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Maximum number of characters
  final int? maxLength;
  
  /// Whether to obscure the text
  final bool obscureText;
  
  /// Text input action
  final TextInputAction? textInputAction;
  
  /// Keyboard type
  final TextInputType? keyboardType;
  
  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// Callback when text changes
  final ValueChanged<String>? onChanged;
  
  /// Callback when input is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// Custom validator
  final String? Function(String?)? validator;
  
  /// Prefix icon
  final IconData? prefixIcon;
  
  /// Suffix icon
  final IconData? suffixIcon;
  
  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;
  
  /// Error message
  final String? errorText;
  
  /// Helper text
  final String? helperText;

  const FigmaInput({
    super.key,
    this.label,
    this.hint,
    this.value,
    this.type = FigmaInputType.text,
    this.size = FigmaInputSize.medium,
    this.state = FigmaInputState.normal,
    this.enabled = true,
    this.required = false,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.errorText,
    this.helperText,
  });

  @override
  State<FigmaInput> createState() => _FigmaInputState();
}

class _FigmaInputState extends State<FigmaInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(FigmaInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          _buildLabel(),
          SizedBox(height: DesignTokens.space2.h),
        ],
        
        // Input Field
        _buildInputField(),
        
        // Error or Helper Text
        if (widget.errorText != null || widget.helperText != null) ...[
          SizedBox(height: DesignTokens.space1.h),
          _buildHelperText(),
        ],
      ],
    );
  }

  /// Builds the label
  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        text: widget.label,
        style: TextStyle(
          fontSize: DesignTokens.fontSizeSm.sp,
          fontWeight: DesignTokens.fontWeightMedium,
          color: _getLabelColor(),
        ),
        children: widget.required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: DesignTokens.error500,
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  /// Builds the input field
  Widget _buildInputField() {
    return Container(
      height: _getInputHeight(),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(DesignTokens.radiusBase.r),
        border: _getBorder(),
        boxShadow: _getBoxShadow(),
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        obscureText: _isObscured,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType ?? _getKeyboardType(),
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        style: _getTextStyle(),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: _getHintStyle(),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: _getIconSize(),
                  color: _getIconColor(),
                )
              : null,
          suffixIcon: _buildSuffixIcon(),
          border: InputBorder.none,
          contentPadding: _getContentPadding(),
          counterText: '',
        ),
      ),
    );
  }

  /// Builds the suffix icon
  Widget? _buildSuffixIcon() {
    if (widget.type == FigmaInputType.password) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          size: _getIconSize(),
          color: _getIconColor(),
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(
          widget.suffixIcon,
          size: _getIconSize(),
          color: _getIconColor(),
        ),
        onPressed: widget.onSuffixIconTap,
      );
    }
    
    return null;
  }

  /// Builds helper text
  Widget _buildHelperText() {
    final text = widget.errorText ?? widget.helperText!;
    final color = widget.errorText != null ? DesignTokens.error500 : DesignTokens.neutral600;
    
    return Text(
      text,
      style: TextStyle(
        fontSize: DesignTokens.fontSizeXs.sp,
        color: color,
      ),
    );
  }

  /// Gets input height based on size
  double _getInputHeight() {
    switch (widget.size) {
      case FigmaInputSize.small:
        return 36.h;
      case FigmaInputSize.medium:
        return DesignTokens.inputHeight.h;
      case FigmaInputSize.large:
        return 56.h;
    }
  }

  /// Gets icon size based on size
  double _getIconSize() {
    switch (widget.size) {
      case FigmaInputSize.small:
        return 16.sp;
      case FigmaInputSize.medium:
        return 20.sp;
      case FigmaInputSize.large:
        return 24.sp;
    }
  }

  /// Gets content padding based on size
  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case FigmaInputSize.small:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.space3.w,
          vertical: DesignTokens.space2.h,
        );
      case FigmaInputSize.medium:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.inputPaddingHorizontal.w,
          vertical: DesignTokens.inputPaddingVertical.h,
        );
      case FigmaInputSize.large:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.space5.w,
          vertical: DesignTokens.space4.h,
        );
    }
  }

  /// Gets text style
  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: _getFontSize(),
      fontWeight: DesignTokens.fontWeightRegular,
      color: _getTextColor(),
    );
  }

  /// Gets hint style
  TextStyle _getHintStyle() {
    return TextStyle(
      fontSize: _getFontSize(),
      fontWeight: DesignTokens.fontWeightRegular,
      color: _getHintColor(),
    );
  }

  /// Gets font size based on size
  double _getFontSize() {
    switch (widget.size) {
      case FigmaInputSize.small:
        return DesignTokens.fontSizeSm.sp;
      case FigmaInputSize.medium:
        return DesignTokens.fontSizeBase.sp;
      case FigmaInputSize.large:
        return DesignTokens.fontSizeLg.sp;
    }
  }

  /// Gets text color
  Color _getTextColor() {
    if (!widget.enabled) return DesignTokens.neutral400;
    return DesignTokens.neutral900;
  }

  /// Gets hint color
  Color _getHintColor() {
    return DesignTokens.neutral500;
  }

  /// Gets label color
  Color _getLabelColor() {
    if (!widget.enabled) return DesignTokens.neutral400;
    return DesignTokens.neutral700;
  }

  /// Gets icon color
  Color _getIconColor() {
    if (!widget.enabled) return DesignTokens.neutral400;
    return DesignTokens.neutral500;
  }

  /// Gets background color
  Color _getBackgroundColor() {
    if (!widget.enabled) return DesignTokens.neutral100;
    return Colors.white;
  }

  /// Gets border
  Border? _getBorder() {
    if (widget.state == FigmaInputState.error) {
      return Border.all(
        color: DesignTokens.error500,
        width: DesignTokens.inputBorderWidth,
      );
    }
    
    if (widget.state == FigmaInputState.focused) {
      return Border.all(
        color: DesignTokens.primary500,
        width: DesignTokens.inputBorderWidth,
      );
    }
    
    return Border.all(
      color: DesignTokens.neutral200,
      width: DesignTokens.inputBorderWidth,
    );
  }

  /// Gets box shadow
  List<BoxShadow>? _getBoxShadow() {
    if (widget.state == FigmaInputState.focused) {
      return [
        BoxShadow(
          color: DesignTokens.primary500.withValues(alpha: 0.1),
          offset: const Offset(0, 0),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ];
    }
    return null;
  }

  /// Gets keyboard type based on input type
  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case FigmaInputType.email:
        return TextInputType.emailAddress;
      case FigmaInputType.phone:
        return TextInputType.phone;
      case FigmaInputType.password:
        return TextInputType.visiblePassword;
      case FigmaInputType.number:
        return TextInputType.number;
      case FigmaInputType.text:
        return TextInputType.text;
    }
  }
}

/// Input types from Figma
enum FigmaInputType {
  text,
  email,
  phone,
  password,
  number,
}

/// Input sizes from Figma
enum FigmaInputSize {
  small,
  medium,
  large,
}

/// Input states from Figma
enum FigmaInputState {
  normal,
  focused,
  error,
  disabled,
}
