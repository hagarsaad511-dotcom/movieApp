import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/cubits/auth/auth_cubit.dart';
import '../../../presentation/cubits/auth/auth_state.dart';

import '../../../presentation/screens/splash_screen.dart';
import '../../../presentation/screens/login_screen.dart';
import '../../../presentation/screens/register_screen.dart';
import '../../../presentation/screens/reset_password_screen.dart';
import '../../../presentation/screens/profile_screen.dart';
import '../../../presentation/screens/update_profile_screen.dart';
import '../presentation/screens/forget_password_screen.dart';
import '../ui/features/intro/onboarding_screen/onboarding_screen.dart';
import '../ui/features/main_screen/ui/main_screen.dart';
class AppRouters {
  static GoRouter create(BuildContext context, bool hasSeenOnboarding) {
    return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(
        context.read<AuthCubit>().stream,
      ),
      redirect: (context, state) {
        final authState = context.read<AuthCubit>().state;
        final location = state.matchedLocation;

        // ✅ Stay on splash while it decides
        if (location == '/splash') return null;

        // ✅ Prevent onboarding after first time
        if (hasSeenOnboarding && location == '/onboarding') {
          return '/login';
        }

        final isAuth = authState is AuthAuthenticated;
        final loggingIn = location.startsWith('/login') ||
            location.startsWith('/register') ||
            location.startsWith('/forgot-password') ||
            location.startsWith('/reset-password');

        // ✅ If not authenticated and tries to go somewhere protected → go login
        if (!isAuth && !loggingIn) return '/login';

        // ✅ If authenticated but still at login/register → go home
        if (isAuth && loggingIn) return '/home';

        return null;
      },
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
        GoRoute(path: '/reset-password', builder: (_, __) => const ResetPasswordScreen()),
        GoRoute(path: '/home', builder: (_, __) => const MainScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/profile/update', builder: (_, __) => const UpdateProfileScreen()),
      ],
    );
  }
}


/// ✅ Helper so GoRouter reacts to Bloc state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
