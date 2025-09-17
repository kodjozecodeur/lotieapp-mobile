/// Application strings and text constants
/// 
/// This file contains all the text strings used throughout the app.
/// Centralizing strings here makes the app easier to maintain and
/// prepares it for internationalization.

class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // General
  static const String appName = 'Lotie App';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String done = 'Done';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String back = 'Back';
  static const String close = 'Close';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
  
  // Navigation
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String search = 'Search';
  static const String notifications = 'Notifications';
  
  // Error Messages
  static const String networkError = 'Network connection error';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'An unknown error occurred';
  static const String validationError = 'Please check your input';
  static const String authenticationError = 'Authentication failed';
  
  // Success Messages
  static const String dataSaved = 'Data saved successfully';
  static const String dataDeleted = 'Data deleted successfully';
  static const String operationCompleted = 'Operation completed successfully';
  
  // Placeholders
  static const String noData = 'No data available';
  static const String noResults = 'No results found';
  static const String emptyList = 'List is empty';
  static const String comingSoon = 'Coming soon...';
}
