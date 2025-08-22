import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_app/ui/core/di/injection_container.dart';
import 'ui/core/themes/app_colors.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/cubits/auth/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // setup routing
    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Placeholder(), // replace with HomeScreen
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const Placeholder(), // replace with ResetPasswordScreen
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(), // replace with RegisterScreen
        ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X base
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) => sl<AuthCubit>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryBlack,
              primaryColor: AppColors.yellow,
              colorScheme: ColorScheme.dark(
                primary: AppColors.yellow,
                secondary: AppColors.lightGrey,
                background: AppColors.primaryBlack,
              ),
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}
