import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // splash duration
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    print("hasSeenOnboarding = $hasSeenOnboarding");

    if (hasSeenOnboarding) {
      context.go('/login');
    } else {
      //context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 220.h),

            /// App logo
            Image.asset(
              "assets/images/login.png",
              width: 130.w,
              height: 130.h,
            ),

            SizedBox(height: 220.h),

            Image.asset("assets/images/Mask group.png"),
            SizedBox(height: 8.h),

            Text(
              "Supervised by Mohamed Nabil",
              style: TextStyle(color: AppColors.white, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
