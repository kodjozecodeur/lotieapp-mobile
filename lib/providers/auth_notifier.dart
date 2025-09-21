import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../services/token_service.dart';
import '../core/di/service_locator.dart';
import '../core/utils/logger.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';

/// Authentication state model using Freezed
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(AuthStatus.unknown) AuthStatus status,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}

/// Authentication status enum
enum AuthStatus {
  unknown,      // Initial state, checking authentication
  authenticated, // User is logged in
  unauthenticated, // User is not logged in
}

/// Extension for computed properties
extension AuthStateX on AuthState {
  /// Whether the user is authenticated
  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  
  /// Whether we're in an unknown state (still checking)
  bool get isUnknown => status == AuthStatus.unknown;
  
  /// Whether user is definitely not authenticated
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  
  /// Whether there's an error
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
  
  /// User display name
  String get displayName => user?.name ?? 'User';
  
  /// User email
  String get email => user?.email ?? '';
}

/// Riverpod notifier for authentication state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;
  late final TokenService _tokenService;

  @override
  AuthState build() {
    // Get dependencies from service locator
    _authRepository = getIt<AuthRepository>();
    _tokenService = getIt<TokenService>();
    
    // Initialize authentication status
    _initializeAuth();
    
    // Return initial state
    return const AuthState(
      status: AuthStatus.unknown,
      isLoading: true,
    );
  }

  /// Initialize authentication status
  Future<void> _initializeAuth() async {
    try {
      logger.info('[AuthNotifier] Initializing authentication - API not connected, defaulting to unauthenticated');
      
      // TODO: Remove this when API is connected
      // For now, always start as unauthenticated since API is not ready
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        user: null,
        errorMessage: null,
      );
      logger.info('[AuthNotifier] Set to unauthenticated for development');
      
      /* Original auth check logic - restore when API is ready:
      // Check if we have valid tokens
      final hasToken = await _tokenService.hasAccessToken();
      final isTokenValid = await _tokenService.isCurrentTokenValid();
      
      if (hasToken && isTokenValid) {
        // Try to get current user
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          state = state.copyWith(
            user: user,
            status: AuthStatus.authenticated,
            isLoading: false,
            errorMessage: null,
          );
          logger.info('[AuthNotifier] User restored from token: ${user.email}');
          return;
        }
      }
      
      // No valid authentication found
      await _tokenService.clearTokens();
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        user: null,
        errorMessage: null,
      );
      logger.info('[AuthNotifier] No valid authentication found');
      */
      
    } catch (e, stackTrace) {
      logger.error('[AuthNotifier] Failed to initialize auth', e, stackTrace);
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: 'Failed to initialize authentication',
      );
    }
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    logger.info('[AuthNotifier] Attempting login for: $email');
    
    // Set loading state
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      // Validate input
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      // Call repository
      final result = await _authRepository.login(email, password);
      
      if (result.success && result.user != null && result.accessToken != null) {
        // Save tokens
        await _tokenService.saveTokens(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken,
        );
        
        // Save user data
        await _tokenService.saveUserData(result.user!.toJson());
        
        // Update state
        state = state.copyWith(
          user: result.user,
          status: AuthStatus.authenticated,
          isLoading: false,
          errorMessage: null,
        );
        
        logger.info('[AuthNotifier] Login successful for: $email');
        return true;
      } else {
        // Login failed
        final errorMessage = result.errorMessage ?? 'Login failed';
        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
          status: AuthStatus.unauthenticated,
        );
        
        logger.warning('[AuthNotifier] Login failed: $errorMessage');
        return false;
      }
    } catch (e, stackTrace) {
      logger.error('[AuthNotifier] Login error', e, stackTrace);
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        status: AuthStatus.unauthenticated,
      );
      return false;
    }
  }

  /// Register a new user
  Future<bool> register(String email, String password, String name) async {
    logger.info('[AuthNotifier] Attempting registration for: $email');
    
    // Set loading state
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      // Validate input
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        throw Exception('All fields are required');
      }

      // Call repository
      final result = await _authRepository.register(email, password, name);
      
      if (result.success && result.user != null && result.accessToken != null) {
        // Save tokens
        await _tokenService.saveTokens(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken,
        );
        
        // Save user data
        await _tokenService.saveUserData(result.user!.toJson());
        
        // Update state
        state = state.copyWith(
          user: result.user,
          status: AuthStatus.authenticated,
          isLoading: false,
          errorMessage: null,
        );
        
        logger.info('[AuthNotifier] Registration successful for: $email');
        return true;
      } else {
        // Registration failed
        final errorMessage = result.errorMessage ?? 'Registration failed';
        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
          status: AuthStatus.unauthenticated,
        );
        
        logger.warning('[AuthNotifier] Registration failed: $errorMessage');
        return false;
      }
    } catch (e, stackTrace) {
      logger.error('[AuthNotifier] Registration error', e, stackTrace);
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        status: AuthStatus.unauthenticated,
      );
      return false;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    logger.info('[AuthNotifier] Logging out user');
    
    // Set loading state
    state = state.copyWith(isLoading: true);

    try {
      // Call repository logout
      await _authRepository.logout();
      
      // Clear all tokens and user data
      await _tokenService.clearAll();
      
      // Update state
      state = const AuthState(
        status: AuthStatus.unauthenticated,
        isLoading: false,
      );
      
      logger.info('[AuthNotifier] Logout successful');
    } catch (e, stackTrace) {
      logger.error('[AuthNotifier] Logout error', e, stackTrace);
      
      // Even if logout fails, clear local state
      await _tokenService.clearAll();
      state = AuthState(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: 'Logout completed with errors: ${e.toString()}',
      );
    }
  }

  /// Clear any error messages
  void clearError() {
    if (state.hasError) {
      state = state.copyWith(errorMessage: null);
    }
  }
}

/// Convenient providers for accessing auth state
@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
}

@riverpod
UserModel? currentUser(Ref ref) {
  return ref.watch(authNotifierProvider).user;
}

@riverpod
bool isLoading(Ref ref) {
  return ref.watch(authNotifierProvider).isLoading;
}

@riverpod
String? authError(Ref ref) {
  return ref.watch(authNotifierProvider).errorMessage;
}
