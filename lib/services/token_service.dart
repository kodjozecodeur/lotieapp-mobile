import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/config/api_config.dart';
import '../core/utils/logger.dart';

/// Service for managing JWT tokens securely
/// 
/// This service handles:
/// - Secure storage of access and refresh tokens
/// - Token validation and expiration checking
/// - Automatic token refresh
/// - Token cleanup on logout

class TokenService {
  final FlutterSecureStorage _secureStorage;
  
  TokenService(this._secureStorage);

  /// Save JWT tokens securely
  /// 
  /// [accessToken] - The JWT access token
  /// [refreshToken] - Optional refresh token for token renewal
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      logger.debug('[TokenService] Saving tokens to secure storage');
      
      await _secureStorage.write(
        key: ApiConfig.accessTokenKey,
        value: accessToken,
      );
      
      if (refreshToken != null) {
        await _secureStorage.write(
          key: ApiConfig.refreshTokenKey,
          value: refreshToken,
        );
      }
      
      logger.debug('[TokenService] Tokens saved successfully');
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to save tokens', e, stackTrace);
      rethrow;
    }
  }

  /// Get the stored access token
  Future<String?> getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: ApiConfig.accessTokenKey);
      logger.debug('[TokenService] Retrieved access token: ${token != null ? 'found' : 'not found'}');
      return token;
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to get access token', e, stackTrace);
      return null;
    }
  }

  /// Get the stored refresh token
  Future<String?> getRefreshToken() async {
    try {
      final token = await _secureStorage.read(key: ApiConfig.refreshTokenKey);
      logger.debug('[TokenService] Retrieved refresh token: ${token != null ? 'found' : 'not found'}');
      return token;
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to get refresh token', e, stackTrace);
      return null;
    }
  }

  /// Check if access token exists
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Check if refresh token exists
  Future<bool> hasRefreshToken() async {
    final token = await getRefreshToken();
    return token != null && token.isNotEmpty;
  }

  /// Validate JWT token format and expiration
  /// 
  /// Returns true if token is valid and not expired
  Future<bool> isTokenValid(String? token) async {
    if (token == null || token.isEmpty) {
      logger.debug('[TokenService] Token is null or empty');
      return false;
    }

    try {
      // Parse JWT token (simple validation)
      final parts = token.split('.');
      if (parts.length != 3) {
        logger.warning('[TokenService] Invalid JWT format');
        return false;
      }

      // Decode payload
      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;

      // Check expiration
      final exp = payloadMap['exp'] as int?;
      if (exp == null) {
        logger.warning('[TokenService] Token has no expiration');
        return false;
      }

      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final now = DateTime.now();
      final isValid = expirationDate.isAfter(now);

      logger.debug('[TokenService] Token validation: $isValid (expires: $expirationDate)');
      return isValid;
    } catch (e, stackTrace) {
      logger.error('[TokenService] Token validation failed', e, stackTrace);
      return false;
    }
  }

  /// Check if current access token is valid
  Future<bool> isCurrentTokenValid() async {
    final token = await getAccessToken();
    return await isTokenValid(token);
  }

  /// Get token expiration date
  Future<DateTime?> getTokenExpiration(String? token) async {
    if (token == null || token.isEmpty) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to get token expiration', e, stackTrace);
      return null;
    }
  }

  /// Check if token needs refresh (expires within 5 minutes)
  Future<bool> shouldRefreshToken() async {
    final token = await getAccessToken();
    if (token == null) return false;

    final expiration = await getTokenExpiration(token);
    if (expiration == null) return false;

    final now = DateTime.now();
    final timeUntilExpiration = expiration.difference(now);
    
    // Refresh if expires within 5 minutes
    final shouldRefresh = timeUntilExpiration.inMinutes < 5;
    
    logger.debug('[TokenService] Should refresh token: $shouldRefresh (expires in ${timeUntilExpiration.inMinutes} minutes)');
    return shouldRefresh;
  }

  /// Clear all stored tokens
  Future<void> clearTokens() async {
    try {
      logger.debug('[TokenService] Clearing all tokens');
      
      await Future.wait([
        _secureStorage.delete(key: ApiConfig.accessTokenKey),
        _secureStorage.delete(key: ApiConfig.refreshTokenKey),
      ]);
      
      logger.debug('[TokenService] Tokens cleared successfully');
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to clear tokens', e, stackTrace);
      rethrow;
    }
  }

  /// Save user data to secure storage
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      logger.debug('[TokenService] Saving user data');
      
      await _secureStorage.write(
        key: ApiConfig.userDataKey,
        value: jsonEncode(userData),
      );
      
      logger.debug('[TokenService] User data saved successfully');
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to save user data', e, stackTrace);
      rethrow;
    }
  }

  /// Get saved user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final userDataString = await _secureStorage.read(key: ApiConfig.userDataKey);
      if (userDataString == null) {
        logger.debug('[TokenService] No user data found');
        return null;
      }

      final userData = jsonDecode(userDataString) as Map<String, dynamic>;
      logger.debug('[TokenService] Retrieved user data successfully');
      return userData;
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to get user data', e, stackTrace);
      return null;
    }
  }

  /// Clear user data
  Future<void> clearUserData() async {
    try {
      logger.debug('[TokenService] Clearing user data');
      await _secureStorage.delete(key: ApiConfig.userDataKey);
      logger.debug('[TokenService] User data cleared successfully');
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to clear user data', e, stackTrace);
      rethrow;
    }
  }

  /// Clear all stored data (tokens + user data)
  Future<void> clearAll() async {
    await Future.wait([
      clearTokens(),
      clearUserData(),
    ]);
    logger.info('[TokenService] All stored data cleared');
  }

  /// Get user ID from access token
  Future<String?> getUserIdFromToken() async {
    final token = await getAccessToken();
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;

      // Common JWT fields for user ID
      return payloadMap['sub'] as String? ?? 
             payloadMap['userId'] as String? ?? 
             payloadMap['user_id'] as String?;
    } catch (e, stackTrace) {
      logger.error('[TokenService] Failed to get user ID from token', e, stackTrace);
      return null;
    }
  }
}
