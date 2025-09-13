import 'package:flutter/material.dart';
import '../../../ui/core/utils/avatar_mapper.dart';

class AvatarPicker extends StatefulWidget {
  /// Callback returns avatarId (1-based index)
  final Function(int) onAvatarSelected;

  const AvatarPicker({super.key, required this.onAvatarSelected});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  int _selectedAvatarIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.35);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial callback (1-based ID)
      widget.onAvatarSelected(_selectedAvatarIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _pageController,
        itemCount: AvatarMapper.count,
        onPageChanged: (index) {
          setState(() => _selectedAvatarIndex = index);
          widget.onAvatarSelected(index + 1);
        },
        itemBuilder: (context, index) {
          final avatarId = index + 1;
          final avatarPath = AvatarMapper.getAvatarAsset(avatarId);

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
                    backgroundImage: AssetImage(avatarPath),
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
