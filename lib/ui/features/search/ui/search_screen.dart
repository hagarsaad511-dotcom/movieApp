import 'package:flutter/material.dart';
import 'package:movie_app/data/services/api_manager.dart';

import '../../../../data/model/response/movies_list_response.dart';
import '../../../../routing/app_routes.dart';
import '../../../core/themes/app_assets.dart';
import '../../../core/themes/app_colors.dart';

///todo: back to original
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});
//   static String searchScreenRouteName = AppRoutes.searchScreenRoute;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text('Search', style: TextStyle(
//           color: AppColors.white
//       ),),
//     );
//   }
// }




import '../../home/widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {

   // نمرر ليستة كل الأفلام هنا

  const SearchScreen({super.key }) ;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   late List<Movies> moviesList;
  List<Movies> filteredMovies = [];
   String query = "";

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void>loadMovies () async {
    final response = await ApiManager.getMoviesList();
    moviesList = response.data!.movies! ;
    setState(() {

    });

  }



  void updateSearch(String text) {
    setState(() {
      query = text;
      filteredMovies = moviesList
          .where((movie) =>
      movie.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // TextField للبحث
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                print("search for: $value");
                updateSearch(value);
              } ,
            ),
          ),

          // عرض النتائج
          Expanded(
            child: filteredMovies.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.emptySearchImage)

                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عمودين
                childAspectRatio: 0.65, // مقاس الكارد
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: filteredMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}