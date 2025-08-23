import 'package:flutter/material.dart';
import 'package:movie_app/data/services/api_manager.dart';
import 'package:movie_app/ui/core/themes/app_assets.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';
import 'package:movie_app/ui/features/home/movies_details/ui/movie_card.dart';
import 'package:movie_app/ui/features/home/movies_details/ui/watch_now_list.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../../../routing/app_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen({super.key,});
  static String homeScreenRouteName = AppRoutes.homeScreenRoute;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<int> carouselIndexNotifier = ValueNotifier<int>(0);
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
    final controller = CarouselSliderController();

    return Scaffold(
        body: FutureBuilder(
          future: ApiManager.getMoviesList(),
          builder: (context, snapshot) {
            ///todo: Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.greyColor,
                ),
              );
            }
            ///todo: client => error
            else if (snapshot.hasError) {
              return Column(
                children: [
                  Text('${snapshot.error}',
                      style: AppStyles.white20regular),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Try Again',
                      style: AppStyles.yellow16regular,),
                  )
                ],
              );
            };

            ///todo: server => error

            final movies = snapshot.data?.data?.movies ?? [];
            if (snapshot.data?.status != 'ok') {
              return Column(
                children: [
                  Text(snapshot.data!.statusMessage!,
                      style: AppStyles.white20regular),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.getMoviesList();
                      setState(() {

                      });
                    },
                    child: Text('Try Again',
                        style: AppStyles.white20regular),
                  )
                ],
              );
            }
            ///todo: server =>success
            return
              Stack(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(AppAssets.availableNow),
                      SizedBox(height: height*0.05 ,),
                      SizedBox(
                        height: height*0.3,
                        child: CarouselSlider.builder(
                          itemBuilder: (context, index, realIndex) {
                            return MovieCard(movie: movies[index]);
                          },
                          itemCount: movies.length,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            viewportFraction: 0.4,
                            aspectRatio: 2.0,
                            initialPage: 2,
                            // onPageChanged: (index, reason) {
                            //   carouselIndexNotifier.value = index;
                            //   setState(() {
                            //
                            //   });
                            // },
                          ),
                        )


                      ),
                      SizedBox(height: height*0.05 ,),
                      Image.asset(AppAssets.watchNow),
                      SizedBox(height: height*0.01 ,),
                      Expanded(child: WatchNowList(movies: movies))





                    ],
                  ),
                )

              ]

            );
          },)
    );
  }
}