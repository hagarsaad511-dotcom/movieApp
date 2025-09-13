import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/services/api_manager.dart';
import 'package:movie_app/ui/core/themes/app_assets.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';
import 'package:movie_app/ui/features/home/cubit/home_screen_states.dart';
import 'package:movie_app/ui/features/home/view_model/home_screen_view_model.dart';
import 'package:movie_app/ui/features/movies_details/ui/movie_details.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../../../routing/app_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/movie_card.dart';
import '../widgets/watch_now_list.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen({super.key,});
  static String homeScreenRouteName = AppRoutes.homeScreenRoute;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();
  int currentPage = 0;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMoviesList();
  }
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
      body: BlocProvider<HomeScreenViewModel>(
        create: (context) => viewModel,
        child: BlocBuilder<HomeScreenViewModel,HomeScreenStates>(
            builder: (context, state) {
           if (state is HomeScreenLoadingState){
             return Center(
                 child: CircularProgressIndicator(
                 color: AppColors.mediumGrey,
                ),
                 );
           }
           else if (state is HomeScreenErrorState){
             return Column(
                children: [
                         Text(state.errorMessage,
                            style: AppStyles.white20regular),
                             ElevatedButton(
                           onPressed: () {
                             viewModel.getMoviesList();
                           },
                          child: Text('Try Again',
                            style: AppStyles.yellow16regular,),
                        )
                     ],
                   );

           }
           else if(state is HomeScreenSuccessState){
             return
             Stack(
             children: [
             AnimatedSwitcher(
             duration: Duration(milliseconds: 500),
             child: Container(
             key: ValueKey(currentPage),
             height: height*0.6,
             decoration: BoxDecoration(
             image: DecorationImage(
             fit: BoxFit.cover,
             image: NetworkImage(state.movies[currentPage].largeCoverImage ?? '',
             ),
             )
             ),
             ) ,),
             Image.asset(AppAssets.gradientBg,),
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
    return
    InkWell(
    onTap: () {
    Navigator.of(context).pushNamed(AppRoutes.movieDetailsScreenRoute,
    arguments: state.movies[index].id);
    },
    child:
    MovieCard(movie: state.movies[index]));
    },
    itemCount: state.movies.length,
    options: CarouselOptions(
    enlargeCenterPage: true,
    viewportFraction: 0.4,
    aspectRatio: 2.0,
    initialPage: 0,
    onPageChanged: (index, reason) {
    currentPage = index;
    setState(() {

    });
    },
    ),
    )


    ),
    SizedBox(height: height*0.05 ,),
    Image.asset(AppAssets.watchNow),
    SizedBox(height: height*0.01 ,),
    Expanded(child: WatchNowList(movies: state.movies))





    ],
    ),
    )


    ],
    );}
           return Container();
            },),
      ),


    );
  }
}




