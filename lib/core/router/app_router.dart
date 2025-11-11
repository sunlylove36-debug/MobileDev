import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/loan/presentation/pages/loan_application_page.dart';
import '../../features/loan/presentation/pages/loan_details_page.dart';
import '../../features/document/presentation/pages/document_upload_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../config/app_config.dart';

// Route names
class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String loanApplication = '/loan-application';
  static const String loanDetails = '/loan-details';
  static const String documentUpload = '/document-upload';
  static const String profile = '/profile';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: Routes.loanApplication,
        name: 'loanApplication',
        builder: (context, state) => const LoanApplicationPage(),
      ),
      GoRoute(
        path: '${Routes.loanDetails}/:loanId',
        name: 'loanDetails',
        builder: (context, state) {
          final loanId = state.pathParameters['loanId']!;
          return LoanDetailsPage(loanId: loanId);
        },
      ),
      GoRoute(
        path: Routes.documentUpload,
        name: 'documentUpload',
        builder: (context, state) {
          final loanId = state.extra as String?;
          return DocumentUploadPage(loanId: loanId);
        },
      ),
      GoRoute(
        path: Routes.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    redirect: (context, state) {
      final isOnboardingCompleted = AppConfig.isOnboardingCompleted;
      final hasToken = AppConfig.userToken != null;
      final currentPath = state.fullPath;
      
      // If on splash page, determine where to redirect
      if (currentPath == Routes.splash) {
        if (!isOnboardingCompleted) {
          return Routes.onboarding;
        } else if (!hasToken) {
          return Routes.login;
        } else {
          return Routes.dashboard;
        }
      }
      
      // If not authenticated and trying to access protected routes
      if (!hasToken && _isProtectedRoute(currentPath)) {
        return Routes.login;
      }
      
      // If authenticated and trying to access auth pages
      if (hasToken && _isAuthRoute(currentPath)) {
        return Routes.dashboard;
      }
      
      return null; // No redirect needed
    },
  );
});

bool _isProtectedRoute(String? path) {
  if (path == null) return false;
  
  const protectedRoutes = [
    Routes.dashboard,
    Routes.loanApplication,
    Routes.loanDetails,
    Routes.documentUpload,
    Routes.profile,
  ];
  
  return protectedRoutes.any((route) => path.startsWith(route));
}

bool _isAuthRoute(String? path) {
  if (path == null) return false;
  
  const authRoutes = [
    Routes.login,
    Routes.register,
    Routes.onboarding,
  ];
  
  return authRoutes.contains(path);
}