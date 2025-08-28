import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/core/themes/app_colors.dart';
import '../screens/language_provider.dart'; // <-- update path if yours differs

class LangButton extends StatelessWidget {
  final String langCode;
  final String asset;
  final VoidCallback? onPressed;

  // Customization
  final double size; // flag size
  final double padding; // inner padding
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;

  const LangButton({
    Key? key,
    required this.langCode,
    required this.asset,
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
    // Use current app locale instead of a provider field that may not exist
    final String currentCode = Localizations.localeOf(context).languageCode;
    final bool isSelected = currentCode == langCode;

    // We only need the provider to change language, not to listen for rebuilds
    final langProvider = context.read<LanguageProvider>();

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          langProvider.setLang(langCode);
        }
      },
      child: Container(
        padding: EdgeInsets.all(padding.r), // radius-friendly scaling
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
