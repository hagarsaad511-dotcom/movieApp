import 'package:flutter/material.dart';

import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static String searchScreenRouteName = AppRoutes.searchScreenRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Search', style: TextStyle(
          color: AppColors.whiteColor
      ),),
    );
  }
}
