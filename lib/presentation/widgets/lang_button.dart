import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/core/themes/app_colors.dart';

class LangButton extends StatelessWidget {
  final String langCode;
  final String asset;
  final bool isSelected; // Receive selection state from parent
  final VoidCallback? onPressed;

  // Customization
  final double size;
  final double padding;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;

  const LangButton({
    Key? key,
    required this.langCode,
    required this.asset,
    required this.isSelected, // Required parameter
    this.onPressed,
    this.size = 30,
    this.padding = 6,
    this.selectedBorderColor = AppColors.yellow,
    this.unselectedBorderColor = Colors.grey,
    this.selectedBorderWidth = 3,
    this.unselectedBorderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? selectedBorderColor : unselectedBorderColor,
            width: isSelected ? selectedBorderWidth : unselectedBorderWidth,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            asset,
            height: size.h,
            width: size.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}