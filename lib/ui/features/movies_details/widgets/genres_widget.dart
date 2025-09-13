import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';

class GenresWidget extends StatelessWidget {
  String genre;
   GenresWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8
      ),
      decoration: BoxDecoration(
        color: AppColors.mediumGrey,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text(genre, style: AppStyles.white16regular, textAlign: TextAlign.center),
    );
  }
}
