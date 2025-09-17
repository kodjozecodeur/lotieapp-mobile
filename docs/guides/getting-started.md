# 🚀 Getting Started

This guide will help you set up and run the Lotie App Flutter project on your development machine.

## 📋 Prerequisites

### Required Software
- **Flutter SDK** (3.9.0 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control

### Platform-Specific Requirements

#### For Android Development
- **Android Studio** with Android SDK
- **Android SDK Platform 33** or higher
- **Android SDK Build-Tools** 33.0.0 or higher

#### For iOS Development (macOS only)
- **Xcode** 14.0 or higher
- **CocoaPods** for iOS dependencies
- **iOS Simulator** or physical iOS device

## 🛠️ Installation Steps

### 1. Clone the Repository
```bash
git clone <repository-url>
cd lotieapp
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Verify Flutter Installation
```bash
flutter doctor
```

### 4. Platform Setup

#### Android Setup
1. Open Android Studio
2. Install Android SDK Platform 33+
3. Create an Android Virtual Device (AVD)
4. Verify with: `flutter doctor`

#### iOS Setup (macOS only)
1. Install Xcode from App Store
2. Install CocoaPods: `sudo gem install cocoapods`
3. Install iOS dependencies: `cd ios && pod install`
4. Verify with: `flutter doctor`

## 🏃‍♂️ Running the App

### Development Mode
```bash
# Run on connected device/emulator
flutter run

# Run with hot reload enabled
flutter run --hot

# Run on specific device
flutter run -d <device-id>
```

### Release Mode
```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## 📱 Testing on Different Platforms

### Android
1. Start Android emulator or connect Android device
2. Enable USB debugging on physical device
3. Run: `flutter run`

### iOS (macOS only)
1. Start iOS Simulator or connect iOS device
2. Run: `flutter run`
3. For physical device: Trust developer certificate

### Web
```bash
# Enable web support
flutter config --enable-web

# Run on web
flutter run -d chrome
```

### Desktop
```bash
# Enable desktop support
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop

# Run on desktop
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

## 🔧 Development Tools

### Recommended IDE Setup

#### VS Code
1. Install Flutter extension
2. Install Dart extension
3. Install Flutter Intl extension (for internationalization)
4. Configure settings for Flutter development

#### Android Studio
1. Install Flutter plugin
2. Install Dart plugin
3. Configure Flutter SDK path
4. Set up device emulators

### Useful Commands
```bash
# Check Flutter installation
flutter doctor -v

# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Analyze code
flutter analyze

# Run tests
flutter test

# Format code
dart format .
```

## 📁 Project Structure Overview

```
lotieapp/
├── lib/                      # Main source code
│   ├── main.dart            # App entry point
│   ├── app.dart             # App configuration
│   ├── core/                # Core functionality
│   ├── models/              # Data models
│   ├── services/            # External services
│   ├── providers/           # State management
│   ├── screens/             # UI screens
│   └── routes/              # Navigation
├── assets/                  # Static assets
├── test/                    # Tests
├── docs/                    # Documentation
└── pubspec.yaml            # Dependencies
```

## 🎨 Design System Setup

### Design Tokens
The app uses a comprehensive design token system located in:
- `lib/core/constants/design_tokens.dart`

### Figma Integration
Follow the [Figma Integration Guide](./figma-integration.md) to:
1. Export assets from Figma
2. Update design tokens
3. Create custom components

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Test Structure
```
test/
├── widget_test.dart          # Widget tests
├── unit/                     # Unit tests
└── integration/              # Integration tests
```

## 🐛 Troubleshooting

### Common Issues

#### Flutter Doctor Issues
```bash
# Fix Android license issues
flutter doctor --android-licenses

# Update Flutter
flutter upgrade
```

#### Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### iOS Build Issues
```bash
# Clean iOS build
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter run
```

#### Android Build Issues
```bash
# Clean Android build
cd android
./gradlew clean
cd ..
flutter run
```

### Getting Help
1. Check [Flutter Documentation](https://flutter.dev/docs)
2. Search [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. Join [Flutter Community](https://flutter.dev/community)
4. Check project documentation in `docs/` folder

## 📚 Next Steps

1. **Read the Architecture**: Check [Clean Architecture Overview](../architecture/clean-architecture.md)
2. **Explore Components**: Browse [Component Library](../components/component-library.md)
3. **Integrate Design**: Follow [Figma Integration Guide](./figma-integration.md)
4. **Start Development**: Begin implementing your features

## 🔗 Related Documentation

- [Clean Architecture Overview](../architecture/clean-architecture.md)
- [Project Structure](../architecture/project-structure.md)
- [Figma Integration Guide](./figma-integration.md)
- [Component Library](../components/component-library.md)
- [Development Workflow](./development-workflow.md)

---

*Happy coding! 🎉*
