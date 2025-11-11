# Flutter Run Commands

## After Flutter SDK Installation

### Run on Web Browser (No device needed)

```bash
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080
```

### Run on Chrome

```bash
flutter run -d chrome
```

### Run on Android Emulator

```bash
flutter run -d android
```

### Run with Hot Reload (Development)

```bash
flutter run --debug
```

### Run in Release Mode

```bash
flutter run --release
```

## VS Code Integration

### Using VS Code Tasks:

- Press `Ctrl+Shift+P`
- Type "Tasks: Run Task"
- Select "Flutter: Run Debug"

### Using Debug Mode:

- Press `F5` or go to Run & Debug panel
- Select "Flutter Debug" configuration
- Click the play button

## Web Server Access

When running on web-server mode, the app will be available at:

- Local: http://localhost:8080
- Network: http://YOUR_IP_ADDRESS:8080

## Troubleshooting

### If Flutter is not recognized:

1. Install Flutter SDK from https://flutter.dev
2. Add Flutter to your PATH
3. Run `flutter doctor` to verify installation
4. Run `flutter pub get` to install dependencies

### Common Issues:

- **No connected devices**: Use web browser or install Android Studio
- **Dependencies not found**: Run `flutter pub get`
- **Build errors**: Run `flutter clean` then `flutter pub get`
