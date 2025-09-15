import 'package:flutter/material.dart';
import 'package:movie_app/ui/features/browse/widgets/movies_categories.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../../../data/services/api_manager.dart';
import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key, });
  // static String searchScreenRouteName = AppRoutes.searchScreenRoute;
  // final  String? initialGenre;

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
          future: ApiManager.getMoviesList(),
          builder: (context, snapshot) {
            ///todo: Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mediumGrey,
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
            final categorizedMovies = categorizeMovies(movies);
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
            return MoviesByCategoryScreen(
                categorizedMovies: categorizedMovies,
              );

          },)
    );
  }
}
