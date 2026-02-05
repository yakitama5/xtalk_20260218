# Project Structure

## Root Directory
```
yoropic/
├── .dart_tool/          # Dart tooling cache and generated files
├── .git/                # Git version control
├── .kiro/               # Kiro AI assistant configuration
│   └── steering/        # AI guidance documents
├── android/             # Android platform-specific code
├── ios/                 # iOS platform-specific code
├── lib/                 # Main Dart source code
├── linux/               # Linux platform-specific code
├── macos/               # macOS platform-specific code
├── test/                # Test files
├── web/                 # Web platform-specific files
├── windows/             # Windows platform-specific code
├── pubspec.yaml         # Project configuration and dependencies
└── README.md            # Project documentation
```

## Key Directories

### `/lib/` - Main Source Code
- `main.dart`: Application entry point
- This is where all Dart application code should be placed
- Follow standard Flutter project organization:
  - `/lib/screens/` - UI screens/pages
  - `/lib/widgets/` - Reusable UI components
  - `/lib/models/` - Data models
  - `/lib/services/` - Business logic and API services
  - `/lib/utils/` - Utility functions and helpers

### `/test/` - Testing
- `widget_test.dart`: Default widget tests
- Mirror the `/lib/` structure for test organization
- Use `_test.dart` suffix for test files

### Platform Directories
Each platform directory contains platform-specific configuration:
- **android/**: Gradle build files, Android manifest, native Android code
- **ios/**: Xcode project, iOS configuration, native iOS code  
- **web/**: HTML template, web manifest, favicon
- **windows/linux/macos/**: CMake files and native desktop code

## Configuration Files
- `pubspec.yaml`: Dependencies, assets, and project metadata
- `analysis_options.yaml`: Dart analyzer and linting configuration
- `.gitignore`: Git ignore patterns
- `.metadata`: Flutter project metadata

## Development Conventions
- Keep platform-specific code in respective platform directories
- All shared Dart code goes in `/lib/`
- Tests should mirror the source code structure
- Use descriptive file and directory names
- Follow Dart naming conventions (snake_case for files, camelCase for variables)