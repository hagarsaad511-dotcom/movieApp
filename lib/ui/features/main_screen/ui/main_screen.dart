import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/ui/core/themes/app_colors.dart';
import 'package:movie_app/ui/features/browse/ui/browse_screen.dart';
import 'package:movie_app/ui/features/home/ui/home_screen.dart';
import 'package:movie_app/ui/features/search/ui/search_screen.dart';
import '../../../../presentation/screens/profile_screen.dart';
import '../../../core/themes/app_assets.dart';

class MainScreen extends StatefulWidget {
  final int initialTab;
  const MainScreen({super.key, this.initialTab = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> tabs = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTab;
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uri = GoRouterState.of(context).uri;
    final tabParam = uri.queryParameters['tab'];
    if (tabParam != null) {
      final newIndex = int.tryParse(tabParam) ?? 0;
      if (newIndex != selectedIndex) {
        setState(() {
          selectedIndex = newIndex;
          _pageController.jumpToPage(newIndex);
        });
      }
    }
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // disable swipe
          children: tabs,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            vertical: height * 0.01,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              backgroundColor: AppColors.mediumGrey,
              type: BottomNavigationBarType.fixed,
              items: [
                buildBottomNavigationBarItem(
                  index: 0,
                  selectedIcon: AppAssets.homeIconSelected,
                  unselectedIcon: AppAssets.homeIconUnselected,
                  label: 'Home',
                ),
                buildBottomNavigationBarItem(
                  index: 1,
                  selectedIcon: AppAssets.searchIconSelected,
                  unselectedIcon: AppAssets.searchIconUnselected,
                  label: 'Search',
                ),
                buildBottomNavigationBarItem(
                  index: 2,
                  selectedIcon: AppAssets.browseIconSelected,
                  unselectedIcon: AppAssets.browseIconUnselected,
                  label: 'Browse',
                ),
                buildBottomNavigationBarItem(
                  index: 3,
                  selectedIcon: AppAssets.profileIconSelected,
                  unselectedIcon: AppAssets.profileIconUnselected,
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() => selectedIndex = index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required int index,
    required String unselectedIcon,
    required String selectedIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Image.asset(
        index == selectedIndex ? selectedIcon : unselectedIcon,
      ),
    );
  }
}