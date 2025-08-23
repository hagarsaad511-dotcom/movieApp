import 'package:flutter/material.dart';
import 'package:movie_app/routing/app_routes.dart';
import 'package:movie_app/ui/core/themes/app_themes.dart';
import 'package:movie_app/ui/features/browse/ui/browse_screen.dart';
import 'package:movie_app/ui/features/home/ui/home_screen.dart';

import 'package:movie_app/ui/features/main_screen/ui/main_screen.dart';
import 'package:movie_app/ui/features/profile/ui/profile_screen.dart';
import 'package:movie_app/ui/features/search/ui/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.mainScreenRoute,
      routes: {
        AppRoutes.mainScreenRoute : (context) => MainScreen(),
        AppRoutes.homeScreenRoute : (context) => HomeScreen(),
        AppRoutes.searchScreenRoute : (context) => SearchScreen(),
        AppRoutes.browseScreenRoute : (context) => BrowseScreen(),
        AppRoutes.profileScreenRoute : (context) => ProfileScreen(),
      },
      theme: AppTheme.appTheme,
    );
  }
}
