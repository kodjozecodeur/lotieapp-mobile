import 'dart:convert';
import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart';

/// API service for handling HTTP requests
/// 
/// This service handles all API communication following clean architecture
/// principles. It provides methods for GET, POST, PUT, DELETE operations
/// with proper error handling and response parsing.

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;

  /// Initializes the API service with base configuration
  void initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        sendTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[ApiService] Request: ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('[ApiService] Response: ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('[ApiService] Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
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
      throw _handleError(e);
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
      throw _handleError(e);
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
      throw _handleError(e);
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
      throw _handleError(e);
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
        'Request failed with status: ${response.statusCode}',
        response.statusCode ?? 500,
      );
    }
  }

  /// Handles API errors and converts them to custom exceptions
  /// 
  /// [error] - The Dio exception
  ApiException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout. Please check your internet connection.', 408);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        final message = error.response?.data?['message'] ?? 'Server error occurred';
        return ApiException(message, statusCode);
      case DioExceptionType.cancel:
        return ApiException('Request was cancelled', 499);
      case DioExceptionType.connectionError:
        return ApiException('No internet connection. Please check your network.', 0);
      default:
        return ApiException('An unexpected error occurred', 500);
    }
  }
}

/// Custom API exception class
class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
