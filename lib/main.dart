import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'core/di/service_locator.dart';
import 'core/utils/logger.dart';

/// Application entry point
/// 
/// This is the main entry point for the Lotie app.
/// It initializes the app with proper dependency injection,
/// logging, and clean architecture structure.
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  logger.initialize();
  logger.info('[Main] Starting Lotie App...');

  try {
    // Setup dependency injection
    await setupServiceLocator();
    logger.info('[Main] Service locator initialized successfully');

    // Set preferred orientations (optional)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Run the app
    runApp(const App());
    logger.info('[Main] App started successfully');
  } catch (error, stackTrace) {
    logger.fatal('[Main] Failed to start app', error, stackTrace);
    
    // Run a fallback app in case of initialization failure
    runApp(
      MaterialApp(
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
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
