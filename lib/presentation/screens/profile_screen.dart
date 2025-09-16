import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../../../ui/core/themes/app_colors.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  int wishCount = 12;
  int historyCount = 10;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getCurrentUser();
  }

  Widget _historyGrid() {
    final posters =
    List.generate(12, (i) => 'assets/images/poster_${(i % 6) + 1}.jpg');
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: posters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (ScreenUtil().screenWidth > 600) ? 4 : 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            posters[index],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.darkGrey,
              child: const Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
        );
      },
    );
  }

  Widget _watchListPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/watchlist.png"),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlack,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.yellow),
            onPressed: () {
              // ✅ Navigate inside the PageView flow
              context.push('/profile/update');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 18.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    ProfileHeader(
                      wishCount: wishCount,
                      historyCount: historyCount,
                      selectedIndex: selectedIndex,
                      onTabChange: (index) =>
                          setState(() => selectedIndex = index),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: IndexedStack(
                        index: selectedIndex,
                        children: [
                          _watchListPlaceholder(),
                          _historyGrid(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
