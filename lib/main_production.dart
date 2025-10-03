import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/config/flavor_config.dart';
import 'core/config/app_config.dart';
import 'core/di/service_locator.dart';
import 'core/utils/logger.dart';

/// Production Environment Entry Point
/// 
/// This is the main entry point for the Lotie app in production environment.
/// It initializes the app with production-specific configuration including:
/// - Production API endpoints
/// - Optimized logging for performance
/// - Production app identifiers for app store
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set production flavor
  FlavorConfig.instance.setFlavor(Flavor.production);

  // Initialize logger with production configuration
  logger.initialize();
  logger.info('[MainProduction] Starting Lotie App in PRODUCTION environment...');

  try {
    // Print configuration for debugging (minimal in production)
    if (AppConfig.isDebugMode) {
      AppConfig.printConfig();
    }

    // Setup dependency injection
    await setupServiceLocator();
    logger.info('[MainProduction] Service locator initialized successfully');

    // Set preferred orientations (optional)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Run the app with Riverpod
    runApp(
      ProviderScope(
        child: const App(),
      ),
    );
    logger.info('[MainProduction] Production app started successfully');
  } catch (error, stackTrace) {
    logger.fatal('[MainProduction] Failed to start production app', error, stackTrace);
    
    // Run a fallback app in case of initialization failure
    runApp(
      MaterialApp(
        title: 'LotieApp - Error',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Failed to start app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please restart the app or contact support',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Environment: PRODUCTION',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
