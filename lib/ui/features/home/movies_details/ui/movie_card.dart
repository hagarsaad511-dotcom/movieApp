import 'package:flutter/material.dart';
import 'package:movie_app/data/model/response/movies_list_response.dart';
import 'package:movie_app/ui/core/themes/app_assets.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';

class MovieCard extends StatelessWidget {
  Movies movie;

   MovieCard({super.key, required this.movie});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      width: width*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(20),
               child: Image.network(movie.largeCoverImage??'', )),
          Container(
            margin:   EdgeInsets.all(8),
            width: width*0.155,
            height: height*0.04,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.ratingBgColor
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${movie.rating}'?? '', style: AppStyles.white14regular,),
                SizedBox(width: width*0.02,),
                Image.asset(AppAssets.ratingStar)
            
              ],
            ),
          )

        ],
      ),
    );

  }
}

class MovieCardSmall extends StatelessWidget {
  Movies movie;

  MovieCardSmall({super.key, required this.movie});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return
       Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.mediumCoverImage??'', )),
          Container(
            margin:   EdgeInsets.all(8),
            width: width*0.155,
            height: height*0.04,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.ratingBgColor
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${movie.rating}'?? '', style: AppStyles.white14regular,),
                SizedBox(width: width*0.02,),
                Image.asset(AppAssets.ratingStar)

              ],
            ),
          )

        ],
      );


  }
}








