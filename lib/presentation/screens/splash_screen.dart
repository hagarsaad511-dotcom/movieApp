import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/cubits/auth/auth_cubit.dart';
import '../../presentation/cubits/auth/auth_state.dart';

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
    final hasSeenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    print("hasSeenOnboarding = $hasSeenOnboarding");

    final authState = context.read<AuthCubit>().state;

    if (!hasSeenOnboarding) {
      // First time → Onboarding
      context.go('/onboarding');
    } else if (authState is AuthAuthenticated) {
      // Already logged in → Home
      context.go('/home');
    } else {
      // Seen onboarding but not logged in → Login
      context.go('/login');
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
