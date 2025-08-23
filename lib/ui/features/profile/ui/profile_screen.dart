import 'package:flutter/material.dart';

import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String profileScreenRouteName = AppRoutes.profileScreenRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Profile' ,style: TextStyle(
          color: AppColors.whiteColor
      ),),
    );
  }
}
