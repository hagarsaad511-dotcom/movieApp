import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    viewModel.getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: BlocProvider<HomeScreenViewModel>(
        create: (context) => viewModel,
        child: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
          builder: (context, state) {
            if (state is HomeScreenLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.mediumGrey),
              );
            } else if (state is HomeScreenErrorState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.25),
                    Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      "Failed to load movies",
                      style: AppStyles.white20regular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      style: AppStyles.white20regular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: viewModel.getMoviesList,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                      ),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeScreenSuccessState) {
              final movies = state.movies;

              // 🔥 guard if empty list
              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    "No movies available right now",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Top gradient + image
                    Container(
                      height: height * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            movies[currentPage].largeCoverImage ?? "",
                          ),
                          onError: (_, __) {}, // 👌 prevents crashes
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(AppAssets.gradientBg),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.08),
                            Image.asset(AppAssets.availableNow),
                            SizedBox(height: height * 0.04),
                            SizedBox(
                              height: height * 0.3,
                              child: CarouselSlider.builder(
                                itemCount: movies.length,
                                itemBuilder: (context, index, _) {
                                  return InkWell(
                                    onTap: () {
                                      context.push('/movie-details/${movies[index].id}');
                                    },
                                    child: MovieCard(movie: movies[index]),
                                  );
                                },
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.4,
                                  onPageChanged: (index, reason) {
                                    setState(() => currentPage = index);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Watch now list
                    Container(
                      color: AppColors.primaryBlack,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(AppAssets.watchNow),
                          const SizedBox(height: 12),
                          WatchNowList(movies: movies),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            // Default safe fallback
            return const Center(
              child: Text("Welcome", style: TextStyle(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }
}




