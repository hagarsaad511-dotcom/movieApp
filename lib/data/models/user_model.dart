import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  @JsonKey(name: '_id', fromJson: _idFromJson, toJson: _idToJson)
  final String id;

  final String name;
  final String email;

  @JsonKey(name: 'avaterId') // backend typo
  final int? avatarId;

  final String? phone;
  final String? createdAt;
  final String? updatedAt;

  /// ✅ Firebase-only
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarId,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.photoUrl,
  });

  /// ✅ Factory for Firebase user mapping
  factory UserModel.fromFirebase({
    required String uid,
    required String email,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
  }) {
    final now = DateTime.now().toIso8601String();
    return UserModel(
      id: uid,
      name: displayName ?? "Guest",
      email: email,
      avatarId: null,
      phone: phoneNumber,
      createdAt: now,
      updatedAt: now,
      photoUrl: photoUrl,
    );
  }

  /// ✅ Handles both raw `{...}` and wrapped `{ data: {...} }`
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'] ?? json;

    return UserModel(
      id: data['_id']?.toString() ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      avatarId: data['avatarId'] ?? data['avaterId'] ?? 0,
      phone: data['phone'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static String _idFromJson(dynamic id) => id == null ? '' : id.toString();
  static dynamic _idToJson(String id) => id;

  @override
  List<Object?> get props =>
      [id, name, email, avatarId, phone, createdAt, updatedAt, photoUrl];
}
