class AvatarMapper {
  static const List<String> _avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];
  static List<String> get all => _avatars;

  static String getAvatarAsset(int? avatarId) {
    if (avatarId == null || avatarId <= 0 || avatarId > _avatars.length) {
      return "assets/images/avatar_placeholder.png";
    }
    return _avatars[avatarId - 1]; // IDs are 1-based
  }
}
