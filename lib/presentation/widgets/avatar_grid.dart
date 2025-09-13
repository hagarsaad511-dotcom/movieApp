import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ui/core/themes/app_colors.dart';
import '../../../ui/core/utils/avatar_mapper.dart';

class AvatarGrid extends StatefulWidget {
  /// Callback returns avatarId (1-based index)
  final void Function(int avatarId) onAvatarSelected;

  const AvatarGrid({Key? key, required this.onAvatarSelected}) : super(key: key);

  @override
  State<AvatarGrid> createState() => _AvatarGridState();
}

class _AvatarGridState extends State<AvatarGrid> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: AvatarMapper.count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final avatarId = index + 1; // 1-based
        final path = AvatarMapper.getAvatarAsset(avatarId);
        final isSelected = _selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() => _selectedIndex = index);
            widget.onAvatarSelected(avatarId);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.yellow.withOpacity(0.2)
                  : AppColors.mediumGrey,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? AppColors.yellow : Colors.transparent,
                width: 2,
              ),
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
