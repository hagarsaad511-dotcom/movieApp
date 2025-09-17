import 'package:flutter/material.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../home/widgets/movie_card.dart';

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

class MoviesByCategoryScreen extends StatefulWidget {
  final Map<String, List<Movies>> categorizedMovies;
  final String? initialGenre;

  const MoviesByCategoryScreen({
    super.key,
    required this.categorizedMovies,
    this.initialGenre,
  });

  @override
  State<MoviesByCategoryScreen> createState() => _MoviesByCategoryScreenState();
}

class _MoviesByCategoryScreenState extends State<MoviesByCategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _tabScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final genres = widget.categorizedMovies.keys.toList();
    final initialIndex = widget.initialGenre != null && genres.contains(widget.initialGenre)
        ? genres.indexOf(widget.initialGenre!)
        : 0;

    _tabController = TabController(
      length: genres.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    // Schedule auto-scroll after the layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialTab(initialIndex, genres);
    });
  }

  void _scrollToInitialTab(int index, List<String> genres) {
    if (_tabScrollController.hasClients && index > 0) {
      // Calculate approximate position to scroll to
      final double scrollPosition = (index * 100) - 100; // Adjust 100 based on your tab width
      _tabScrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final genres = widget.categorizedMovies.keys.toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable TabBar with controller
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                controller: _tabScrollController,
                scrollDirection: Axis.horizontal,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primaryBlack,
                  unselectedLabelColor: AppColors.yellow,
                  indicator: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  isScrollable: true,
                  tabs: genres.map((genre) =>
                      Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(genre),
                        ),
                      )).toList(),
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: genres.map((genre) {
                  final moviesInGenre = widget.categorizedMovies[genre]!;
                  return GridView.builder(
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
        ),
      ),
    );
  }
}