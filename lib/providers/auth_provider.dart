import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

/// Authentication provider using Provider pattern
/// 
/// This provider manages authentication state and operations
/// following clean architecture principles. It handles user login,
/// logout, registration, and state management.

class AuthProvider extends ChangeNotifier {
  // TODO: Remove this provider when migration to Riverpod is complete
  late final ApiService _apiService;
  
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  /// Current authenticated user
  UserModel? get user => _user;
  
  /// Whether the user is authenticated
  bool get isAuthenticated => _user != null;
  
  /// Whether an operation is in progress
  bool get isLoading => _isLoading;
  
  /// Current error message
  String? get errorMessage => _errorMessage;

  /// Initializes the authentication provider
  /// 
  /// This method should be called when the app starts to check
  /// if there's a stored authentication token
  Future<void> initialize() async {
    _setLoading(true);
    try {
      // TODO: Check for stored authentication token
      // TODO: Validate token with server
      // TODO: Load user data if token is valid
      print('[AuthProvider] Initializing authentication...');
    } catch (e) {
      _setError('Failed to initialize authentication: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Logs in a user with email and password
  /// 
  /// [email] - User's email address
  /// [password] - User's password
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      print('[AuthProvider] Attempting login for: $email');
      
      // TODO: Implement actual login API call
      // final response = await _apiService.post('/auth/login', data: {
      //   'email': email,
      //   'password': password,
      // });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Parse response and create user model
      // _user = UserModel.fromJson(response['user']);
      // _apiService.setAuthToken(response['token']);
      
      // Simulate successful login
      _user = UserModel(
        id: '1',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      print('[AuthProvider] Login successful for: $email');
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Login failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Registers a new user
  /// 
  /// [email] - User's email address
  /// [password] - User's password
  /// [name] - User's display name
  Future<bool> register(String email, String password, String name) async {
    _setLoading(true);
    _clearError();
    
    try {
      print('[AuthProvider] Attempting registration for: $email');
      
      // TODO: Implement actual registration API call
      // final response = await _apiService.post('/auth/register', data: {
      //   'email': email,
      //   'password': password,
      //   'name': name,
      // });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Parse response and create user model
      // _user = UserModel.fromJson(response['user']);
      // _apiService.setAuthToken(response['token']);
      
      // Simulate successful registration
      _user = UserModel(
        id: '1',
        email: email,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      print('[AuthProvider] Registration successful for: $email');
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Registration failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Logs out the current user
  Future<void> logout() async {
    _setLoading(true);
    
    try {
      print('[AuthProvider] Logging out user');
      
      // TODO: Implement logout API call
      // await _apiService.post('/auth/logout');
      
      // Clear local data
      _user = null;
      _apiService.clearAuthToken();
      
      print('[AuthProvider] Logout successful');
      notifyListeners();
    } catch (e) {
      _setError('Logout failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Updates the current user's profile
  /// 
  /// [name] - New display name
  /// [phoneNumber] - New phone number
  Future<bool> updateProfile({
    String? name,
    String? phoneNumber,
  }) async {
    if (_user == null) return false;
    
    _setLoading(true);
    _clearError();
    
    try {
      print('[AuthProvider] Updating profile');
      
      // TODO: Implement actual profile update API call
      // final response = await _apiService.put('/user/profile', data: {
      //   'name': name,
      //   'phoneNumber': phoneNumber,
      // });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Update local user data
      _user = _user!.copyWith(
        name: name ?? _user!.name,
        phoneNumber: phoneNumber ?? _user!.phoneNumber,
        updatedAt: DateTime.now(),
      );
      
      print('[AuthProvider] Profile updated successfully');
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Profile update failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Sets an error message
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Clears the current error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
