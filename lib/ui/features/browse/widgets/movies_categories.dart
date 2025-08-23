import 'package:flutter/material.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../home/movies_details/ui/movie_card.dart';

///todo: function to categorize movies by category and return map { key 'category: value ' List<Movies>'}

Map<String, List<Movies>> categorizeMovies(List<Movies> movies) {
  Map<String, List<Movies>> map = {};

  for (var movie in movies) {
    for (var genre in movie.genres ?? []) {
      if (map.containsKey(genre)) {
        map[genre]!.add(movie);
      } else {
        map[genre] = [movie];
      }
    }
  }

  return map;
}

class MoviesByCategoryScreen extends StatelessWidget {
  final Map<String, List<Movies>> categorizedMovies;

  const MoviesByCategoryScreen({super.key, required this.categorizedMovies});

  @override
  Widget build(BuildContext context) {
    final genres = categorizedMovies.keys.toList();

    return DefaultTabController(
      length: genres.length,
      child: Scaffold(

        body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: genres.map((genre) => Tab(text: genre)).toList(),
                ),

                Expanded(
                  child: TabBarView(
                    children: genres.map((genre) {
                      final moviesInGenre = categorizedMovies[genre]!;
                      return
                        GridView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: moviesInGenre.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final movie = moviesInGenre[index];
                            return MovieCard(movie: movie);
                          },
                        );

                    }).toList(),
                  ),
                ),
              ],
            ))


      ),
    );
  }
}
