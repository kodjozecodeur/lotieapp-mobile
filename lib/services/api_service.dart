import 'dart:convert';
import 'package:dio/dio.dart';
import '../core/config/api_config.dart';
import '../core/utils/logger.dart';
import '../models/api_response.dart';
import 'token_service.dart';

/// API service for handling HTTP requests with Express.js backend
/// 
/// This service handles all API communication following clean architecture
/// principles. It provides methods for GET, POST, PUT, DELETE operations
/// with proper error handling, JWT token management, and Express.js integration.

class ApiService {
  final TokenService _tokenService;
  late Dio _dio;

  ApiService(this._tokenService);

  /// Initializes the API service with Express.js configuration
  void initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: ApiConfig.defaultHeaders,
      ),
    );

    // Add JWT authentication interceptor
    _dio.interceptors.add(_createAuthInterceptor());
    
    // Add logging interceptor
    _dio.interceptors.add(_createLoggingInterceptor());
    
    // Add error handling interceptor
    _dio.interceptors.add(_createErrorInterceptor());
    
    logger.info('[ApiService] Initialized with base URL: ${ApiConfig.baseUrl}');
  }

  /// Creates JWT authentication interceptor
  InterceptorsWrapper _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add JWT token to requests
        final token = await _tokenService.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers[ApiConfig.tokenHeader] = '${ApiConfig.tokenPrefix} $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Handle 401 Unauthorized - attempt token refresh
        if (error.response?.statusCode == 401) {
          final refreshed = await _attemptTokenRefresh();
          if (refreshed) {
            // Retry the original request with new token
            final token = await _tokenService.getAccessToken();
            if (token != null) {
              error.requestOptions.headers[ApiConfig.tokenHeader] = '${ApiConfig.tokenPrefix} $token';
              try {
                final response = await _dio.fetch(error.requestOptions);
                return handler.resolve(response);
              } catch (retryError) {
                return handler.next(DioException.requestCancelled(
                  requestOptions: error.requestOptions,
                  reason: 'Token refresh retry failed',
                ));
              }
            }
          }
        }
        handler.next(error);
      },
    );
  }

  /// Creates logging interceptor
  InterceptorsWrapper _createLoggingInterceptor() {
    return InterceptorsWrapper(
        onRequest: (options, handler) {
        logger.apiRequest(
          options.method,
          options.uri.toString(),
          data: options.data,
        );
          handler.next(options);
        },
        onResponse: (response, handler) {
        logger.apiResponse(
          response.requestOptions.method,
          response.requestOptions.uri.toString(),
          response.statusCode ?? 0,
        );
          handler.next(response);
        },
        onError: (error, handler) {
        logger.apiError(
          error.requestOptions.method,
          error.requestOptions.uri.toString(),
          error,
        );
          handler.next(error);
        },
    );
  }

  /// Creates error handling interceptor
  InterceptorsWrapper _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        final apiException = _handleDioError(error);
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          error: apiException,
          type: error.type,
          response: error.response,
        ));
      },
    );
  }

  /// Attempt to refresh JWT token
  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken == null) {
        logger.warning('[ApiService] No refresh token available');
        return false;
      }

      logger.info('[ApiService] Attempting token refresh');
      
      final response = await _dio.post(
        ApiConfig.buildAuthUrl('refresh'),
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {ApiConfig.tokenHeader: '${ApiConfig.tokenPrefix} $refreshToken'},
        ),
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(
          response.data,
          (data) => data as Map<String, dynamic>,
        );

        if (apiResponse.success && apiResponse.data != null) {
          final authData = apiResponse.data!;
          await _tokenService.saveTokens(
            accessToken: authData['accessToken'] as String,
            refreshToken: authData['refreshToken'] as String?,
          );
          
          logger.info('[ApiService] Token refresh successful');
          return true;
        }
      }
      
      logger.warning('[ApiService] Token refresh failed - invalid response');
      return false;
    } catch (e) {
      logger.error('[ApiService] Token refresh failed', e);
      await _tokenService.clearTokens(); // Clear invalid tokens
      return false;
    }
  }

  /// Sets the authorization token for authenticated requests
  /// 
  /// [token] - The authentication token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Removes the authorization token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// Performs a GET request
  /// 
  /// [path] - The API endpoint path
  /// [queryParameters] - Query parameters for the request
  /// [options] - Additional request options
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Performs a POST request
  /// 
  /// [path] - The API endpoint path
  /// [data] - The request body data
  /// [queryParameters] - Query parameters for the request
  /// [options] - Additional request options
  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Performs a PUT request
  /// 
  /// [path] - The API endpoint path
  /// [data] - The request body data
  /// [queryParameters] - Query parameters for the request
  /// [options] - Additional request options
  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Performs a DELETE request
  /// 
  /// [path] - The API endpoint path
  /// [queryParameters] - Query parameters for the request
  /// [options] - Additional request options
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handles the API response and extracts data
  /// 
  /// [response] - The Dio response object
  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else if (response.data is String) {
        return jsonDecode(response.data as String) as Map<String, dynamic>;
      } else {
        return {'data': response.data};
      }
    } else {
      throw ApiException(
        message: 'Request failed with status: ${response.statusCode}',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  /// Handles Dio errors and converts them to API exceptions
  /// 
  /// [error] - The Dio exception
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request was cancelled',
          code: 'CANCELLED',
          statusCode: 499,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'No internet connection. Please check your network.',
          code: 'NETWORK_ERROR',
          statusCode: 0,
        );
      default:
        return ApiException(
          message: 'An unexpected error occurred',
          code: 'UNKNOWN',
          statusCode: 500,
        );
    }
  }

  /// Handle bad response errors with Express.js error format
  ApiException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? 500;
    final responseData = error.response?.data;

    // Try to parse Express.js error response format
    if (responseData is Map<String, dynamic>) {
      final errorData = responseData['error'] as Map<String, dynamic>?;
      if (errorData != null) {
        return ApiException(
          message: errorData['message'] as String? ?? 'Server error occurred',
          code: errorData['code'] as String?,
          statusCode: statusCode,
          details: errorData['details'] as Map<String, dynamic>?,
        );
      }
      
      // Fallback to direct message
      final message = responseData['message'] as String? ?? 'Server error occurred';
      return ApiException(
        message: message,
        statusCode: statusCode,
      );
    }

    // Default error message based on status code
    String message;
    String? code;
    
    switch (statusCode) {
      case 400:
        message = 'Bad request. Please check your input.';
        code = 'BAD_REQUEST';
        break;
      case 401:
        message = 'Unauthorized. Please login again.';
        code = 'UNAUTHORIZED';
        break;
      case 403:
        message = 'Access forbidden.';
        code = 'FORBIDDEN';
        break;
      case 404:
        message = 'Resource not found.';
        code = 'NOT_FOUND';
        break;
      case 422:
        message = 'Validation failed. Please check your input.';
        code = 'VALIDATION_ERROR';
        break;
      case 500:
        message = 'Internal server error. Please try again later.';
        code = 'SERVER_ERROR';
        break;
      default:
        message = 'Server error occurred (Status: $statusCode)';
        code = 'HTTP_ERROR';
    }

    return ApiException(
      message: message,
      code: code,
      statusCode: statusCode,
    );
  }
}

