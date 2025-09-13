import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/routing/app_routes.dart';
import 'package:movie_app/ui/core/di/injection_container.dart';
import 'package:movie_app/ui/features/browse/ui/browse_screen.dart';
import 'package:movie_app/ui/features/home/ui/home_screen.dart';
import 'package:movie_app/ui/features/intro/onboarding_screen/onboarding_screen.dart';
import 'package:movie_app/ui/features/main_screen/ui/main_screen.dart';
import 'package:movie_app/ui/features/movies_details/ui/movie_details.dart';
import 'package:movie_app/ui/features/profile/ui/profile_screen.dart';
import 'package:movie_app/ui/features/search/ui/search_screen.dart';
import 'package:movie_app/utils/my_block_observer.dart';
import 'ui/core/themes/app_colors.dart';
import 'presentation/cubits/auth/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // initialize dependency injection
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // setup routing


    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X base
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) => sl<AuthCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.onboardingScreenRoute,
            routes: {
              AppRoutes.onboardingScreenRoute: (context) => OnboardingScreen(),
              AppRoutes.mainScreenRoute : (context) => MainScreen(),
              AppRoutes.homeScreenRoute : (context) => HomeScreen(),
              AppRoutes.searchScreenRoute : (context) => SearchScreen(),
              AppRoutes.browseScreenRoute : (context) => BrowseScreen(),
              AppRoutes.profileScreenRoute : (context) => ProfileScreen(),
              AppRoutes.movieDetailsScreenRoute: (context) => MovieDetailsScreen(),
            },
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.primaryBlack,
              primaryColor: AppColors.yellow,
              colorScheme: ColorScheme.dark(
                primary: AppColors.yellow,
                secondary: AppColors.lightGrey,
                background: AppColors.primaryBlack,
              ),
            ),

          ),
        );
      },
    );
  }
}
