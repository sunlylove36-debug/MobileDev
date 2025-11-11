import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static const String appName = 'LuyLeun Clone';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.luyleun.com/v1';
  static const String apiTimeout = '30000';
  
  // App Configuration
  static const String defaultCurrency = 'USD';
  static const double maxLoanAmount = 1000.0;
  static const double minLoanAmount = 50.0;
  static const int minRepaymentDays = 90;
  static const int maxRepaymentDays = 365;
  static const double minInterestRate = 0.12;
  static const double maxInterestRate = 0.18;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String onboardingKey = 'onboarding_completed';
  static const String biometricEnabledKey = 'biometric_enabled';
  
  static late SharedPreferences _preferences;
  
  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }
  
  static SharedPreferences get preferences => _preferences;
  
  // Helper methods for common operations
  static bool get isOnboardingCompleted => 
      _preferences.getBool(onboardingKey) ?? false;
      
  static Future<void> setOnboardingCompleted(bool completed) async {
    await _preferences.setBool(onboardingKey, completed);
  }
  
  static String? get userToken => _preferences.getString(userTokenKey);
  
  static Future<void> setUserToken(String token) async {
    await _preferences.setString(userTokenKey, token);
  }
  
  static Future<void> clearUserData() async {
    await _preferences.remove(userTokenKey);
    await _preferences.remove(userDataKey);
  }
}