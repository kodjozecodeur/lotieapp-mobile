import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/config/flavor_config.dart';
import 'core/config/app_config.dart';
import 'core/di/service_locator.dart';
import 'core/utils/logger.dart';

/// Staging Environment Entry Point
/// 
/// This is the main entry point for the Lotie app in staging environment.
/// It initializes the app with staging-specific configuration including:
/// - Staging API endpoints
/// - Enhanced logging for debugging
/// - Staging-specific app identifiers
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set staging flavor
  FlavorConfig.instance.setFlavor(Flavor.staging);

  // Initialize logger with staging configuration
  logger.initialize();
  logger.info('[MainStaging] Starting Lotie App in STAGING environment...');

  try {
    // Print configuration for debugging
    AppConfig.printConfig();

    // Setup dependency injection
    await setupServiceLocator();
    logger.info('[MainStaging] Service locator initialized successfully');

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
    logger.info('[MainStaging] Staging app started successfully');
  } catch (error, stackTrace) {
    logger.fatal('[MainStaging] Failed to start staging app', error, stackTrace);
    
    // Run a fallback app in case of initialization failure
    runApp(
      MaterialApp(
        title: 'LotieApp (Staging) - Error',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Failed to start staging app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Environment: STAGING',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
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
