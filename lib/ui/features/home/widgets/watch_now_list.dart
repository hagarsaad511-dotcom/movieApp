import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/response/movies_list_response.dart';
import 'package:movie_app/routing/app_routes.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';


import '../../../core/themes/app_styles.dart';
import '../../browse/ui/browse_screen.dart';
import 'movie_card.dart';

// class WatchNowList extends StatelessWidget {
//   const WatchNowList({super.key, required this.movies});
//
//   final List<Movies> movies;
//
//   List uniqueGenres(List<Movies> movies) {
//     return movies
//         .expand((movie) => movie.genres ?? [])
//         .toSet()
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final genres = uniqueGenres(movies);
//     return ListView.separated(
//       itemBuilder: (context, index) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               genres[index],
//               style: AppStyles.white16regular,
//             ),
//
//           ],
//         );
//       },
//       separatorBuilder: (context, index) => const SizedBox(height: 20),
//       itemCount: genres.length,
//     );
//   }
// }

class WatchNowList extends StatefulWidget {
  const WatchNowList({super.key, required this.movies});

  final List<Movies> movies;

  @override
  State<WatchNowList> createState() => _WatchNowListState();
}

class _WatchNowListState extends State<WatchNowList> {
  List uniqueGenres(List<Movies> movies) {
    return movies.expand((movie) => movie.genres ?? []).toSet().toList();
  }

  List<Movies> moviesOfGenre(String genre) {
    return widget.movies.where((movie) => movie.genres?.contains(genre) ?? false).toList();
  }

  @override
  Widget build(BuildContext context) {
    final genres = uniqueGenres(widget.movies);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;


    return ListView.separated(
      itemCount: genres.length,
      separatorBuilder: (context, index) =>  SizedBox(height: height*0.01),
      itemBuilder: (context, index) {
        final genre = genres[index];
        final moviesForGenre = moviesOfGenre(genre).take(4).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                Text(
                  genre,
                  style: AppStyles.white16regular,
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    ///todo:navigation   to browse screen


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('See More', style: AppStyles.yellow16regular,),
                      Icon(Icons.arrow_forward_outlined, color: AppColors.yellow,)
                    ],
                  ),
                )

              ],
            ),
             SizedBox(height: height*0.02),
            SizedBox(
              height: height*0.2,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: moviesForGenre.length,
                separatorBuilder: (context, index) => SizedBox(width: width*0.04,),
                itemBuilder: (context, i) {
                  return MovieCardSmall(movie: moviesForGenre[i]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
