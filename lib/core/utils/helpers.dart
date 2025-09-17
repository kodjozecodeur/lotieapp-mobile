import 'package:flutter/material.dart';

/// Helper utilities
/// 
/// This file contains utility functions that are commonly used
/// throughout the app for various operations.

class Helpers {
  // Private constructor to prevent instantiation
  Helpers._();

  /// Shows a snackbar with the given message
  /// 
  /// [context] - The build context
  /// [message] - The message to display
  /// [isError] - Whether to show as error (red) or success (green)
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Shows a confirmation dialog
  /// 
  /// [context] - The build context
  /// [title] - The dialog title
  /// [message] - The dialog message
  /// [onConfirm] - Callback when user confirms
  /// [onCancel] - Callback when user cancels
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              onCancel?.call();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm?.call();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  /// Formats a date to a readable string
  /// 
  /// [date] - The date to format
  /// [format] - The format pattern (optional)
  static String formatDate(DateTime date, {String? format}) {
    // Simple date formatting - you can enhance this with intl package
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Capitalizes the first letter of a string
  /// 
  /// [text] - The text to capitalize
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Truncates text to a maximum length
  /// 
  /// [text] - The text to truncate
  /// [maxLength] - Maximum length before truncation
  /// [suffix] - Suffix to add when truncated (default: '...')
  static String truncateText(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$suffix';
  }

  /// Checks if the device is in dark mode
  /// 
  /// [context] - The build context
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Gets the screen size
  /// 
  /// [context] - The build context
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Checks if the device is a tablet
  /// 
  /// [context] - The build context
  static bool isTablet(BuildContext context) {
    final size = getScreenSize(context);
    return size.width > 600;
  }

  /// Generates a random string of specified length
  /// 
  /// [length] - The length of the random string
  static String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();
    
    for (int i = 0; i < length; i++) {
      buffer.write(chars[(random + i) % chars.length]);
    }
    
    return buffer.toString();
  }
}
