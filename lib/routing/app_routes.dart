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
//import '../../../presentation/screens/forgot_password_screen.dart';
import '../../../presentation/screens/profile_screen.dart';
import '../../../presentation/screens/update_profile_screen.dart';
//import '../../../presentation/screens/home_screen.dart';
// import '../../../presentation/screens/onboarding_screen.dart';

class AppRouters {
  static GoRouter create(BuildContext context) {
    return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true, // helpful in debugging redirects
      refreshListenable: GoRouterRefreshStream(
        context.read<AuthCubit>().stream,
      ),
      redirect: (context, state) {
        final authState = context.read<AuthCubit>().state;

        // While loading or initial, don’t redirect yet
        if (authState is AuthInitial || authState is AuthLoading) {
          return null;
        }

        final isAuth = authState is AuthAuthenticated;
        final loggingIn = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/forgot-password' ||
            state.matchedLocation == '/reset-password';

        // If not authenticated → force login
        if (!isAuth && !loggingIn) return '/login';

        // If authenticated but on login/register screens → go home
        if (isAuth && loggingIn) return '/home';

        // Else, no redirect
        return null;
      },
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        // GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        //GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
        GoRoute(path: '/reset-password', builder: (_, __) => const ResetPasswordScreen()),
        //GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/profile/update', builder: (_, __) => const UpdateProfileScreen()),
      ],
    );
  }
}

/// ✅ Helper to make GoRouter listen to Bloc/Cubit streams
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
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
