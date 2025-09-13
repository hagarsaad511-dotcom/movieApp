import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/routing/app_routes.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'l10n/gen/app_localizations.dart';
import 'ui/core/di/injection_container.dart' as di;
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/screens/language_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..getCurrentUser(),
        ),
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
    _router = AppRouters.create(context); // ✅ pass AuthCubit context
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
