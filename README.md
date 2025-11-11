# Flutter Financial Lending App - LuyLeun Clone

A modern Flutter mobile application that replicates the functionality of the LuyLeun financial lending platform. This app provides users with a seamless experience for applying for loans, uploading documents, and managing their financial accounts.

## 🌟 Features

### Core Functionality

- **Quick Loan Application**: Apply for loans in minutes (10-minute process)
- **Document Upload**: Secure upload of National ID, Job verification, and Selfie
- **Credit Building**: Start with small amounts and build credit up to $1,000
- **Flexible Repayment**: Choose repayment periods from 90-365 days
- **Competitive Rates**: Interest rates from 12-18% APR
- **Daily Interest Calculation**: Fair and transparent interest calculation

### App Features

- **User Authentication**: Secure login/register with biometric support
- **Interactive Dashboard**: Real-time loan status and credit information
- **Document Management**: Organized document storage and verification
- **Payment Tracking**: Monitor repayment schedules and history
- **Responsive Design**: Works perfectly on all screen sizes
- **Offline Support**: Core features work without internet

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS development setup (for iOS builds)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd MobileDev
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

#### VS Code Extensions (Recommended)

- Flutter
- Dart
- Flutter Intl (for internationalization)
- Pubspec Assist (for dependency management)

#### Environment Configuration

1. Create a `.env` file in the root directory
2. Add your API configurations:
   ```
   API_BASE_URL=https://api.luyleun.com/v1
   API_TIMEOUT=30000
   ```

## 📱 App Structure

### Clean Architecture

```
lib/
├── core/                 # Core functionality
│   ├── app/             # App configuration
│   ├── config/          # App settings and constants
│   ├── router/          # Navigation and routing
│   └── theme/           # App theme and styling
├── features/            # Feature modules
│   ├── auth/            # Authentication
│   ├── dashboard/       # Home dashboard
│   ├── loan/            # Loan management
│   ├── document/        # Document upload
│   ├── profile/         # User profile
│   └── onboarding/      # App introduction
└── shared/              # Shared components
    └── widgets/         # Reusable UI components
```

### Key Dependencies

- **State Management**: Riverpod
- **Navigation**: GoRouter
- **UI Components**: Flutter Material 3
- **Responsive Design**: ScreenUtil
- **HTTP Client**: Dio
- **Local Storage**: SharedPreferences & SQLite
- **Authentication**: Local Auth (Biometrics)
- **Image Handling**: Image Picker

## 🎨 Design System

### Color Palette

- **Primary**: Deep Blue (#1565C0) - Trust and reliability
- **Secondary**: Green (#4CAF50) - Money and growth
- **Success**: Green (#4CAF50)
- **Warning**: Orange (#FF9800)
- **Error**: Red (#E53935)

### Typography

- **Primary Font**: Roboto
- **Font Sizes**: 12sp - 36sp (responsive scaling)
- **Font Weights**: Regular (400), Medium (500), Bold (700)

## 🔐 Security Features

### Data Protection

- End-to-end encryption for sensitive data
- Secure token-based authentication
- Biometric authentication support
- Local data encryption
- SSL/TLS communication

### Privacy Compliance

- GDPR compliant data handling
- User consent management
- Data minimization principles
- Right to deletion implementation

## 📋 Development Guidelines

### Code Style

- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Implement proper error handling
- Write comprehensive unit tests
- Document complex business logic

### Git Workflow

1. Create feature branches from `develop`
2. Use conventional commit messages
3. Submit pull requests for code review
4. Merge only after approval and tests pass

### Testing Strategy

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for user flows
- Performance testing for critical paths

## 🚦 Available Scripts

```bash
# Development
flutter run                    # Run in debug mode
flutter run --release         # Run in release mode

# Building
flutter build apk             # Build Android APK
flutter build ios            # Build iOS app
flutter build web            # Build web version

# Testing
flutter test                  # Run unit tests
flutter test --coverage      # Run tests with coverage

# Code Quality
flutter analyze              # Static code analysis
dart format .                # Format code
```

## 🌍 Localization

The app supports multiple languages:

- English (default)
- Khmer (Cambodian)
- Additional languages can be added easily

## 📄 API Integration

### Base Configuration

- **Base URL**: `https://api.luyleun.com/v1`
- **Timeout**: 30 seconds
- **Authentication**: Bearer Token
- **Response Format**: JSON

### Key Endpoints

- `POST /auth/login` - User authentication
- `POST /auth/register` - User registration
- `POST /loans/apply` - Loan application
- `POST /documents/upload` - Document upload
- `GET /loans/history` - Loan history

## 🔧 Configuration

### Environment Variables

Create a `.env` file with these variables:

```
ENVIRONMENT=development
API_BASE_URL=https://api.luyleun.com/v1
API_KEY=your_api_key_here
SENTRY_DSN=your_sentry_dsn_here
```

### Feature Flags

Configure features in `lib/core/config/app_config.dart`:

- Maximum loan amount
- Interest rate ranges
- Repayment period options
- Feature toggles

## 🐛 Troubleshooting

### Common Issues

1. **Flutter SDK not found**

   ```bash
   flutter doctor
   ```

2. **Dependencies conflict**

   ```bash
   flutter clean
   flutter pub get
   ```

3. **iOS build issues**
   ```bash
   cd ios && pod install
   ```

### Debug Tools

- Flutter Inspector for UI debugging
- Performance overlay for performance issues
- Network profiler for API debugging
- Memory profiler for memory leaks

## 📈 Performance Optimization

### Best Practices Implemented

- Image caching and optimization
- Lazy loading for large lists
- Efficient state management
- Bundle size optimization
- Network request caching

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For support and questions:

- **Email**: info@luyleun.com
- **Phone**: Smart 010269769, Cellcard 078879697
- **Website**: https://www.luyleun.com/

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- LuyLeun original app for inspiration
- Open source community for valuable packages

---

**Built with ❤️ using Flutter**
