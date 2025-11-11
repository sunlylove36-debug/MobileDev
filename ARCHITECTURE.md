# Project Structure

## Overview

This Flutter project follows clean architecture principles with feature-based organization.

```
lib/
├── core/                           # Core functionality & configuration
│   ├── app/                       # App-level configuration
│   │   └── app.dart              # Main app widget
│   ├── config/                   # App configuration & constants
│   │   └── app_config.dart       # Configuration settings
│   ├── router/                   # Navigation & routing
│   │   └── app_router.dart       # GoRouter configuration
│   └── theme/                    # App theming
│       ├── app_colors.dart       # Color palette
│       └── app_theme.dart        # Theme configuration
│
├── features/                      # Feature modules
│   ├── auth/                     # Authentication feature
│   │   └── presentation/
│   │       └── pages/
│   │           ├── login_page.dart
│   │           └── register_page.dart
│   │
│   ├── dashboard/                # Dashboard feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── dashboard_page.dart
│   │
│   ├── document/                 # Document upload feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── document_upload_page.dart
│   │
│   ├── loan/                     # Loan management feature
│   │   └── presentation/
│   │       └── pages/
│   │           ├── loan_application_page.dart
│   │           └── loan_details_page.dart
│   │
│   ├── onboarding/               # App onboarding
│   │   └── presentation/
│   │       └── pages/
│   │           ├── splash_page.dart
│   │           └── onboarding_page.dart
│   │
│   └── profile/                  # User profile feature
│       └── presentation/
│           └── pages/
│               └── profile_page.dart
│
├── shared/                       # Shared components
│   └── widgets/                 # Reusable UI components
│       ├── custom_button.dart
│       └── custom_text_field.dart
│
└── main.dart                    # App entry point
```

## Architecture Layers

### Presentation Layer

- **Pages**: Full-screen widgets representing app screens
- **Widgets**: Reusable UI components
- **State Management**: Riverpod providers for state management

### Domain Layer (Future Implementation)

- **Entities**: Business objects
- **Use Cases**: Business logic
- **Repositories**: Abstract interfaces for data access

### Data Layer (Future Implementation)

- **Models**: Data transfer objects
- **Data Sources**: API clients, local storage
- **Repositories**: Concrete implementations

## Key Design Patterns

1. **Clean Architecture**: Separation of concerns with clear dependencies
2. **Feature-First**: Organized by business features rather than technical layers
3. **Provider Pattern**: State management using Riverpod
4. **Repository Pattern**: Data access abstraction (to be implemented)
5. **MVVM**: Model-View-ViewModel pattern for UI state management

## Dependencies

### Core

- `flutter`: Flutter framework
- `flutter_riverpod`: State management
- `go_router`: Navigation and routing
- `flutter_screenutil`: Responsive design

### UI/UX

- `cupertino_icons`: iOS-style icons
- `flutter_svg`: SVG rendering
- `cached_network_image`: Efficient image loading
- `shimmer`: Loading placeholders
- `loading_animation_widget`: Loading animations

### Data & Storage

- `shared_preferences`: Local key-value storage
- `sqflite`: Local SQLite database
- `dio`: HTTP client for API calls

### Utilities

- `image_picker`: Camera and gallery access
- `file_picker`: File selection
- `permission_handler`: App permissions
- `local_auth`: Biometric authentication
- `crypto`: Encryption utilities
- `intl`: Internationalization
- `uuid`: Unique identifier generation
- `url_launcher`: External URL handling

### Charts & Visualization

- `fl_chart`: Charts and graphs for financial data

## Development Guidelines

1. **File Naming**: Use snake_case for file names
2. **Class Naming**: Use PascalCase for class names
3. **Variable Naming**: Use camelCase for variables
4. **Constants**: Use SCREAMING_SNAKE_CASE for constants
5. **Private Members**: Prefix with underscore (\_)

## Testing Structure (To Be Implemented)

```
test/
├── unit/                        # Unit tests
├── widget/                      # Widget tests
└── integration/                 # Integration tests
```

## Assets Structure

```
assets/
├── images/                      # App images
├── icons/                       # App icons
└── fonts/                       # Custom fonts
```

This structure promotes maintainability, testability, and scalability for the financial lending application.
