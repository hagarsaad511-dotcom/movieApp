import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';

part 'auth_models.g.dart';

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
/// LoginResponse (normal login → returns token only)
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
/// LoginResponseWithUser (Google login / extended login)
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
