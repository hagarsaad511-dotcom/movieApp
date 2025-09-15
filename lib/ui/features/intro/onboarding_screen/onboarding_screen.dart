import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/ui/core/themes/app_assets.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/core/themes/app_styles.dart';

import '../../../../routing/app_routes.dart';


class OnboardingScreen extends StatefulWidget {
  // static String onboardingScreenRouteName = AppRoutes.onboardingScreenRoute;
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppAssets.onboardingPosterOne,
      "title": "Find Your Next Favorite Movie Here",
      "description":
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": AppAssets.onboardingPosterTwo,
      "title": "Discover Movies",
      "description":
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    },
    {
      "image": AppAssets.onboardingPosterThree,
      "title": "Explore All Genres",
      "description":
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": AppAssets.onboardingPosterFour,
      "title": "Create Watchlist",
      "description":
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    },
    {
      "image": AppAssets.onboardingPosterFive,
      "title": "Rate, Review, and Learn",
      "description":
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": AppAssets.onboardingPosterSix,
      "title": "Start Watching Now",
      "description":
      "",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {

      // Navigator.of(context).pushNamed(AppRoutes.mainScreenRoute)
    context.go('/login')

      ;
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
      setState(() {
        _currentPage = index;
      });
    },
    itemBuilder: (context, index) {
    return Container(
    color: AppColors.primaryBlack,
    child: Column(
    children: [
    Expanded(
    child: Image.asset(
    onboardingData[index]["image"]!,
    fit: BoxFit.cover,
    width: double.infinity,
    ),
    ),
    Container(
    padding: EdgeInsets.symmetric(
      vertical: height*0.04,
      horizontal: width*0.02
    ),
    decoration: const BoxDecoration(
    color: AppColors.primaryBlack,
    borderRadius:
    BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
    children: [
    Text(
    onboardingData[index]["title"]!,
    style: AppStyles.white24BoldInter,
    textAlign: TextAlign.center,
    ),
     SizedBox(height: height*0.02),
    Text(
    onboardingData[index]["description"]!,
    style:AppStyles.white20regularInter,
    textAlign: TextAlign.center,
    ),
     SizedBox(height: height*0.01),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
      ElevatedButton(

      style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.yellow,
      foregroundColor: AppColors.primaryBlack,
        padding: EdgeInsets.symmetric(
          vertical: 15
        ),

      ),
      onPressed: _nextPage,
      child: Text(
      _currentPage == onboardingData.length - 1
      ? "Done"
          : _currentPage == 0 ?
      "Explore All"
          :
      "Next",
       style: AppStyles.black20SemiBoldInter,),
      ),
          SizedBox(height: height*0.02), // placeholder

      if (_currentPage > 0)
      OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 15),
      side:  BorderSide(color: AppColors.yellow),
      foregroundColor: AppColors.yellow,
      ),
      onPressed: _prevPage,
      child:  Text("Back", style: AppStyles.yellow20SemiBoldInter,),
      )

        ],
      ),


    ],
    ),
    ),
    ],
    ),
    );
    },
        ),
    );
  }
}