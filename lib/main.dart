import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/screens/profile_screen.dart';
import 'package:movie_app/presentation/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ui/core/di/injection_container.dart' as di;
import 'ui/core/themes/app_colors.dart';
import 'l10n/gen/app_localizations.dart';

import 'presentation/screens/language_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
//import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/forget_password_screen.dart';
import 'presentation/cubits/auth/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();


    _router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        //GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
        GoRoute(path: '/home', builder: (_, __) => const Placeholder()), // replace with HomeScreen
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/profile/update', builder: (_, __) => const UpdateProfileScreen()),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.primaryBlack,
                primaryColor: AppColors.yellow,
                fontFamily: 'Roboto',
              ),
              locale: Locale(langProvider.currentLangCode),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              builder: (context, child) {
                return Directionality(
                  textDirection: langProvider.direction,
                  child: child!,
                );
              },
              routerConfig: _router,
            );
          },
        );
      },
    );
  }
}
