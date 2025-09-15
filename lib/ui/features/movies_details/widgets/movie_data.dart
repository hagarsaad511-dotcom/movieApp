import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';

class MovieData extends StatelessWidget {
  var data;
  String iconPath;
   MovieData({super.key, required this.data, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;;
    return Container(
      width: width*0.12,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(
        vertical: height*0.01,
        // horizontal: width*0.01
    ),
    decoration: BoxDecoration(
      color: AppColors.mediumGrey,
    borderRadius: BorderRadius.circular(16),
    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(iconPath),
          Text(data.toString(), style: AppStyles.white24Bold,),
        ],
      ),
    );
  }
}
