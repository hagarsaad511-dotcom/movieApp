import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ui/core/themes/app_colors.dart';

class StatTile extends StatelessWidget {
  final String title;
  final int count;

  const StatTile({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count',
            style: GoogleFonts.roboto(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            )),
        SizedBox(height: 6.h),
        Text(title,
            style: GoogleFonts.roboto(
              fontSize: 18.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
