import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../utils/validators.dart';

/// Custom text field widget following Apple's Human Interface Guidelines
/// 
/// This widget provides a consistent text input design throughout the app
/// with modern, sleek styling and built-in validation.

class CustomTextField extends StatefulWidget {
  /// The text field label
  final String label;
  
  /// The text field hint text
  final String? hint;
  
  /// The current text value
  final String? value;
  
  /// Callback when the text changes
  final ValueChanged<String>? onChanged;
  
  /// Callback when the text field is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// Whether the text field is enabled
  final bool enabled;
  
  /// Whether the text field is read-only
  final bool readOnly;
  
  /// Whether the text field is required
  final bool required;
  
  /// The text field type for validation
  final TextFieldType type;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Maximum number of characters
  final int? maxLength;
  
  /// Whether to obscure the text (for passwords)
  final bool obscureText;
  
  /// The text input action
  final TextInputAction? textInputAction;
  
  /// The keyboard type
  final TextInputType? keyboardType;
  
  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// Custom validator function
  final String? Function(String?)? validator;
  
  /// Prefix icon
  final IconData? prefixIcon;
  
  /// Suffix icon
  final IconData? suffixIcon;
  
  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;
  
  /// Whether to show character count
  final bool showCharacterCount;
  
  /// Whether to show validation errors
  final bool showValidationErrors;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.type = TextFieldType.text,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.showCharacterCount = false,
    this.showValidationErrors = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isObscured = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _isObscured = widget.obscureText;
    
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
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

  void _onFocusChange() {
    if (!_focusNode.hasFocus && widget.showValidationErrors) {
      _validateField();
    }
  }

  void _validateField() {
    final text = _controller.text;
    String? error;
    
    if (widget.required && text.isEmpty) {
      error = '${widget.label} is required';
    } else if (text.isNotEmpty) {
      error = _validateByType(text);
    }
    
    if (widget.validator != null) {
      error = widget.validator!(text);
    }
    
    setState(() {
      _errorText = error;
    });
  }

  String? _validateByType(String text) {
    switch (widget.type) {
      case TextFieldType.email:
        return Validators.isValidEmail(text) ? null : 'Please enter a valid email';
      case TextFieldType.password:
        return Validators.isValidPassword(text) ? null : 'Password must be at least 8 characters with uppercase, lowercase, and number';
      case TextFieldType.phone:
        return Validators.isValidPhoneNumber(text) ? null : 'Please enter a valid phone number';
      case TextFieldType.username:
        return Validators.isValidUsername(text) ? null : 'Username can only contain letters, numbers, and underscores';
      case TextFieldType.text:
        return null;
    }
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        // Text Field
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: _isObscured,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType ?? _getKeyboardType(),
          inputFormatters: widget.inputFormatters,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.showValidationErrors) {
              _validateField();
            }
          },
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.gray)
                : null,
            suffixIcon: _buildSuffixIcon(),
            filled: true,
            fillColor: widget.enabled ? AppColors.surface : AppColors.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        
        // Error Text
        if (_errorText != null && widget.showValidationErrors) ...[
          const SizedBox(height: 4),
          Text(
            _errorText!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.error,
            ),
          ),
        ],
        
        // Character Count
        if (widget.showCharacterCount && widget.maxLength != null) ...[
          const SizedBox(height: 4),
          Text(
            '${_controller.text.length}/${widget.maxLength}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.type == TextFieldType.password) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: AppColors.gray,
        ),
        onPressed: _toggleObscureText,
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon, color: AppColors.gray),
        onPressed: widget.onSuffixIconTap,
      );
    }
    
    return null;
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.text:
      case TextFieldType.username:
        return TextInputType.text;
    }
  }
}

/// Text field type variants for validation
enum TextFieldType {
  text,
  email,
  password,
  phone,
  username,
}
