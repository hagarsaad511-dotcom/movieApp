import 'package:flutter/material.dart';

class AvatarPicker extends StatefulWidget {
  final Function(String) onAvatarSelected; // returns the selected avatar path

  const AvatarPicker({super.key, required this.onAvatarSelected});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  String? _selectedAvatar;

  final PageController _pageController = PageController(viewportFraction: 0.35);

  // Example default avatars (place them in assets/images/avatars/)
  final List<String> _defaultAvatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    
  ];

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _defaultAvatars[0]; // default first avatar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAvatarSelected(_selectedAvatar!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // enough space for zoomed avatar
      child: PageView.builder(
        controller: _pageController,
        itemCount: _defaultAvatars.length,
        onPageChanged: (index) {
          setState(() {
            _selectedAvatar = _defaultAvatars[index];
          });
          widget.onAvatarSelected(_defaultAvatars[index]);
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = (_pageController.page! - index).abs();
                value = (1 - (value * 0.3)).clamp(0.7, 1.0); // scale effect
              }
              return Center(
                child: Transform.scale(
                  scale: value,
                  child: CircleAvatar(
                    radius: 40,
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
