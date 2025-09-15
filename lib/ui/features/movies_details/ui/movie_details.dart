import 'package:flutter/material.dart';
import 'package:movie_app/data/model/response/movies_details_response.dart';
import 'package:movie_app/ui/core/themes/app_assets.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';
import 'package:movie_app/ui/features/movies_details/widgets/cast_widget.dart';
import 'package:movie_app/ui/features/movies_details/widgets/movie_data.dart';
import 'package:movie_app/ui/features/movies_details/widgets/screenshot_widget.dart';

import '../../../../data/services/api_manager.dart';
import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_colors.dart';

import '../widgets/genres_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  // static String movieDetailsScreenRouteName = AppRoutes.movieDetailsScreenRoute;

   MovieDetailsScreen({super.key, required String movieId, });


  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    int movieID = ModalRoute.of(context)?.settings.arguments as int;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<MoviesDetailsResponse>(
        future: ApiManager.getMovieDetails(movieID),
        builder: (context, snapshot) {
          ///todo: loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.lightGrey,
              ),
            );
          }
          ///todo: error=> client
           else if(snapshot.hasError){
            return Column(
               children: [
                Text('Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Colors.white
                  )
                  ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Try Again', style: Theme.of(context).textTheme.labelMedium),
                )
              ],
            );
          };
          ///todo: server => response => success, error
          ///todo: server => error
          if( snapshot.data?.status != 'ok'){
            return Column(
              children: [
                Text(snapshot.data!.statusMessage!,
                  style: Theme.of(context).textTheme.labelMedium,),
                ElevatedButton(
                  onPressed: (){
                    ApiManager.getMovieDetails(movieID);
                    setState(() {

                    });
                  },
                  child: Text('Try Again Later', style: Theme.of(context).textTheme.labelMedium),
                )
              ],
            );
          }
          ///todo: server=> success
          final movie = snapshot.data?.data?.movie;
          final castList = movie?.cast ?? [];
          final genresList = movie?.genres ?? [];

          return
            Scaffold(
              // appBar: AppBar(
              //   title: Text(movie?.title?? 'No title', style: TextStyle(
              //     color: Colors.black
              //   ),),
              // ),
              body: ListView(
                children: [
                  Stack(
                    children: [
                      Image.network(movie?.largeCoverImage ?? ''),
                      Image.asset(AppAssets.movieDetailGradient),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 30,),
                                  ),
                                Image.asset(AppAssets.saveIcon),
                              ],
                            ),
                            SizedBox(height: height*0.2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppAssets.watchIcon),
                              ],
                            ),
                            SizedBox(height: height*0.2,),
                            Text(movie?.titleEnglish ?? '', style: AppStyles.white20Bold,),
                            SizedBox(height: height*0.02,),
                            Text('${movie?.year} '?? '', style: AppStyles.white20Bold,),
                            SizedBox(height: height*0.02,),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                              child: Text('Watch', style: AppStyles.white20Bold, textAlign: TextAlign.center,),
                            ),
                            SizedBox(height: height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MovieData(data: movie?.likeCount, iconPath: AppAssets.likeIcon),
                                MovieData(data: movie?.runtime, iconPath: AppAssets.movieTime),
                                MovieData(data: movie?.rating, iconPath: AppAssets.rateIcon)
                              ],
                            ),
                            SizedBox(height: height*0.02,),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Text('ScreenShots', style: AppStyles.white20Bold,),
                               ],
                             ),
                            SizedBox(height: height*0.01,),
                            ScreenshotWidget(screenshotPath: movie?.largeScreenshotImage1 ?? ''),
                            ScreenshotWidget(screenshotPath: movie?.largeScreenshotImage2 ?? ''),
                            ScreenshotWidget(screenshotPath: movie?.largeScreenshotImage3 ?? ''),
                            SizedBox(height: height*0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Cast', style: AppStyles.white20Bold,),
                              ],
                            ),
                            ... castList.map((cast) {
                               return CastWidget(
                                   characterImage: cast.urlSmallImage ?? '',
                                 castName: 'Name : ${cast.name} ' ?? '',
                                   characterName: 'Character Name: ${cast.characterName}'  ?? '',
                                   ) ;
                             }).toList(),
                            SizedBox(height: height*0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Genres', style: AppStyles.white20Bold,),
                              ],
                            ),
                            SizedBox(height: height*0.02,),
                            if (genresList.isNotEmpty)
                              GridView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 3,
                                ),
                                children: genresList.map((genre) {
                                  return GenresWidget(genre: genre);
                                }).toList(),
                              )
                            else
                              Text("No genres found", style: TextStyle(color: Colors.white),),


                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            );
        } );
  }
}
