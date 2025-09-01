import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/screens/forget_password_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/gen/app_localizations.dart';

import 'ui/core/di/injection_container.dart' as di;
import 'ui/core/themes/app_colors.dart';

import 'presentation/screens/language_provider.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/cubits/auth/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // ✅ Dependency Injection
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()), // ✅ language
        BlocProvider(create: (_) => di.sl<AuthCubit>()),           // ✅ auth cubit
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
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, child) {
        final GoRouter router = GoRouter(
          initialLocation: '/login',
          routes: [
            GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
            GoRoute(path: '/home', builder: (_, __) => const Placeholder()),
            GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
            GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
          ],
        );

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
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}