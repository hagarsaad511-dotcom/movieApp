import 'package:equatable/equatable.dart';

class User extends Equatable {
  /// Always a string (Mongo `_id` OR Firebase `uid`)
  final String id;
  final String name;
  final String email;

  /// Backend-specific (Mongo). Firebase users won’t have this.
  final int? avatarId;

  /// Common field (Firebase phoneNumber or backend phone)
  final String? phone;

  /// Dates (Mongo backend). Null for Firebase-only users.
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Optional photo URL (Firebase provides this, backend does not).
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarId,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.photoUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? avatarId,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarId: avatarId ?? this.avatarId,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  /// Convert to JSON (backend format, keep typo `avaterId`)
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avaterId': avatarId,
    'phone': phone,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'photoUrl': photoUrl,
  };

  /// Factory for backend JSON (Mongo-style)
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: (json['id'] ?? json['_id'] ?? '').toString(),
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    avatarId: json['avaterId'] as int?,
    phone: json['phone'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
    photoUrl: json['photoUrl'] as String?, // optional
  );

  /// Factory for Firebase user
  factory User.fromFirebase({
    required String uid,
    required String email,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return User(
      id: uid,
      name: displayName ?? 'Guest',
      email: email,
      phone: phoneNumber,
      photoUrl: photoUrl,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, email, avatarId, phone, createdAt, updatedAt, photoUrl];
}
