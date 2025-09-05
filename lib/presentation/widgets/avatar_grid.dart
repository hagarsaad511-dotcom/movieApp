import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ui/core/themes/app_colors.dart';

class AvatarGrid extends StatefulWidget {
  final void Function(String) onAvatarSelected;

  const AvatarGrid({Key? key, required this.onAvatarSelected}) : super(key: key);

  @override
  State<AvatarGrid> createState() => _AvatarGridState();
}

class _AvatarGridState extends State<AvatarGrid> {
  int? _selectedIndex;

  final List<String> avatars = const [
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
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: avatars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final path = avatars[index];
        final isSelected = _selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() => _selectedIndex = index);
            widget.onAvatarSelected(path);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.yellow : AppColors.mediumGrey,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.yellow, width: 2),
            ),
            padding: EdgeInsets.all(8.w),
            child: Center(
              child: Image.asset(path, width: 86.w, height: 86.h),
            ),
          ),
        );
      },
    );
  }
}
