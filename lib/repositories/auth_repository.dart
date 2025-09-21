import '../models/user_model.dart';
import '../models/api_response.dart';
import '../services/api_service.dart';
import '../core/config/api_config.dart';
import '../core/utils/logger.dart';

/// Abstract repository for authentication operations
/// 
/// This follows the repository pattern to provide a clean interface
/// for authentication operations, allowing easy switching between
/// mock and real API implementations.

abstract class AuthRepository {
  /// Login with email and password
  Future<AuthResult> login(String email, String password);
  
  /// Register a new user
  Future<AuthResult> register(String email, String password, String name);
  
  /// Logout current user
  Future<void> logout();
  
  /// Get current user profile
  Future<UserModel?> getCurrentUser();
  
  /// Update user profile
  Future<UserModel> updateProfile({
    String? name,
    String? phoneNumber,
  });
  
  /// Check if user is authenticated
  Future<bool> isAuthenticated();
  
  /// Refresh authentication token
  Future<bool> refreshToken();
}

/// Authentication result model
class AuthResult {
  final bool success;
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;
  final String? errorCode;

  const AuthResult({
    required this.success,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
    this.errorCode,
  });

  /// Factory for successful authentication
  factory AuthResult.success({
    required UserModel user,
    required String accessToken,
    String? refreshToken,
  }) =>
      AuthResult(
        success: true,
        user: user,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  /// Factory for failed authentication
  factory AuthResult.failure({
    required String errorMessage,
    String? errorCode,
  }) =>
      AuthResult(
        success: false,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
}

/// Real API implementation of AuthRepository for Express.js backend
class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<AuthResult> login(String email, String password) async {
    try {
      logger.info('[AuthRepository] Attempting login for: $email');

      // Check if we should use mock data
      if (ApiConfig.useMockData) {
        return _mockLogin(email, password);
      }

      // Real API call to Express.js backend
      final response = await _apiService.post(
        ApiConfig.authEndpoints['login']!,
        data: {
          'email': email,
          'password': password,
        },
      );

      final apiResponse = ApiResponse.fromJson(
        response,
        (data) => data as Map<String, dynamic>,
      );

      if (apiResponse.success && apiResponse.data != null) {
        final authData = apiResponse.data!;
        final user = UserModel.fromJson(authData['user'] as Map<String, dynamic>);
        
        logger.info('[AuthRepository] Login successful for: $email');
        return AuthResult.success(
          user: user,
          accessToken: authData['accessToken'] as String,
          refreshToken: authData['refreshToken'] as String?,
        );
      } else {
        final errorMessage = apiResponse.error?.message ?? 'Login failed';
        logger.warning('[AuthRepository] Login failed: $errorMessage');
        return AuthResult.failure(
          errorMessage: errorMessage,
          errorCode: apiResponse.error?.code,
        );
      }
    } on ApiException catch (e) {
      logger.error('[AuthRepository] Login API error', e);
      return AuthResult.failure(
        errorMessage: e.message,
        errorCode: e.code,
      );
    } catch (e, stackTrace) {
      logger.error('[AuthRepository] Login unexpected error', e, stackTrace);
      return AuthResult.failure(
        errorMessage: 'An unexpected error occurred during login',
        errorCode: 'UNKNOWN_ERROR',
      );
    }
  }

  @override
  Future<AuthResult> register(String email, String password, String name) async {
    try {
      logger.info('[AuthRepository] Attempting registration for: $email');

      // Check if we should use mock data
      if (ApiConfig.useMockData) {
        return _mockRegister(email, password, name);
      }

      // Real API call to Express.js backend
      final response = await _apiService.post(
        ApiConfig.authEndpoints['register']!,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      final apiResponse = ApiResponse.fromJson(
        response,
        (data) => data as Map<String, dynamic>,
      );

      if (apiResponse.success && apiResponse.data != null) {
        final authData = apiResponse.data!;
        final user = UserModel.fromJson(authData['user'] as Map<String, dynamic>);
        
        logger.info('[AuthRepository] Registration successful for: $email');
        return AuthResult.success(
          user: user,
          accessToken: authData['accessToken'] as String,
          refreshToken: authData['refreshToken'] as String?,
        );
      } else {
        final errorMessage = apiResponse.error?.message ?? 'Registration failed';
        logger.warning('[AuthRepository] Registration failed: $errorMessage');
        return AuthResult.failure(
          errorMessage: errorMessage,
          errorCode: apiResponse.error?.code,
        );
      }
    } on ApiException catch (e) {
      logger.error('[AuthRepository] Registration API error', e);
      return AuthResult.failure(
        errorMessage: e.message,
        errorCode: e.code,
      );
    } catch (e, stackTrace) {
      logger.error('[AuthRepository] Registration unexpected error', e, stackTrace);
      return AuthResult.failure(
        errorMessage: 'An unexpected error occurred during registration',
        errorCode: 'UNKNOWN_ERROR',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      logger.info('[AuthRepository] Logging out user');

      if (!ApiConfig.useMockData) {
        // Call logout endpoint if using real API
        try {
          await _apiService.post(ApiConfig.authEndpoints['logout']!);
        } catch (e) {
          // Continue with logout even if API call fails
          logger.warning('[AuthRepository] Logout API call failed, continuing with local logout', e);
        }
      }

      logger.info('[AuthRepository] Logout completed');
    } catch (e, stackTrace) {
      logger.error('[AuthRepository] Logout error', e, stackTrace);
      // Don't throw, always complete logout
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (ApiConfig.useMockData) {
        return _mockGetCurrentUser();
      }

      final response = await _apiService.get(ApiConfig.authEndpoints['me']!);
      final apiResponse = ApiResponse.fromJson(
        response,
        (data) => data as Map<String, dynamic>,
      );

      if (apiResponse.success && apiResponse.data != null) {
        return UserModel.fromJson(apiResponse.data!['user'] as Map<String, dynamic>);
      }
      
      return null;
    } catch (e, stackTrace) {
      logger.error('[AuthRepository] Get current user error', e, stackTrace);
      return null;
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? phoneNumber,
  }) async {
    try {
      logger.info('[AuthRepository] Updating user profile');

      if (ApiConfig.useMockData) {
        return _mockUpdateProfile(name: name, phoneNumber: phoneNumber);
      }

      final response = await _apiService.put(
        ApiConfig.userEndpoints['updateProfile']!,
        data: {
          if (name != null) 'name': name,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
        },
      );

      final apiResponse = ApiResponse.fromJson(
        response,
        (data) => data as Map<String, dynamic>,
      );

      if (apiResponse.success && apiResponse.data != null) {
        final user = UserModel.fromJson(apiResponse.data!['user'] as Map<String, dynamic>);
        logger.info('[AuthRepository] Profile updated successfully');
        return user;
      } else {
        throw ApiException(
          message: apiResponse.error?.message ?? 'Profile update failed',
          code: apiResponse.error?.code,
          statusCode: 400,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[AuthRepository] Update profile error', e, stackTrace);
      throw ApiException(
        message: 'An unexpected error occurred during profile update',
        code: 'UNKNOWN_ERROR',
        statusCode: 500,
      );
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    // This will be handled by the TokenService through the notifier
    return false; // Placeholder
  }

  @override
  Future<bool> refreshToken() async {
    // This will be handled by the API service interceptor
    return false; // Placeholder
  }

  // Mock implementations for development/testing
  Future<AuthResult> _mockLogin(String email, String password) async {
    logger.info('[AuthRepository] Using mock login');
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simple validation for demo
    if (email.isEmpty || password.isEmpty) {
      return AuthResult.failure(
        errorMessage: 'Email and password are required',
        errorCode: 'VALIDATION_ERROR',
      );
    }
    
    if (email == 'test@example.com' && password == 'password') {
      final user = UserModel(
        id: '1',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      return AuthResult.success(
        user: user,
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );
    }
    
    return AuthResult.failure(
      errorMessage: 'Invalid email or password',
      errorCode: 'INVALID_CREDENTIALS',
    );
  }

  Future<AuthResult> _mockRegister(String email, String password, String name) async {
    logger.info('[AuthRepository] Using mock registration');
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simple validation for demo
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      return AuthResult.failure(
        errorMessage: 'All fields are required',
        errorCode: 'VALIDATION_ERROR',
      );
    }
    
    final user = UserModel(
      id: '1',
      email: email,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    return AuthResult.success(
      user: user,
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
    );
  }

  Future<UserModel?> _mockGetCurrentUser() async {
    logger.debug('[AuthRepository] Using mock get current user');
    
    // Return mock user if we have a "token"
    return UserModel(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<UserModel> _mockUpdateProfile({String? name, String? phoneNumber}) async {
    logger.info('[AuthRepository] Using mock update profile');
    
    await Future.delayed(const Duration(seconds: 1));
    
    return UserModel(
      id: '1',
      email: 'test@example.com',
      name: name ?? 'Test User',
      phoneNumber: phoneNumber,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }
}
