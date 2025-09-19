import 'package:flutter/material.dart';
import 'package:movie_app/ui/features/browse/widgets/movies_categories.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../../../data/services/api_manager.dart';
import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';

class BrowseScreen extends StatefulWidget {
  final String? initialGenre; // optional genre filter
  const BrowseScreen({super.key, this.initialGenre});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: FutureBuilder<MoviesListResponse?>(
        future: ApiManager.getMoviesList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mediumGrey),
            );
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error.toString());
          }

          final data = snapshot.data;
          if (data == null || data.status != 'ok') {
            return _buildError(data?.statusMessage ?? "Unknown error occurred");
          }

          final movies = data.data?.movies ?? [];
          final categorizedMovies = categorizeMovies(movies);

          return MoviesByCategoryScreen(
            categorizedMovies: categorizedMovies,
            initialGenre: widget.initialGenre,
          );
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: AppStyles.white20regular),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Try Again", style: AppStyles.yellow16regular),
          ),
        ],
      ),
    );
  }
}

