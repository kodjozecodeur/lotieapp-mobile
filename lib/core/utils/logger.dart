import 'package:logger/logger.dart';
import '../config/api_config.dart';

/// Centralized logging service for the application
/// 
/// This replaces all print statements with proper logging that can be:
/// - Filtered by level (debug, info, warning, error)
/// - Disabled in production
/// - Formatted consistently
/// - Sent to crash reporting services

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  late final Logger _logger;

  /// Initialize the logger with appropriate configuration
  void initialize() {
    _logger = Logger(
      filter: _LogFilter(),
      printer: _LogPrinter(),
      output: _LogOutput(),
    );
  }

  /// Debug level logging
  /// 
  /// Use for detailed debugging information that is only relevant
  /// when diagnosing problems
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info level logging
  /// 
  /// Use for general information about app flow
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning level logging
  /// 
  /// Use for potentially harmful situations
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error level logging
  /// 
  /// Use for error events that might still allow the app to continue
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal level logging
  /// 
  /// Use for very severe error events that might cause the app to terminate
  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// API request logging
  void apiRequest(String method, String url, {Map<String, dynamic>? data}) {
    debug('[API Request] $method $url', data);
  }

  /// API response logging
  void apiResponse(String method, String url, int statusCode, {dynamic data}) {
    if (statusCode >= 200 && statusCode < 300) {
      debug('[API Response] $method $url - $statusCode');
    } else {
      warning('[API Response] $method $url - $statusCode', data);
    }
  }

  /// API error logging
  void apiError(String method, String url, dynamic error, [StackTrace? stackTrace]) {
    this.error('[API Error] $method $url', error, stackTrace);
  }

  /// Authentication logging
  void auth(String action, {String? email, dynamic error}) {
    if (error != null) {
      this.error('[Auth] $action failed', error);
    } else {
      info('[Auth] $action successful${email != null ? ' for $email' : ''}');
    }
  }

  /// Navigation logging
  void navigation(String from, String to) {
    debug('[Navigation] $from → $to');
  }

  /// State change logging
  void stateChange(String provider, String change) {
    debug('[State] $provider: $change');
  }
}

/// Custom log filter that respects environment settings
class _LogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // In production, only log warnings and errors
    if (EnvironmentConfig.environment == 'production') {
      return event.level.value >= Level.warning.value;
    }

    // In development, respect the LOG_LEVEL environment variable
    final logLevel = EnvironmentConfig.logLevel.toLowerCase();
    switch (logLevel) {
      case 'debug':
        return true;
      case 'info':
        return event.level.value >= Level.info.value;
      case 'warning':
        return event.level.value >= Level.warning.value;
      case 'error':
        return event.level.value >= Level.error.value;
      default:
        return true;
    }
  }
}

/// Custom log printer with clean formatting
class _LogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final timestamp = DateTime.now().toIso8601String();
    
    final message = event.message;
    final error = event.error;
    final stackTrace = event.stackTrace;

    List<String> output = [];

    // Main log line
    output.add(color!('$emoji [$timestamp] $message'));

    // Error details if present
    if (error != null) {
      output.add(color('Error: $error'));
    }

    // Stack trace if present (only in debug mode)
    if (stackTrace != null && EnvironmentConfig.isDebug) {
      output.add(color('Stack trace:'));
      output.addAll(stackTrace.toString().split('\n').map((line) => color(line)));
    }

    return output;
  }
}

/// Custom log output that can be extended for crash reporting
class _LogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // Default output to console
    for (var line in event.lines) {
      print(line);
    }

    // TODO: Add crash reporting integration here
    // if (EnvironmentConfig.enableCrashReporting && event.level.value >= Level.error.value) {
    //   // Send to crash reporting service (Firebase Crashlytics, Sentry, etc.)
    // }
  }
}

/// Global logger instance for easy access
final logger = AppLogger();

/// Extension methods for easier logging
extension LoggerExtension on Object {
  void logDebug(String message) => logger.debug('[$runtimeType] $message');
  void logInfo(String message) => logger.info('[$runtimeType] $message');
  void logWarning(String message) => logger.warning('[$runtimeType] $message');
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.error('[$runtimeType] $message', error, stackTrace);
  }
}
