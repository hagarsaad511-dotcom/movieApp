import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/core/themes/app_colors.dart';
import '../../l10n/gen/app_localizations.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/loading_button.dart';
import '../../../ui/core/utils/avatar_mapper.dart';
import 'stat_tile.dart';
import 'profile_nav_bar.dart';

class ProfileHeader extends StatelessWidget {
  final int wishCount;
  final int historyCount;
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const ProfileHeader({
    super.key,
    required this.wishCount,
    required this.historyCount,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user =
        state is AuthAuthenticated ? state.user : null;

        final avatarAsset = AvatarMapper.getAvatarAsset(user?.avatarId);
        final name = user?.name ?? 'Guest';

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 30.h),

              // Avatar + Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar + Name
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: AssetImage(avatarAsset),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        name,
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Wish List + History
                  Row(
                    children: [
                      StatTile(title: lang.wishList, count: wishCount),
                      SizedBox(width: 40.w),
                      StatTile(title: lang.history, count: historyCount),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Buttons row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 56.h,
                      child: LoadingButton(
                        text: lang.editProfile,
                        onPressed: () => context.push('/profile/update'),
                        backgroundColor: AppColors.yellow,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: () => context.read<AuthCubit>().logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang.exit,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            const Icon(Icons.exit_to_app,
                                color: AppColors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Nav bar
              ProfileNavBar(
                selectedIndex: selectedIndex,
                onTap: onTabChange,
              ),
            ],
          ),
        );
      },
    );
  }
}
