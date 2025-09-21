import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Standard API response model for Express.js backend
/// 
/// This follows the common Express.js response pattern:
/// ```json
/// {
///   "success": true,
///   "data": { ... },
///   "message": "Operation successful",
///   "meta": { "timestamp": "2024-01-01T00:00:00Z" }
/// }
/// ```
/// 
/// For errors:
/// ```json
/// {
///   "success": false,
///   "error": {
///     "message": "Error description",
///     "code": "ERROR_CODE",
///     "details": { ... }
///   }
/// }
/// ```

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    T? data,
    String? message,
    ApiError? error,
    ApiMeta? meta,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  /// Factory constructor for successful responses
  factory ApiResponse.success({
    required T data,
    String? message,
    ApiMeta? meta,
  }) =>
      ApiResponse(
        success: true,
        data: data,
        message: message,
        meta: meta,
      );

  /// Factory constructor for error responses
  factory ApiResponse.error({
    required ApiError error,
    String? message,
    ApiMeta? meta,
  }) =>
      ApiResponse(
        success: false,
        error: error,
        message: message,
        meta: meta,
      );
}

/// API error model for Express.js error responses
@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    required String message,
    String? code,
    Map<String, dynamic>? details,
    int? statusCode,
    String? field, // For validation errors
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  /// Factory for validation errors
  factory ApiError.validation({
    required String message,
    required String field,
    Map<String, dynamic>? details,
  }) =>
      ApiError(
        message: message,
        code: 'VALIDATION_ERROR',
        field: field,
        details: details,
        statusCode: 400,
      );

  /// Factory for authentication errors
  factory ApiError.unauthorized({
    String message = 'Unauthorized access',
  }) =>
      ApiError(
        message: message,
        code: 'UNAUTHORIZED',
        statusCode: 401,
      );

  /// Factory for forbidden errors
  factory ApiError.forbidden({
    String message = 'Access forbidden',
  }) =>
      ApiError(
        message: message,
        code: 'FORBIDDEN',
        statusCode: 403,
      );

  /// Factory for not found errors
  factory ApiError.notFound({
    String message = 'Resource not found',
  }) =>
      ApiError(
        message: message,
        code: 'NOT_FOUND',
        statusCode: 404,
      );

  /// Factory for server errors
  factory ApiError.serverError({
    String message = 'Internal server error',
  }) =>
      ApiError(
        message: message,
        code: 'SERVER_ERROR',
        statusCode: 500,
      );

  /// Factory for network errors
  factory ApiError.networkError({
    String message = 'Network connection failed',
  }) =>
      ApiError(
        message: message,
        code: 'NETWORK_ERROR',
        statusCode: 0,
      );
}

/// API metadata for additional response information
@freezed
class ApiMeta with _$ApiMeta {
  const factory ApiMeta({
    String? timestamp,
    String? requestId,
    int? totalCount,
    int? page,
    int? pageSize,
    bool? hasMore,
    Map<String, dynamic>? extra,
  }) = _ApiMeta;

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);

  /// Factory for pagination metadata
  factory ApiMeta.pagination({
    required int totalCount,
    required int page,
    required int pageSize,
    String? timestamp,
    String? requestId,
  }) =>
      ApiMeta(
        totalCount: totalCount,
        page: page,
        pageSize: pageSize,
        hasMore: (page * pageSize) < totalCount,
        timestamp: timestamp,
        requestId: requestId,
      );
}

/// Authentication response model from Express.js
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    String? refreshToken,
    required Map<String, dynamic> user,
    String? tokenType,
    int? expiresIn,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final String? code;
  final int statusCode;
  final Map<String, dynamic>? details;

  const ApiException({
    required this.message,
    this.code,
    required this.statusCode,
    this.details,
  });

  factory ApiException.fromApiError(ApiError error) {
    return ApiException(
      message: error.message,
      code: error.code,
      statusCode: error.statusCode ?? 500,
      details: error.details,
    );
  }

  @override
  String toString() {
    return 'ApiException: $message (Code: $code, Status: $statusCode)';
  }

  /// Check if this is a network-related error
  bool get isNetworkError => statusCode == 0 || code == 'NETWORK_ERROR';

  /// Check if this is an authentication error
  bool get isAuthError => statusCode == 401 || code == 'UNAUTHORIZED';

  /// Check if this is a validation error
  bool get isValidationError => statusCode == 400 || code == 'VALIDATION_ERROR';

  /// Check if this is a server error
  bool get isServerError => statusCode >= 500;
}
