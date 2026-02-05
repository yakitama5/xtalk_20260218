# Technology Stack

## Framework & Language
- **Flutter**: Cross-platform mobile/desktop/web framework
- **Dart**: Programming language (SDK ^3.10.8)
- **Material Design**: UI design system

## Dependencies
- `flutter`: Core Flutter SDK
- `cupertino_icons`: iOS-style icons (^1.0.8)

## Development Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Recommended linting rules (^6.0.0)

## Build System
Flutter uses its own build system with platform-specific configurations:
- **Android**: Gradle build system (Kotlin DSL)
- **iOS**: Xcode project files
- **Web**: Dart compilation to JavaScript
- **Desktop**: CMake for Linux/Windows, Xcode for macOS

## Common Commands

### Development
```bash
# Get dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d macos          # macOS

# Hot reload during development
# Press 'r' in terminal or save files in IDE
```

### Testing & Quality
```bash
# Run tests
flutter test

# Analyze code for issues
flutter analyze

# Format code
flutter format .

# Check for outdated dependencies
flutter pub outdated
```

### Building
```bash
# Build for release
flutter build apk              # Android APK
flutter build appbundle        # Android App Bundle
flutter build ios              # iOS
flutter build web              # Web
flutter build windows          # Windows
flutter build macos            # macOS
flutter build linux            # Linux
```

## Code Style
- Uses `flutter_lints` package for recommended linting rules
- Analysis options configured in `analysis_options.yaml`
- Standard Dart formatting conventions apply