import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/api_service.dart';
import '../../services/token_service.dart';
import '../../repositories/auth_repository.dart';
import '../utils/logger.dart';

/// Service locator for dependency injection
/// 
/// This centralizes all dependency registration and management using GetIt.
/// Benefits:
/// - Loose coupling between components
/// - Easy testing with mock implementations
/// - Single responsibility for dependency management
/// - Lazy initialization for better performance

final getIt = GetIt.instance;

/// Setup all application dependencies
/// 
/// This should be called once during app initialization in main.dart
/// before runApp() is called.
Future<void> setupServiceLocator() async {
  logger.info('[ServiceLocator] Initializing dependencies...');

  // Core Services (Singletons)
  await _registerCoreServices();
  
  // Repositories (Lazy Singletons)
  await _registerRepositories();
  
  // Providers/Notifiers will be registered by Riverpod
  
  logger.info('[ServiceLocator] Dependencies initialized successfully');
}

/// Register core services that should be singletons
Future<void> _registerCoreServices() async {
  logger.debug('[ServiceLocator] Registering core services...');

  // Logger (already initialized)
  getIt.registerSingleton<AppLogger>(logger);

  // Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  );

  // Token Service
  getIt.registerLazySingleton<TokenService>(
    () => TokenService(getIt<FlutterSecureStorage>()),
  );

  // API Service
  getIt.registerLazySingleton<ApiService>(() {
    final apiService = ApiService(getIt<TokenService>());
    apiService.initialize();
    return apiService;
  });

  logger.debug('[ServiceLocator] Core services registered');
}

/// Register repositories
Future<void> _registerRepositories() async {
  logger.debug('[ServiceLocator] Registering repositories...');

  // Auth Repository (will switch between mock and real based on config)
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<ApiService>()),
  );

  logger.debug('[ServiceLocator] Repositories registered');
}

/// Reset all dependencies (useful for testing)
Future<void> resetServiceLocator() async {
  logger.debug('[ServiceLocator] Resetting dependencies...');
  await getIt.reset();
  logger.debug('[ServiceLocator] Dependencies reset');
}

/// Check if service locator is ready
bool get isServiceLocatorReady => getIt.isRegistered<ApiService>();

/// Extension for easy access to dependencies
extension GetItExtension on GetIt {
  /// Get ApiService instance
  ApiService get apiService => get<ApiService>();
  
  /// Get TokenService instance
  TokenService get tokenService => get<TokenService>();
  
  /// Get AuthRepository instance
  AuthRepository get authRepository => get<AuthRepository>();
  
  /// Get SecureStorage instance
  FlutterSecureStorage get secureStorage => get<FlutterSecureStorage>();
  
  /// Get Logger instance
  AppLogger get logger => get<AppLogger>();
}

/// Dependency injection helper for testing
/// 
/// Allows overriding dependencies with mocks during testing
class DITestHelper {
  static final Map<Type, dynamic> _testOverrides = {};
  
  /// Override a dependency with a mock for testing
  static void override<T extends Object>(T mockInstance) {
    _testOverrides[T] = mockInstance;
  }
  
  /// Clear all test overrides
  static void clearOverrides() {
    _testOverrides.clear();
  }
  
  /// Get dependency with test override support
  static T get<T extends Object>() {
    if (_testOverrides.containsKey(T)) {
      return _testOverrides[T] as T;
    }
    return getIt.get<T>();
  }
}

/// Environment-specific service registration
class EnvironmentDI {
  /// Register development-specific services
  static void registerDevelopmentServices() {
    logger.debug('[ServiceLocator] Registering development services...');
    // Add development-specific services here
  }
  
  /// Register production-specific services
  static void registerProductionServices() {
    logger.debug('[ServiceLocator] Registering production services...');
    // Add production-specific services here (analytics, crash reporting, etc.)
  }
  
  /// Register test-specific services
  static void registerTestServices() {
    logger.debug('[ServiceLocator] Registering test services...');
    // Override with mock implementations for testing
  }
}
