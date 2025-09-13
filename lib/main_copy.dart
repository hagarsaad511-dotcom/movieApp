// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/data/services/api_manager.dart';
// import 'package:movie_app/routing/app_routes.dart';
// import 'package:movie_app/ui/core/themes/app_themes.dart';
// import 'package:movie_app/ui/features/browse/ui/browse_screen.dart';
// import 'package:movie_app/ui/features/home/ui/home_screen.dart';
// import 'package:movie_app/ui/features/intro/onboarding_screen/onboarding_screen.dart';
//
// import 'package:movie_app/ui/features/main_screen/ui/main_screen.dart';
// import 'package:movie_app/ui/features/movies_details/ui/movie_details.dart';
// import 'package:movie_app/ui/features/profile/ui/profile_screen.dart';
// import 'package:movie_app/ui/features/search/ui/search_screen.dart';
// import 'package:movie_app/utils/my_block_observer.dart';
//
// void main() {
//   Bloc.observer = MyBlocObserver();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.onboardingScreenRoute,
//       routes: {
//         AppRoutes.onboardingScreenRoute: (context) => OnboardingScreen(),
//         AppRoutes.mainScreenRoute : (context) => MainScreen(),
//         AppRoutes.homeScreenRoute : (context) => HomeScreen(),
//         AppRoutes.searchScreenRoute : (context) => SearchScreen(),
//         AppRoutes.browseScreenRoute : (context) => BrowseScreen(),
//         AppRoutes.profileScreenRoute : (context) => ProfileScreen(),
//         AppRoutes.movieDetailsScreenRoute: (context) => MovieDetailsScreen(),
//       },
//       theme: AppTheme.appTheme,
//     );
//   }
// }
