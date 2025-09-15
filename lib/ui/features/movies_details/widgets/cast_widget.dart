import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';

import '../../../../data/model/response/movies_details_response.dart';

class CastWidget extends StatelessWidget {
  String characterImage;
  String castName;
 String  characterName;
   CastWidget({super.key, required this.characterImage,
     required this.characterName,
   required this.castName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height*0.01
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.mediumGrey
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(characterImage, fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.person, size: 80, color: Colors.grey); }),
            ),
          ),
          SizedBox(width: width*0.02,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(castName, style: AppStyles.white16regular,),
                Text(characterName, style: AppStyles.white16regular)
              ],
            ),
          )
        ],
      ),
    );
  }
}
