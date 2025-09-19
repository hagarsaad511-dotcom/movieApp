import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return widget.movies
        .where((movie) => movie.genres?.contains(genre) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final genres = uniqueGenres(widget.movies);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ListView.separated(
      shrinkWrap: true, // ✅ auto-size to content
      physics: const NeverScrollableScrollPhysics(), // ✅ delegate scroll to parent
      itemCount: genres.length,
      separatorBuilder: (context, index) => SizedBox(height: height * 0.02),
      itemBuilder: (context, index) {
        final genre = genres[index];
        final moviesForGenre = moviesOfGenre(genre).take(4).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Genre title + See More
            Row(
              children: [
                Text(genre, style: AppStyles.white16regular),
                const Spacer(),
                InkWell(
                  onTap: () {
                    context.push('/browse', extra: genre); // pass genre string
                  },
                  child: Row(
                    children: [
                      Text("See More", style: AppStyles.yellow16regular),
                      const Icon(Icons.arrow_forward_outlined, color: AppColors.yellow),
                    ],
                  ),
                ),


              ],
            ),
            SizedBox(height: height * 0.02),

            /// Horizontal movies for this genre
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 160,
                maxHeight: 220, // keeps cards consistent
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: moviesForGenre.length,
                separatorBuilder: (context, i) =>
                    SizedBox(width: width * 0.04),
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
