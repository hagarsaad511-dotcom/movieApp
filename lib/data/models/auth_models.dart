// import 'package:json_annotation/json_annotation.dart';
// import 'package:equatable/equatable.dart';
//
// part 'auth_models.g.dart';
//
// @JsonSerializable()
// class UserModel extends Equatable {
//   final int id;
//   final String name;
//   final String email;
//   final String? avatar;
//
//   const UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.avatar,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserModelToJson(this);
//
//   @override
//   List<Object?> get props => [id, name, email, avatar];
// }
//
// @JsonSerializable()
// class LoginRequest extends Equatable {
//   final String email;
//   final String password;
//
//   const LoginRequest({
//     required this.email,
//     required this.password,
//   });
//
//   factory LoginRequest.fromJson(Map<String, dynamic> json) =>
//       _$LoginRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
//
//   @override
//   List<Object> get props => [email, password];
// }
//
// @JsonSerializable()
// class LoginResponse extends Equatable {
//   final String token;
//   final UserModel user;
//
//   const LoginResponse({
//     required this.token,
//     required this.user,
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) =>
//       _$LoginResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
//
//   @override
//   List<Object> get props => [token, user];
// }
//
// @JsonSerializable()
// class RegisterRequest extends Equatable {
//   final String name;
//   final String email;
//   final String password;
//   @JsonKey(name: 'password_confirmation')
//   final String passwordConfirmation;
//
//   const RegisterRequest({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.passwordConfirmation,
//   });
//
//   factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
//       _$RegisterRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
//
//   @override
//   List<Object> get props => [name, email, password, passwordConfirmation];
// }
//
// @JsonSerializable()
// class RegisterResponse extends Equatable {
//   final String token;
//   final UserModel user;
//
//   const RegisterResponse({
//     required this.token,
//     required this.user,
//   });
//
//   factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
//       _$RegisterResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
//
//   @override
//   List<Object> get props => [token, user];
// }
//
// @JsonSerializable()
// class ResetPasswordRequest extends Equatable {
//   final String email;
//
//   const ResetPasswordRequest({
//     required this.email,
//   });
//
//   factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
//       _$ResetPasswordRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
//
//   @override
//   List<Object> get props => [email];
// }
//
// @JsonSerializable()
// class UpdateProfileRequest extends Equatable {
//   final String? name;
//   final String? email;
//   final String? avatar;
//
//   const UpdateProfileRequest({
//     this.name,
//     this.email,
//     this.avatar,
//   });
//
//   factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
//       _$UpdateProfileRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
//
//   @override
//   List<Object?> get props => [name, email, avatar];
// }