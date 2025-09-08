import 'package:flutter/material.dart';

class AvatarPicker extends StatefulWidget {
  final Function(int) onAvatarSelected;
  const AvatarPicker({super.key, required this.onAvatarSelected});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  int _selectedAvatarIndex = 0;

  final PageController _pageController = PageController(viewportFraction: 0.35);

  final List<String> _defaultAvatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar 4.png",
    "assets/images/avatar 5.png",
    "assets/images/avatar 6.png",
    "assets/images/avatar 7.png",
    "assets/images/avatar 8.png",
    "assets/images/avatar 9.png",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAvatarSelected(_selectedAvatarIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _defaultAvatars.length,
        onPageChanged: (index) {
          setState(() {
            _selectedAvatarIndex = index;
          });
          widget.onAvatarSelected(index + 1);
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = (_pageController.page! - index).abs();
                value = (1 - (value * 0.3)).clamp(0.7, 1.0);
              }
              return Center(
                child: Transform.scale(
                  scale: value,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(_defaultAvatars[index]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
