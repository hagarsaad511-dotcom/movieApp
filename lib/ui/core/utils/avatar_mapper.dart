class AvatarMapper {
  static const List<String> _avatars = [
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

  /// Expose all avatar asset paths
  static List<String> get all => _avatars;

  /// Total count (9)
  static int get count => _avatars.length;

  /// Return asset for a given avatarId (1-based index).
  /// Falls back to placeholder if invalid.
  static String getAvatarAsset(int? avatarId) {
    if (!isValidId(avatarId)) {
      return "assets/images/avatar_placeholder.png";
    }
    return _avatars[avatarId! - 1];
  }

  /// Check if an avatarId is valid (1..count)
  static bool isValidId(int? avatarId) {
    return avatarId != null && avatarId > 0 && avatarId <= _avatars.length;
  }
}
