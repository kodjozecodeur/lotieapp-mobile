# 📁 Project Structure

This document details the complete project structure and organization of the Lotie App Flutter project.

## 🏗️ Root Directory Structure

```
lotieapp/
├── android/                  # Android platform files
├── ios/                      # iOS platform files
├── lib/                      # Main Dart source code
├── test/                     # Unit and widget tests
├── docs/                     # Project documentation
├── assets/                   # Static assets (images, fonts, etc.)
├── pubspec.yaml              # Dependencies and metadata
├── analysis_options.yaml     # Linting rules
└── README.md                 # Project overview
```

## 📱 Flutter Platform Directories

### Android (`android/`)
- **Gradle files**: Build configuration
- **Manifest files**: App permissions and configuration
- **Kotlin/Java files**: Platform-specific code
- **Resources**: Android-specific assets

### iOS (`ios/`)
- **Xcode project files**: iOS build configuration
- **Swift/Objective-C files**: Platform-specific code
- **Info.plist**: iOS app configuration
- **Assets**: iOS-specific assets

## 🎯 Main Source Code (`lib/`)

### Core Application Files
```
lib/
├── main.dart                 # Application entry point
└── app.dart                  # App configuration and theme
```

### Core Module (`core/`)
```
core/
├── constants/                # Application constants
│   ├── app_constants.dart    # General app constants
│   ├── app_colors.dart       # Color palette
│   ├── app_strings.dart      # String constants
│   └── design_tokens.dart    # Design system tokens
├── utils/                    # Utility functions
│   ├── validators.dart       # Input validation
│   └── helpers.dart          # Helper functions
└── widgets/                  # Reusable UI components
    ├── custom_button.dart    # Custom button component
    ├── custom_text_field.dart # Custom input component
    └── figma_components/     # Figma-based components
        ├── figma_button.dart
        ├── figma_card.dart
        └── figma_input.dart
```

### Data Layer (`models/`, `services/`)
```
models/
└── user_model.dart           # User data model

services/
└── api_service.dart          # API communication service
```

### Business Logic (`providers/`)
```
providers/
└── auth_provider.dart        # Authentication state management
```

### Presentation Layer (`screens/`, `routes/`)
```
screens/
└── home_screen.dart          # Main home screen

routes/
└── app_routes.dart           # Navigation configuration
```

## 📦 Dependencies (`pubspec.yaml`)

### Core Flutter
- `flutter`: Flutter SDK
- `cupertino_icons`: iOS-style icons

### State Management
- `provider`: State management solution

### Networking & Data
- `dio`: HTTP client for API calls
- `shared_preferences`: Local storage
- `flutter_secure_storage`: Secure storage
- `cached_network_image`: Image caching

### UI & Design
- `flutter_svg`: SVG support
- `flutter_screenutil`: Responsive design
- `google_fonts`: Font integration
- `lottie`: Animation support
- `shimmer`: Loading effects
- `flutter_animate`: Advanced animations

### Utilities
- `intl`: Internationalization
- `uuid`: Unique ID generation
- `pull_to_refresh`: Pull-to-refresh functionality

## 🧪 Testing Structure (`test/`)

```
test/
├── widget_test.dart          # Widget tests
├── unit/                     # Unit tests
│   ├── models/
│   ├── services/
│   └── providers/
├── integration/              # Integration tests
└── mocks/                    # Test mocks and stubs
```

## 📚 Documentation (`docs/`)

```
docs/
├── README.md                 # Documentation index
├── architecture/             # Architecture documentation
│   ├── clean-architecture.md
│   ├── project-structure.md
│   ├── design-patterns.md
│   └── state-management.md
├── components/               # Component documentation
│   ├── design-tokens.md
│   ├── component-library.md
│   ├── core-components.md
│   └── figma-components.md
├── guides/                   # Implementation guides
│   ├── getting-started.md
│   ├── figma-integration.md
│   ├── development-workflow.md
│   └── ui-guidelines.md
└── api/                      # API documentation
    ├── api-reference.md
    └── database-schema.md
```

## 🎨 Assets Structure (`assets/`)

```
assets/
├── images/                   # Image assets
│   ├── backgrounds/          # Background images
│   ├── illustrations/        # Illustration images
│   └── photos/               # Photo assets
├── icons/                    # Icon assets
│   ├── navigation/           # Navigation icons
│   ├── actions/              # Action icons
│   └── status/               # Status icons
├── animations/               # Animation assets
│   ├── loading/              # Loading animations
│   ├── success/              # Success animations
│   └── transitions/          # Transition animations
└── fonts/                    # Custom fonts
    ├── custom-font-regular.ttf
    ├── custom-font-bold.ttf
    └── custom-font-light.ttf
```

## 🔧 Configuration Files

### `analysis_options.yaml`
- Linting rules and code analysis configuration
- Custom rules for the project
- Exclusions and overrides

### `pubspec.yaml`
- Project metadata and version
- Dependencies and dev dependencies
- Asset declarations
- Font configurations

## 📱 Platform-Specific Files

### Android Configuration
- `android/app/build.gradle.kts`: Android build configuration
- `android/app/src/main/AndroidManifest.xml`: Android permissions
- `android/gradle.properties`: Gradle properties

### iOS Configuration
- `ios/Runner.xcodeproj/`: Xcode project file
- `ios/Runner/Info.plist`: iOS app configuration
- `ios/Podfile`: CocoaPods dependencies

## 🎯 File Naming Conventions

### Dart Files
- **snake_case**: `user_model.dart`, `api_service.dart`
- **Descriptive names**: Clear and meaningful
- **Consistent patterns**: Follow established conventions

### Asset Files
- **snake_case**: `ic_home_filled.svg`
- **Descriptive prefixes**: `ic_` for icons, `img_` for images
- **Category folders**: Group related assets

### Directory Names
- **snake_case**: `figma_components/`
- **Descriptive**: Clear purpose and content
- **Consistent**: Follow established patterns

## 🔍 Navigation Guidelines

### Finding Files
1. **UI Components**: Check `core/widgets/` or `screens/`
2. **Business Logic**: Look in `providers/` or `services/`
3. **Data Models**: Check `models/`
4. **Constants**: Look in `core/constants/`
5. **Utilities**: Check `core/utils/`

### Adding New Features
1. **Models**: Add to `models/` directory
2. **Services**: Add to `services/` directory
3. **Providers**: Add to `providers/` directory
4. **Screens**: Add to `screens/` directory
5. **Components**: Add to `core/widgets/` directory

## 📚 Related Documentation

- [Clean Architecture Overview](./clean-architecture.md)
- [Design Patterns](./design-patterns.md)
- [State Management](./state-management.md)
- [Component Library](../components/component-library.md)

---

*This structure ensures the project is organized, maintainable, and follows Flutter best practices.*
