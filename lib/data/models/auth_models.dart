import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'auth_models.g.dart';

/// --------------------
/// UserModel
/// --------------------
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

  /// ✅ Firebase users only
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


  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static String _idFromJson(dynamic id) => id == null ? '' : id.toString();
  static dynamic _idToJson(String id) => id;

  @override
  List<Object?> get props =>
      [id, name, email, avatarId, phone, createdAt, updatedAt, photoUrl];
}

/// --------------------
/// LoginRequest
/// --------------------
@JsonSerializable()
class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [email, password];
}

/// --------------------
/// LoginResponse (normal login)
/// --------------------
@JsonSerializable()
class LoginResponse extends Equatable {
  final String message;
  @JsonKey(name: "data")
  final String token;

  const LoginResponse({required this.message, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [message, token];
}

/// --------------------
/// LoginResponseWithUser (Google login / extended)
/// --------------------
@JsonSerializable(explicitToJson: true)
class LoginResponseWithUser {
  final String message;
  @JsonKey(name: 'data')
  final LoginData data;

  const LoginResponseWithUser({required this.message, required this.data});

  factory LoginResponseWithUser.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseWithUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseWithUserToJson(this);

  String get token => data.token;
  UserModel? get user => data.user;
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  final String token;
  final UserModel? user;

  const LoginData({required this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

/// --------------------
/// RegisterRequest
/// --------------------
@JsonSerializable()
class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String password;
  @JsonKey(name: "confirmPassword")
  final String confirmPassword;
  final String lang;
  @JsonKey(name: "avaterId")
  final int avatarId;
  final String phone;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.lang,
    required this.avatarId,
    required this.phone,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  List<Object?> get props =>
      [name, email, password, confirmPassword, lang, avatarId, phone];
}

/// --------------------
/// RegisterResponse
/// --------------------
@JsonSerializable(explicitToJson: true)
class RegisterResponse extends Equatable {
  final String message;
  final UserModel? data;

  const RegisterResponse({required this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  List<Object?> get props => [message, data];
}

/// --------------------
/// ResetPasswordRequest
/// --------------------
@JsonSerializable()
class ResetPasswordRequest {
  final String oldPassword;
  final String newPassword;

  const ResetPasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}

/// --------------------
/// UpdateProfileRequest
/// --------------------
@JsonSerializable()
class UpdateProfileRequest extends Equatable {
  final String? name;
  final String? email;
  @JsonKey(name: "avaterId")
  final int? avatarId;
  final String? phone;

  const UpdateProfileRequest({this.name, this.email, this.avatarId, this.phone});

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (email != null) 'email': email,
    if (avatarId != null) 'avaterId': avatarId,
    if (phone != null) 'phone': phone,
  };

  @override
  List<Object?> get props => [name, email, avatarId, phone];
}
