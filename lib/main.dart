import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/presentation/cubits/history_cubit.dart';
import 'package:movie_app/presentation/cubits/watch_list_cubit.dart';
import 'package:movie_app/routing/app_routes.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'l10n/gen/app_localizations.dart';
import 'ui/core/di/injection_container.dart' as di;
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/auth/auth_state.dart';
import 'presentation/screens/language_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  // ✅ preload prefs
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool("seen_onboarding") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..getCurrentUser(),
        ),
        BlocProvider<WatchlistCubit>(
          create: (_) => WatchlistCubit()..loadWatchlist(),
        ),
        BlocProvider<HistoryCubit>(
          create: (_) => HistoryCubit()..loadHistory(),
        ),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );

}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final router = AppRouters.create(context);

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
                  localizationsDelegates:
                  AppLocalizations.localizationsDelegates,
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
      },
    );
  }
}